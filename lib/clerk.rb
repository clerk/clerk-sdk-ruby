# frozen_string_literal: true

require 'clerk_sdk_ruby'

require 'clerk/configuration'
require 'clerk/constants'
require 'clerk/error'
require 'clerk/sdk'

if defined?(::Rails)
  require 'clerk/rails'
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
