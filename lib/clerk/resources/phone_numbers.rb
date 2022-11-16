require "forwardable"
require_relative "plural_resource"

module Clerk
  module Resources
    class PhoneNumbers
      extend Forwardable

      def initialize(client)
        @client = client
        @resource = PluralResource.new(client, "phone_numbers")
      end

      def_delegators :@resource, :find, :create, :update, :delete
    end
  end
end
