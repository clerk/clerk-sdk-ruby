require "forwardable"
require_relative "plural_resource"

module Clerk
  module Resources
    class TestingTokens
      extend Forwardable

      def initialize(client)
        @client = client
        @resource = PluralResource.new(client, "testing_tokens")
      end

      def_delegators :@resource, :create
    end
  end
end
