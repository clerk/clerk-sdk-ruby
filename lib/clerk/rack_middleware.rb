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
      if token && payload = token.split(".")[1]
        user = @cache.fetch(payload, expires_in: 1.minute) do
          sdk = Clerk::SDK.new
          if client = sdk.clients.verify_token(token)
            sdk.users.find(client["user_id"])
          end
        end
        env["clerk_user"] = user.first
      end
      status, headers, body = @app.call(env)
      [status, headers, body]
    end
  end
end
