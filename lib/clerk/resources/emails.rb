require "forwardable"
require_relative "plural_resource"

module Clerk
  module Resources
    class Emails
      extend Forwardable

      def initialize(client)
        @resource = PluralResource.new(client, "emails")
      end

      def_delegators :@resource, :create
    end
  end
end
