require "clerk"
require "clerk/authenticate_context"
require "clerk/authenticate_request"
require "clerk/proxy"
require "clerk/utils"

module Clerk
  module Rack
    class Middleware
      def initialize(app, options = {})
        @app = app

        Clerk.configuration.update(options) if options
        @excluded_routes, @excluded_routes_wildcards = Clerk::Utils.filter_routes(Clerk.configuration.excluded_routes)
      end

      def call(env)
        env["clerk.initialized"] = true

        req = ::Rack::Request.new(env)

        if @excluded_routes[req.path]
          env["clerk.excluded_route"] = true
          return @app.call(env)
        end

        @excluded_routes_wildcards.each do |route|
          if req.path.start_with?(route)
            env["clerk.excluded_route"] = true
            return @app.call(env)
          end
        end

        env["clerk"] = Clerk::Proxy.new

        auth_context = AuthenticateContext.new(req, Clerk.configuration)
        auth_request = AuthenticateRequest.new(auth_context)

        status, auth_request_headers, body = auth_request.resolve(env)

        return [status, auth_request_headers, body] if status

        status, headers, body = @app.call(env)

        unless auth_request_headers.empty?
          # Remove them to avoid overriding existing cookies set in headers by other middlewares
          auth_request_cookies = auth_request_headers.delete(SET_COOKIE_HEADER.downcase)
          # merge non-cookie related headers into response headers
          headers.merge!(auth_request_headers)

          set_cookie_headers!(headers, auth_request_cookies) if auth_request_cookies
        end

        [status, headers, body]
      end

      private

      def parse_cookie_key(cookie_header)
        cookie_header.split(";")[0].split("=")[0]
      end

      def set_cookie_headers!(headers, cookie_headers)
        cookie_headers.each do |cookie_header|
          cookie_key = parse_cookie_key(cookie_header)
          cookie = ::Rack::Utils.parse_cookies_header(cookie_header)
          cookie_params = convert_http_cookie_to_cookie_setter_params(cookie_key, cookie)
          ::Rack::Utils.set_cookie_header!(headers, cookie_key, cookie_params)
        end
      end

      def convert_http_cookie_to_cookie_setter_params(cookie_key, cookie)
        # convert cookie to to match cookie setter method params (lowercase symbolized keys with `:value` key)
        cookie_params = cookie.transform_keys { |k| k.downcase.to_sym }
        # drop the current cookie name key to avoid polluting the expected cookie params
        cookie_params[:value] = cookie_params.delete(cookie_key.to_sym)

        # Ensure secure and httponly are set to true if present
        cookie_params[:secure] = cookie_params.has_key?(:secure)
        cookie_params[:httponly] = cookie_params.has_key?(:httponly)

        # fix issue with cookie expiration expected to be Date type
        cookie_params[:expires] = Date.parse(cookie_params[:expires]) if cookie_params[:expires]

        cookie_params
      end
    end

    class Reverification
      def initialize(app, routes: ["/*"], preset: Clerk::StepUp::Preset::STRICT)
        @app = app
        @preset = preset

        @included_routes, @included_routes_wildcards = Clerk::Utils.filter_routes(routes)
      end

      def call(env)
        raise Clerk::ConfigurationError, "`Clerk::Rack::Reverification` must be initialized after `Clerk::Rack::Middleware`" unless env["clerk.initialized"]
        return @app.call(env) if env["clerk.excluded_route"]

        req = ::Rack::Request.new(env)
        valid_route = @included_routes[req.path] || @included_routes_wildcards.any? { |route| req.path.start_with?(route) }

        if valid_route && env["clerk"].user_needs_reverification?(@preset)
          return env["clerk"].user_reverification_rack_response(@preset)
        end

        @app.call(env)
      end
    end
  end
end
