require 'clerk'
require_relative 'authenticate_context'
require_relative 'authenticate_request'

module Clerk
  class RackMiddlewareV2
    def initialize(app)
      @app = app
      @excluded_routes = {}
      @excluded_routes_wildcards = []

      Clerk.configuration.excluded_routes.each do |route|
        route = route.strip

        if route.ends_with?('/*')
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

      return @app.call(env) if @excluded_routes[req.path]

      @excluded_routes_wildcards.each do |route|
        return @app.call(env) if req.path.starts_with?(route)
      end

      env['clerk'] = Clerk::ProxyV2.new

      auth_context = AuthenticateContext.new(req, Clerk.configuration)
      auth_request = AuthenticateRequest.new(auth_context)

      status, auth_request_headers, body = auth_request.resolve(env)
      return [status, auth_request_headers, body] if status

      status, headers, body = @app.call(env)

      unless auth_request_headers.empty?
        # Remove them to avoid overriding existing cookies set in headers by other middlewares
        auth_request_cookies = auth_request_headers.delete(COOKIE_HEADER)
        # merge non-cookie related headers into response headers
        headers.merge!(auth_request_headers)

        set_cookie_headers!(headers, auth_request_cookies) if auth_request_cookies
      end

      [status, headers, body]
    end

    private

    def set_cookie_headers!(headers, cookie_headers)
      cookie_headers.each do |cookie_header|
        cookie_key = cookie_header.split(';')[0].split('=')[0]
        cookie = Rack::Utils.parse_cookies_header(cookie_header)
        cookie_params = convert_http_cookie_to_cookie_setter_params(cookie, cookie_key)
        Rack::Utils.set_cookie_header!(headers, cookie_key, cookie_params)
      end
    end

    def convert_http_cookie_to_cookie_setter_params(cookie, cookie_key)
      # convert cookie to to match cookie setter method params (lowercase symbolized keys with `:value` key)
      cookie_params = cookie.transform_keys { |k| k.downcase.to_sym }
      # drop the current cookie name key to avoid polluting the expected cookie params
      cookie_params[:value] = cookie.delete(cookie_key)
      # fix issue with cookie expiration expected to be Date type
      cookie_params[:expires] = Date.parse(cookie_params[:expires]) if cookie_params[:expires]

      cookie_params
    end
  end
end
