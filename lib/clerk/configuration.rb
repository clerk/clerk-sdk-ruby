# frozen_string_literal: true

require "clerk-sdk-ruby-backend"

module Clerk
  class Configuration
    attr_reader :cache_store
    attr_reader :debug
    attr_reader :excluded_routes
    attr_reader :publishable_key
    attr_reader :secret_key

    def initialize
      @excluded_routes = []
      @publishable_key = ENV["CLERK_PUBLISHABLE_KEY"]
      @secret_key = ENV["CLERK_SECRET_KEY"]

      # Default to Rails.cache or ActiveSupport::Cache::MemoryStore, if available, otherwise nil
      @cache_store = if defined?(::Rails)
        ::Rails.cache
      elsif defined?(::ActiveSupport::Cache::MemoryStore)
        ::ActiveSupport::Cache::MemoryStore.new
      end

      ClerkBackend.configure do |config|
        unless secret_key.nil? || secret_key.empty?
          config.access_token = @secret_key
        end
      end
    end

    def self.default
      @@default ||= new
    end

    def update(options)
      options.each do |key, value|
        send(:"#{key}=", value)
      end
    end

    def debug=(value)
      ClerkBackend::Configuration.default.debugging = value
      @debug = value
    end

    def cache_store=(store)
      if !store
        @cache_store = nil
        return
      end

      raise ArgumentError, "cache_store must respond to :fetch" unless store.respond_to?(:fetch)

      @cache_store = store
    end

    def excluded_routes=(routes)
      raise ArgumentError, "excluded_routes must be an array" unless routes.is_a?(Array)
      raise ArgumentError, "All elements in the excluded_routes array must be strings" unless routes.all? { |r| r.is_a?(String) }

      @excluded_routes = routes
    end

    def publishable_key=(pk)
      raise ArgumentError, "publishable_key must start with 'pk_'" unless pk.start_with?("pk_")

      @publishable_key = pk
    end

    def secret_key=(sk)
      raise ArgumentError, "secret_key must start with 'sk_'" unless sk.start_with?("sk_")

      ClerkBackend::Configuration.default.access_token = sk
      @secret_key = sk
    end
  end
end
