# frozen_string_literal: true

require_relative "clerk/version"
require_relative "clerk/constants"
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
    PRODUCTION_BASE_URL = "https://api.clerk.dev/v1/"
    attr_accessor :api_key, :base_url, :publishable_key, :logger, :middleware_cache_store

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
      @api_key = ENV.fetch("CLERK_API_KEY", nil)

      secret_key = ENV.fetch("CLERK_SECRET_KEY", nil)
      @api_key = secret_key if secret_key && !secret_key.empty?

      @publishable_key = ENV.fetch("CLERK_PUBLISHABLE_KEY", nil)

      @excluded_routes = []
    end
  end
end

require_relative "clerk/railtie" if defined?(Rails)
