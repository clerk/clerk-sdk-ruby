require "forwardable"
require_relative "plural_resource"

module Clerk
  module Resources
    class Users
      extend Forwardable

      def initialize(client)
        @resource = PluralResource.new(client, "users")
      end

      def_delegators :@resource, :all, :find, :update, :delete
    end
  end
end
