# frozen_string_literal: true

require 'minitest/autorun'
require 'rack'
require 'rack/mock'
require 'sinatra/base'
require_relative '../../lib/clerk/rack_middleware'

module Clerk
  module Rack
    class ReverificationTest < Minitest::Test
      class FakeProxy
        def user_needs_reverification?(_preset)
          true
        end

        def user_reverification_rack_response(_preset)
          [403, {'content-type' => 'application/json'}, ['{"reverification":"required"}']]
        end
      end

      def sinatra_app
        Sinatra.new do
          disable :show_exceptions, :logging, :dump_errors
          get('/admin') { 'admin ok' }
          get('/admin/users') { 'admin users ok' }
        end
      end

      def build_stack(routes:)
        downstream = sinatra_app
        reverification = Clerk::Rack::Reverification.new(downstream, routes: routes)
        lambda do |env|
          env['clerk.initialized'] = true
          env['clerk'] = FakeProxy.new
          reverification.call(env)
        end
      end

      def request(app, path)
        env = ::Rack::MockRequest.env_for(path)
        app.call(env)
      end

      def test_protected_route_returns_reverification_error
        app = build_stack(routes: ['/admin'])
        status, = request(app, '/admin')
        assert_equal 403, status
      end

      def test_unknown_route_passes_through_to_app_404
        app = build_stack(routes: ['/admin'])
        status, = request(app, '/does-not-exist')
        assert_equal 404, status
      end

      def test_percent_encoded_path_matches_decoded_exact_route
        app = build_stack(routes: ['/admin'])
        status, = request(app, '/%61dmin')
        assert_equal 403, status
      end

      def test_percent_encoded_path_matches_decoded_wildcard_route
        app = build_stack(routes: ['/admin/*'])
        status, = request(app, '/%61dmin/users')
        assert_equal 403, status
      end

      def test_case_sensitive_encoded_path_not_matched_and_app_404s
        app = build_stack(routes: ['/admin'])
        status, = request(app, '/%41DMIN')
        assert_equal 404, status
      end

      def test_raises_when_middleware_not_initialized_first
        reverification = Clerk::Rack::Reverification.new(sinatra_app, routes: ['/admin'])
        env = ::Rack::MockRequest.env_for('/admin')
        assert_raises(Clerk::ConfigurationError) { reverification.call(env) }
      end
    end
  end
end
