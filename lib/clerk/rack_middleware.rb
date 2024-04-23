require_relative 'sdk'
require_relative 'proxy'

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
