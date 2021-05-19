require "forwardable"
require_relative "plural_resource"

module Clerk
  module Resources
    class SMSMessages
      extend Forwardable

      def initialize(client)
        @resource = PluralResource.new(client, "sms_messages")
      end

      def_delegators :@resource, :create
    end
  end
end
