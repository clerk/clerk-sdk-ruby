require "clerk"

module Clerk
  class ProxyV2
    CACHE_TTL = 60 # seconds

    attr_reader :session_claims, :session_token

    def initialize(session_claims: nil, session_token: nil)
      @session_claims = session_claims
      @session_token = session_token
      @session = nil
    end

    def session
      return nil if @session_claims.nil?

      @session ||= verify_session
    end

    def verify_session
      return nil if @session_claims.nil?

      sdk.sessions.verify_token(@session_claims["sid"], @session_token)
    end

    def user
      return nil if user_id.nil?

      @user ||= fetch_user(user_id)
    end

    def user_id
      return nil if @session_claims.nil?

      @session_claims["sub"]
    end

    def org
      return nil if org_id.nil?

      @org ||= fetch_org(org_id)
    end

    def org_id
      return nil if user_id.nil?

      @session_claims["org_id"]
    end

    private

    def fetch_user(user_id)
      cached_fetch("clerk_user:#{user_id}") do
        sdk.users.find(user_id)
      end
    end

    def fetch_org(org_id)
      cached_fetch("clerk_org:#{org_id}") do
        sdk.organizations.find(org_id)
      end
    end

    def cached_fetch(key, &block)
      if store = Clerk.configuration.middleware_cache_store
        store.fetch(key, expires_in: CACHE_TTL, &block)
      else
        yield
      end
    end

    def sdk
      @sdk ||= Clerk::SDK.new
    end
  end

  class RackMiddlewareV2
    def initialize(app)
      @app = app
      @excluded_routes = {}
      @excluded_routes_wildcards = []

      Clerk.configuration.excluded_routes.each do |route|
        route = route.strip

        if route.ends_with?("/*")
          @excluded_routes_wildcards << route[0..-2]
        else
          @excluded_routes[route] = true
        end
      end

      @excluded_routes_wildcards.uniq!
    end

    def call(env)
      env = env
      req = Rack::Request.new(env)

      if @excluded_routes[req.path]
        return @app.call(env)
      end

      @excluded_routes_wildcards.each do |route|
        return @app.call(env) if req.path.starts_with?(route)
      end

      env["clerk"] = Clerk::ProxyV2.new
      header_token = req.env["HTTP_AUTHORIZATION"]
      header_token = header_token.strip.sub(/\ABearer /, '') if header_token
      cookie_token = req.cookies["__session"]
      client_uat = req.cookies["__client_uat"]

      ##########################################################################
      #                                                                        #
      #                          HEADER AUTHENTICATION                         #
      #                                                                        #
      ##########################################################################
      if header_token
        begin
          return signed_out(env) if !sdk.decode_token(header_token) # malformed JWT
        rescue JWT::DecodeError
          return signed_out(env)  # malformed JSON authorization header
        end

        begin
          token = verify_token(header_token)
          return signed_in(env, token, header_token) if token
        rescue JWT::ExpiredSignature, JWT::InvalidIatError
          unknown(interstitial: false)
        end

        # Clerk.js should refresh the token and retry
        return unknown(interstitial: false)
      end

      # in cross-origin XHRs the use of Authorization header is mandatory.
      if cross_origin_request?(req)
        return signed_out(env)
      end

      if development_or_staging? && !browser_request?(req)
        # the interstitial won't work if the user agent is not a browser, so
        # short-circuit and avoid rendering it
        #
        # We only limit this to dev/stg because we're not yet sure how robust
        # this strategy is, yet. In the future, we might enable it for prod too.
        return signed_out(env)
      end

      ##########################################################################
      #                                                                        #
      #                             COOKIE AUTHENTICATION                      #
      #                                                                        #
      ##########################################################################
      if development_or_staging? && (req.referrer.nil? || cross_origin_request?(req))
        return unknown(interstitial: true)
      end

      if production? && client_uat.nil?
        return signed_out(env)
      end

      if client_uat == "0"
        return signed_out(env)
      end

      begin
        token = verify_token(cookie_token)
        return signed_out(env) if !token

        if token["iat"] && client_uat && Integer(client_uat) <= token["iat"]
          return signed_in(env, token, cookie_token)
        end
      rescue JWT::ExpiredSignature, JWT::InvalidIatError
        unknown(interstitial: true)
      end

      unknown(interstitial: true)
    end

    private

    # Outcome A
    def signed_in(env, claims, token)
      env["clerk"] = ProxyV2.new(session_claims: claims, session_token: token)

      @app.call(env)
    end

    # Outcome B
    def signed_out(env)
      @app.call(env)
    end

    # Outcome C
    def unknown(interstitial: false, **opts)
      return [401, interstitial_headers(**opts), []] if !interstitial

      # Load Clerk.js to update the __session and __client_uat cookies.
      [401, interstitial_headers(**opts), [sdk.interstitial]]
    end

    def development_or_staging?
      Clerk.configuration.api_key.start_with?("test_") ||
        Clerk.configuration.api_key.start_with?("sk_test_")
    end

    def production?
      !development_or_staging?
    end

    def cross_origin_request?(req)
      # origin contains scheme+host and optionally port (omitted if 80 or 443)
      # ref. https://www.rfc-editor.org/rfc/rfc6454#section-6.1
      origin = req.env["HTTP_ORIGIN"]
      return false if origin.nil?

      # strip scheme
      origin = origin.strip.sub(/\A(\w+:)?\/\//, '')
      return false if origin.empty?

      # Rack's host and port helpers are reverse-proxy-aware; that
      # is, they prefer the de-facto X-Forwarded-* headers if they're set
      request_host = req.host
      request_host << ":#{req.port}" if req.port != 80 && req.port != 443

      origin != request_host
    end

    def browser_request?(req)
      user_agent = req.env["HTTP_USER_AGENT"]

      !user_agent.nil? && user_agent.starts_with?("Mozilla/")
    end

    def verify_token(token)
      return false if token.nil? || token.strip.empty?

      begin
        sdk.verify_token(token)
      rescue JWT::ExpiredSignature, JWT::InvalidIatError => e
        raise e
      rescue JWT::DecodeError, JWT::RequiredDependencyError => e
        false
      end
    end

    def sdk
      Clerk::SDK.new
    end

    def interstitial_headers(reason: nil, message: nil, status: nil)
      {
        "Content-Type" => "text/html",
        "X-Clerk-Auth-Reason" => reason,
        "X-Clerk-Auth-Message" => message,
        "X-Clerk-Auth-Status" => status,
      }.compact
    end
  end
end
