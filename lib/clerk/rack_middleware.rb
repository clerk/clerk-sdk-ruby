require_relative 'sdk'

module Clerk
  class RackMiddleware
    def initialize(app)
      @app = app
    end

    def call(env)
      req = Rack::Request.new(env)
      env['clerk'] = Proxy.new(env)
      @app.call(env)
    end
  end
end
