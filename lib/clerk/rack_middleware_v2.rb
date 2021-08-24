require_relative "sdk"

module Clerk
  class RackMiddlewareV2
    def initialize(app)
      @app = app
    end

    # TMP: query parameters accepted for testing:
    #
    # * __authorization: stubs the Authorization header
    # * __session: stubs the __session cookie
    # * if either of the above is set to the value `valid`, the token will be
    #   accepted as a valid JWT
    # * __client_uat: stubs the __client_uat cookie
    # * crossorigin: marks the request as cross-origin
    def call(env)
      @req = Rack::Request.new(env)
      @header_token = @req.env["HTTP_AUTHORIZATION"]&.strip
      @cookie_token = @req.cookies["__session"]
      @client_uat = @req.cookies["__client_uat"]

      # TMP for testing - accept all inputs from query params for convenience
      @header_token = @req.params["__authorization"]&.strip
      @cookie_token = @req.params["__session"]
      if @req.params["__client_uat"]
        @client_uat = Integer(@req.params["__client_uat"])
      else
        @client_uat = nil
      end

      log "processing... \n"                            \
          "\t Authorization=#{@header_token.inspect}\n" \
          "\t __session cookie=#{@cookie_token.inspect}"

      ##########################################################################
      #                                                                        #
      #                          HEADER AUTHENTICATION                         #
      #                                                                        #
      ##########################################################################
      if @header_token
        return signed_out if !sdk.decode_token(@header_token) # malformed JWT
        return signed_in if verify_token(@header_token)

        # Clerk.js should refresh the token and retry
        return unknown(interstitial: false)
      end

      # in cross-origin XHRs the use of Authorization header is mandatory.
      if cross_origin_request?(@req) && @header_token.nil?
        log "cross-origin request without authorization header"

        return signed_out
      end

      ##########################################################################
      #                                                                        #
      #                             COOKIE AUTHENTICATION                      #
      #                                                                        #
      ##########################################################################

      # DISCUSSION(agis): This might throw a lot of interstitials, since the
      # default Referrer-Policy is strict-origin-when-cross-origin. This means
      # that HTTPS->HTTP requests will omit the header, which will be the case
      # with https://accounts.* -> http://localhost navigations.
      #
      # See https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Referrer-Policy
      if development_or_staging? && (@req.referrer.nil? || cross_origin_request?(@req))
        return unknown(interstitial: true)
      end

      if production? && @client_uat.nil?
        return signed_out
      end

      if @client_uat == "0"
        return signed_out
      end

      token_iat = sdk.decode_token(@cookie_token)
      if verify_token(@cookie_token) && @client_uat && @client_uat < token_iat
        return sign_in
      end

      unknown(interstitial: true)
    end

    private

    # Outcome A
    def signed_in
      log "200 signed_in"

      [200, {}, ["You may pass!\n"]]
    end

    # Outcome B
    def signed_out
      log "403 signed-out"

      [403, {}, ["Unauthorized\n"]]
    end

    # Outcome C
    def unknown(interstitial: false)
      log "401 unknown (interstitial=#{interstitial})"

      return [401, {}, []] if !interstitial

      # Load Clerk.js to update the __session and __client_uat cookies.
      [401, {"Content-Type" => "text/html"}, [%Q(
        <!DOCTYPE html>
        <html>
          <head>
            <meta charset="UTF-8" />
          </head>
          <body>
            <script src="https://js.lclclerk.com/npm/clerk.browser.js"
             crossorigin="anonymous"
             data-clerk-frontend-api="#{ENV['CLERK_FRONTEND_API']}"
             onload="Clerk.load({authVersion: 2})">
            </script>
            <script>
              window.location.reload()
            </script>
          </body>
        </html>
      )
    ]]
    end

    def development_or_staging?
      Clerk.configuration.api_key.start_with?("test_")
    end

    def production?
      !development_or_staging?
    end

    def cross_origin_request?(req)
      return true if req.params["crossorigin"] # TMP for testing

      origin = req.env["HTTP_ORIGIN"]
      origin && origin != req.host
    end

    def verify_token(token)
      return false if token.nil? || token.strip.empty?

      return true if token == "valid" # TMP for testing

      begin
        @session = sdk.verify_token(token)
        true
      rescue JWT::DecodeError, JWT::RequiredDependencyError => e
        log(e)
        false
      end
    end

    def sdk
      @sdk ||= SDK.new
    end

    def log(s)
      Rails.logger.debug "\t[clerk] path=#{@req.path} #{s}"
    end

    def mock_session(x)
      @req.cookies["__session"] = x
    end

    def mock_header(x)
      @req.env["HTTP_AUTHORIZATION"] = x
    end

  end
end
