# frozen_string_literal: true

module Clerk
  class Error < StandardError
    attr_reader :status

    def initialize(msg, status:)
      @errors = msg['errors']
      @status = status
      super(msg.merge(status: status))
    end
  end

  class AuthenticationError < Error; end

  class ConfigurationError < StandardError; end

  class FatalError < Error; end
end
