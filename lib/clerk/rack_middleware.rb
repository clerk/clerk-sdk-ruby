require_relative "sdk"

module Clerk
  class RackMiddleware
    CACHE_TTL = 60 # seconds

    def initialize(app)
      @app = app
    end

    def call(env)
      req = Rack::Request.new(env)

      authv2 = authv2_token?(req.env["HTTP_AUTHORIZATION"]) ||
        authv2_token?(req.cookies["__session"])

      env["clerk"] = authv2 ? ProxyNetworkless.new(env) : Proxy.new(env)

      @app.call(env)
    end

    class Proxy
      attr_reader :session_id, :error

      def initialize(env)
        req = Rack::Request.new(env)
        @token = req.cookies["__session"]
        @session_id = req.params["_clerk_session_id"]
        @session = nil
        @user_id = nil
        @user = nil
      end

      def session
        return nil if @token.nil?
        return @session if @session

        begin
          @session = fetch_session
        rescue Errors::Authentication => e
          @error = e
        end
        @session
      end

      def user_id
        @user_id ||= session.dig("user_id")
      end

      def user
        return nil if session.nil?
        @user ||= fetch_user(user_id)
      end

      def debug
        (instance_variables - [:@sdk]).map do |ivar|
          [ivar.to_s, instance_variable_get(ivar)]
        end.to_h
      end

      private

      def sdk
        @sdk ||= SDK.new
      end

      def cache_key
        @cache_key ||= @token.split(".")[1]
      end

      def fetch_session
        if session_id
          cached_fetch("clerk_session:#{session_id}:#{cache_key}") do
            sdk.sessions.verify_token(session_id, @token)
          end
        else
          cached_fetch("clerk_session:#{cache_key}") do
            client = sdk.clients.verify_token(@token)
            @session_id = client["last_active_session_id"]
            client["sessions"].find do |sess|
              sess["id"] == @session_id
            end
          end
        end
      end

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
    end

    class ProxyNetworkless
      attr_reader :session_id, :errors

      def initialize(env)
        @req = Rack::Request.new(env)

        @session = nil
        @user_id = nil
        @user = nil
        @errors = []
      end

      def session
        verify_token(@req.env["HTTP_AUTHORIZATION"]) ||
          verify_token(@req.cookies["__session"])

        @session
      end

      def verify_token(token)
        return false if token.nil? || token.strip.empty?

        begin
          @session = sdk.verify_token(token)
          true
        rescue JWT::DecodeError, JWT::RequiredDependencyError => e
          @errors << e
          false
        end
      end

      def user
        return nil if session.nil?

        @user ||= fetch_user(user_id)
      end

      def user_id
        return nil if session.nil?

        @user_id ||= session.dig("sub")
      end

      private

      def sdk
        @sdk ||= SDK.new
      end

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
    end

    private

    def authv2_token?(token)
      return false if token.nil? || token.strip.empty?

      begin
        claims = sdk.decode_token(token)
      rescue JWT::DecodeError, JWT::RequiredDependencyError => e
        return false
      end

      return true if claims["iss"] && claims["iss"].start_with?("https://clerk.")

      false
    end

    def sdk
      @sdk ||= SDK.new
    end
  end
end
