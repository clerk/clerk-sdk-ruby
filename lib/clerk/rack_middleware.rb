require_relative "sdk"

module Clerk
  class RackMiddleware
    class NullCache
      def fetch(key, options = nil, &block); yield; end
    end

    def initialize(app, cache_store: nil)
      @app = app
      @cache = cache_store || NullCache.new
    end

    def call(env)
      req = Rack::Request.new(env)
      token = req.cookies["__session"]

      if token
        sess_id = req.params["_clerk_session_id"]
        begin
          env["clerk_session"] = fetch_session(token, sess_id)
        rescue Errors::Authentication => e
          env["clerk_error"] = e
        end
      end
      if sess = env["clerk_session"]
        env["clerk_user"] = fetch_user(sess["user_id"])
      end
      @app.call(env)
    end

    private
    def clerk_sdk
      SDK.new
    end

    def fetch_session(token, sess_id)
      cache_key = token.split(".")[1]
      if sess_id
        session = @cache.fetch("clerk_session:#{sess_id}:#{cache_key}", expires_in: cache_ttl) do
          sdk = clerk_sdk
          sdk.sessions.verify_token(sess_id, token)
        end
      else
        session = @cache.fetch("clerk_session:#{cache_key}", expires_in: cache_ttl) do
          sdk = clerk_sdk
          client = sdk.clients.verify_token(token)
          sess_id = client["last_active_session_id"]
          client["sessions"].find do |sess|
            sess["id"] == sess_id
          end
        end
      end
    end

    def fetch_user(user_id)
      sdk = clerk_sdk
      @cache.fetch("clerk_user:#{user_id}", expires_in: cache_ttl) do
        sdk.users.find(user_id)
      end
    end

    def cache_ttl
      60
    end
  end
end
