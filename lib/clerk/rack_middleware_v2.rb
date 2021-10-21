require "clerk"

module Clerk
  class RackMiddlewareV2
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

      private

      def fetch_user(user_id)
        cached_fetch("clerk_user:#{user_id}") do
          sdk.users.find(user_id)
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

    def initialize(app)
      @app = app
    end

    def call(env)
      @env = env
      @req = Rack::Request.new(env)
      @env["clerk"] = ProxyV2.new
      @header_token = @req.env["HTTP_AUTHORIZATION"]&.strip
      @cookie_token = @req.cookies["__session"]
      @client_uat = @req.cookies["__client_uat"]

      ##########################################################################
      #                                                                        #
      #                          HEADER AUTHENTICATION                         #
      #                                                                        #
      ##########################################################################
      if @header_token
        return signed_out if !sdk.decode_token(@header_token) # malformed JWT

        token = verify_token(@header_token)
        return signed_in(token, @header_token) if token

        # Clerk.js should refresh the token and retry
        return unknown(interstitial: false)
      end

      # in cross-origin XHRs the use of Authorization header is mandatory.
      if cross_origin_request?(@req)
        return signed_out
      end

      ##########################################################################
      #                                                                        #
      #                             COOKIE AUTHENTICATION                      #
      #                                                                        #
      ##########################################################################
      if development_or_staging? && (@req.referrer.nil? || cross_origin_request?(@req))
        return unknown(interstitial: true)
      end

      if production? && @client_uat.nil?
        return signed_out
      end

      if @client_uat == "0"
        return signed_out
      end

      token = verify_token(@cookie_token)

      if token && token["iat"] && @client_uat && Integer(@client_uat) <= token["iat"]
        return signed_in(token, @cookie_token)
      end

      unknown(interstitial: true)
    end

    private

    # Outcome A
    def signed_in(claims, token)
      @env["clerk"] = ProxyV2.new(session_claims: claims, session_token: token)

      @app.call(@env)
    end

    # Outcome B
    def signed_out
      @app.call(@env)
    end

    # Outcome C
    def unknown(interstitial: false)
      return [401, {}, []] if !interstitial

      # Load Clerk.js to update the __session and __client_uat cookies.
      [401, {"Content-Type" => "text/html"}, [sdk.interstitial]]
    end

    def development_or_staging?
      Clerk.configuration.api_key.start_with?("test_")
    end

    def production?
      !development_or_staging?
    end

    def cross_origin_request?(req)
      origin = req.env["HTTP_ORIGIN"]
      origin && origin.sub(/(^\w+:|^)\/\//, '') != req.host
    end

    def verify_token(token)
      return false if token.nil? || token.strip.empty?

      begin
        @session = sdk.verify_token(token)
      rescue JWT::DecodeError, JWT::RequiredDependencyError => e
        false
      end
    end

    def sdk
      @sdk ||= Clerk::SDK.new
    end
  end
end
