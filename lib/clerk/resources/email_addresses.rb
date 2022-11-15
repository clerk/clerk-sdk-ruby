require "forwardable"
require_relative "plural_resource"

module Clerk
  module Resources
    class EmailAddresses
      extend Forwardable

      def initialize(client)
        @client = client
        @resource = PluralResource.new(client, "email_addresses")
      end

      def_delegators :@resource, :find, :create, :update, :delete
    end
  end
end
