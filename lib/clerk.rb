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

    def initialize
      @base_url = ENV.fetch("CLERK_API_BASE", PRODUCTION_BASE_URL)
      @api_key = ENV["CLERK_API_KEY"]
    end
  end
end

if defined?(::Rails)
  require_relative "clerk/railtie"
end
