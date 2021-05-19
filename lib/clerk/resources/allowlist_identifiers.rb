require "forwardable"
require_relative "plural_resource"

module Clerk
  module Resources
    class AllowlistIdentifiers
      extend Forwardable

      def initialize(client)
        @resource = PluralResource.new(client, "allowlist_identifiers")
      end

      def_delegators :@resource, :all, :create, :delete
    end
  end
end
