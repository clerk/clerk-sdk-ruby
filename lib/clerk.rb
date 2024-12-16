# frozen_string_literal: true

require "clerk/configuration"
require "clerk/constants"
require "clerk/error"
require "clerk/sdk"
require "clerk/version"

if defined?(::Rails)
  require "clerk/rails"
end

module Clerk
  class << self
    def configure
      if block_given?
        yield(configuration)
      else
        configuration
      end
    end

    def configuration
      @configuration ||= Clerk::Configuration.default
    end
  end
end
