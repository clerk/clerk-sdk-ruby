# frozen_string_literal: true

module Clerk
  ##
  # This class represents a service object used to determine the current request state
  # for the current env passed based on a provided Clerk::AuthenticateContext.
  # There is only 1 public method exposed (`resolve`) to be invoked with a env parameter.
  class AuthenticateRequest
    attr_reader :auth_context

    ##
    # Creates a new instance using Clerk::AuthenticateContext object.
    def initialize(auth_context)
      @auth_context = auth_context
    end

    ##
    # Determines the current request state by verifying a Clerk token in headers or cookies.
    # The possible outcomes of this method are `signed-in`, `signed-out` or `handshake` states.
    # The return values are the same as a return value of a rack middleware `[http_status_code, headers, body]`.
    # When used in a middleware the consumer of this service should return the return value when there is an
    # `http_status_code` provided otherwise the should continue with the middleware chain.
    # The headers provided in the return value is a hash of { header_key => header_value } and in the case
    # of a `Set-Cookie` header the `header_value` used is a list of raw HTTP Set-Cookie directives.
    def resolve(env)
      if auth_context.session_token_in_header?
        resolve_header_token(env)
      else
        resolve_cookie_token(env)
      end
    end

    protected

    def resolve_header_token(env)
      begin
        # malformed JWT
        unless sdk.decode_token(auth_context.session_token_in_header)
          return signed_out(reason: TokenVerificationErrorReason::TOKEN_INVALID)
        end

        claims = verify_token(auth_context.session_token_in_header)
        return signed_in(env, claims, auth_context.session_token_in_header) if claims
      rescue JWT::DecodeError
        # malformed JSON authorization header
        return signed_out(reason: TokenVerificationErrorReason::TOKEN_INVALID)
      rescue JWT::ExpiredSignature
        return signed_out(enforce_auth: true, reason: TokenVerificationErrorReason::TOKEN_EXPIRED)
      rescue JWT::InvalidIatError
        return signed_out(enforce_auth: true, reason: TokenVerificationErrorReason::TOKEN_NOT_ACTIVE_YET)
      end

      # Clerk.js should refresh the token and retry
      signed_out(enforce_auth: true)
    end

    def resolve_cookie_token(env)
      # in cross-origin XHRs the use of Authorization header is mandatory.
      # TODO: add reason
      return signed_out if auth_context.cross_origin_request?

      return resolve_handshake(env) if auth_context.handshake_token?

      if auth_context.development_instance? && !!auth_context.dev_browser_in_url
        return handle_handshake_maybe_status(env, reason: AuthErrorReason::DEV_BROWSER_SYNC)
      end

      if auth_context.development_instance? && !auth_context.dev_browser?
        return handle_handshake_maybe_status(env, reason: AuthErrorReason::DEV_BROWSER_MISSING)
      end

      # TODO(dimkl): Add multi-domain support for production
      # if auth_context.production_instance? && auth_context.eligible_for_multi_domain?
      # return handle_handshake_maybe_status(env, reason: AuthErrorReason::SATELLITE_COOKIE_NEEDS_SYNCING)
      # end

      # TODO(dimkl): Add multi-domain support for development
      # if auth_context.development_instance? && auth_context.eligible_for_multi_domain?
      # trigger handshake using auth_context.sign_in_url as base redirect_url
      # return handle_handshake_maybe_status(env, reason: AuthErrorReason::SATELLITE_COOKIE_NEEDS_SYNCING, '', headers)
      # end

      # TODO(dimkl): Add multi-domain support for development in primary
      # if auth_context.development_instance? && !auth_context.is_satellite? && auth_context.clerk_redirect_url
      # trigger handshake using auth_context.clerk_redirect_url as base redirect_url + mark it as clerk_synced
      # return handle_handshake_maybe_status(env, reason: AuthErrorReason::PRIMARY_RESPONDS_TO_SYNCING, '', headers)
      # end

      if !auth_context.active_client? && !auth_context.session_token_in_cookie?
        return signed_out(reason: AuthErrorReason::SESSION_TOKEN_AND_UAT_MISSING)
      end

      # This can eagerly run handshake since client_uat is SameSite=Strict in dev
      if !auth_context.active_client? && auth_context.session_token_in_cookie?
        return handle_handshake_maybe_status(env, reason: AuthErrorReason::SESSION_TOKEN_WITHOUT_CLIENT_UAT)
      end

      if auth_context.active_client? && !auth_context.session_token_in_cookie?
        return handle_handshake_maybe_status(env, reason: AuthErrorReason::CLIENT_UAT_WITHOUT_SESSION_TOKEN)
      end

      begin
        token = verify_token(auth_context.session_token_in_cookie)
        return signed_out unless token

        if token['iat'] < auth_context.client_uat.to_i
          return handle_handshake_maybe_status(env, reason: AuthErrorReason::SESSION_TOKEN_OUTDATED)
        end

        return signed_in(env, token, auth_context.session_token_in_cookie)
      rescue JWT::ExpiredSignature
        return handshake(env, reason: TokenVerificationErrorReason::TOKEN_EXPIRED)
      rescue JWT::InvalidIatError
        return handshake(env, reason: TokenVerificationErrorReason::TOKEN_NOT_ACTIVE_YET)
      end

      signed_out
    end

    def resolve_handshake(env)
      headers = {
        'Access-Control-Allow-Origin' => 'null',
        'Access-Control-Allow-Credentials' => 'true'
      }

      session_token = ''

      # Return signed-out outcome if the handshake verification fails
      handshake_payload = verify_token(auth_context.handshake_token)
      unless handshake_payload
        return signed_out(enforce_auth: true,
                          reason: TokenVerificationErrorReason::JWK_FAILED_TO_RESOLVE)
      end

      # Retrieve the cookie directives included in handshake token payload and convert it to set-cookie headers
      # Also retrieve the session token separately to determine the outcome of the request
      cookies_to_set = handshake_payload[HANDSHAKE_COOKIE_DIRECTIVES_KEY] || []
      cookies_to_set.each do |cookie|
        headers[COOKIE_HEADER] ||= []
        headers[COOKIE_HEADER] << cookie

        session_token = cookie.split(';')[0].split('=')[1] if cookie.start_with?("#{SESSION_COOKIE}=")
      end

      # Clear handshake token from query params and set headers to redirect to the initial request url
      if auth_context.development_instance?
        redirect_url = auth_context.clerk_url.dup
        remove_from_query_string(redirect_url, HANDSHAKE_COOKIE)

        headers[LOCATION_HEADER] = redirect_url.to_s
      end

      return signed_out(reason: AuthErrorReason::SESSION_TOKEN_MISSING, headers: headers) unless session_token

      verify_token_with_retry(env, session_token)
    end

    def handle_handshake_maybe_status(env, **opts)
      return signed_out unless eligible_for_handshake?

      handshake(env, **opts)
    end

    # A outcome
    def handshake(_env, **opts)
      redirect_headers = { LOCATION_HEADER => redirect_to_handshake }
      [307, debug_auth_headers(**opts).merge(redirect_headers), []]
    end

    # B outcome
    def signed_out(**opts)
      headers = opts.delete(:headers) || {}
      enforce_auth = opts.delete(:enforce_auth)

      if enforce_auth
        [401, debug_auth_headers(**opts).merge(headers), []]
      else
        [nil, headers, []]
      end
    end

    # C outcome
    def signed_in(env, claims, token, **headers)
      env['clerk'] = ProxyV2.new(session_claims: claims, session_token: token)
      [nil, headers, []]
    end

    def eligible_for_handshake?
      auth_context.document_request? || (!auth_context.document_request? && auth_context.accepts_html?)
    end

    private

    def redirect_to_handshake
      redirect_url = auth_context.clerk_url.dup
      remove_from_query_string(redirect_url, DEV_BROWSER_COOKIE)

      handshake_url = URI.parse("https://#{auth_context.frontend_api}/v1/client/handshake")
      handshake_url_qs = Rack::Utils.parse_query(handshake_url.query)
      handshake_url_qs['redirect_url'] = redirect_url

      if auth_context.development_instance? && auth_context.dev_browser?
        handshake_url_qs[DEV_BROWSER_COOKIE] = auth_context.dev_browser
      end

      handshake_url.query = handshake_url_qs.to_query
      handshake_url.to_s
    end

    def remove_from_query_string(url, key)
      qs = Rack::Utils.parse_query(url.query)
      qs.delete(key)
      url.query = qs.to_query
    end

    def verify_token(token, **opts)
      return false if token.nil? || token.strip.empty?

      begin
        sdk.verify_token(token, **opts)
      rescue JWT::ExpiredSignature, JWT::InvalidIatError => e
        raise e
      rescue JWT::DecodeError, JWT::RequiredDependencyError
        false
      end
    end

    # Verify session token and provide a 1-day leeway for development if initial verification
    # fails for development instance due to invalid exp or iat
    def verify_token_with_retry(env, token)
      claims = verify_token(token)
      signed_in(env, claims, token) if claims
    rescue JWT::ExpiredSignature, JWT::InvalidIatError => e
      if auth_context.development_instance?
        # TODO: log possible Clock skew detected

        # Retry with a generous clock skew allowance (1 day)
        claims = verify_token(token, timeout: 86_400)
        return signed_in(env, claims, token) if claims
      end

      # Raise error if handshake resolution fails in production
      raise e
    end

    def sdk
      Clerk::SDK.new
    end

    def debug_auth_headers(reason: nil, message: nil, status: nil)
      {
        AUTH_REASON_HEADER => reason,
        AUTH_MESSAGE_HEADER => message,
        AUTH_STATUS_HEADER => status
      }.compact
    end
  end
end
