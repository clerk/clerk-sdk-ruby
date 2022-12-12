require "forwardable"
require_relative "plural_resource"

module Clerk
  module Resources
    class SignUps
      extend Forwardable

      def initialize(client)
        @client = client
        @resource = PluralResource.new(client, "sign_ups")
      end

      def_delegators :@resource, :find, :update
    end
  end
end
