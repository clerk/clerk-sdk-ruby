require "forwardable"
require_relative "plural_resource"

module Clerk
  module Resources
    class Sessions
      extend Forwardable

      def initialize(client)
        @client = client
        @resource = PluralResource.new(client, "sessions")
      end

      def revoke(id)
        @client.request(:post, "#{@resource.resource_path(id)}/revoke")
      end

      def verify_token(id, token)
        @client.request(:post, "#{@resource.resource_path(id)}/verify",
                        body: {token: token})
      end

      def_delegators :@resource, :all, :find
    end
  end
end
