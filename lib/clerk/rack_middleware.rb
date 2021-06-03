require_relative "sdk"

module Clerk
  class RackMiddleware
    def initialize(app)
      @app = app
    end

    def call(env)
      req = Rack::Request.new(env)
      env["clerk"] = Proxy.new(env)
      @app.call(env)
    end
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
        store.fetch(key, expires_in: cache_ttl, &block)
      else
        yield
      end
    end

    def cache_ttl
      60
    end
  end
end
