# frozen_string_literal: true

require_relative "clerk/version"
require_relative "clerk/sdk"

module Clerk
  class << self
    def configure
      yield(configuration)
    end

    def configuration
      @configuration ||= Config.new
    end
  end

  class Config
    PRODUCTION_BASE_URL = "https://api.clerk.dev/v1/".freeze
    attr_accessor :api_key, :base_url, :logger, :middleware_cache_store

    # An array of route paths on which the middleware will not execute.
    #
    # Only request paths that match _exactly_ one of the routes will be skipped.
    # As a special case, if a route ends with '/*', then all request paths that
    # match the route's prefix will be skipped.
    #
    # For example, given the following configuration:
    #
    #     excluded_routes = ["/foo", "/bar/*"]
    #
    # the following requests will be excluded:
    #
    # - /foo
    # - /bar/baz
    # - /bar/abc/xyz
    #
    # while the following requests will NOT be excluded:
    #
    # - /foo/bar
    # - /bar
    #
    attr_accessor :excluded_routes

    def initialize
      @base_url = ENV.fetch("CLERK_API_BASE", PRODUCTION_BASE_URL)
      @api_key = ENV["CLERK_API_KEY"]

      secret_key = ENV["CLERK_SECRET_KEY"]
      if secret_key && !secret_key.empty?
        @api_key = secret_key
      end

      @excluded_routes = []
    end
  end
end

if defined?(::Rails)
  require_relative "clerk/railtie"
end
