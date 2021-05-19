require "forwardable"
require_relative "plural_resource"

module Clerk
  module Resources
    class Clients
      extend Forwardable

      def initialize(client)
        @client = client
        @resource = PluralResource.new(client, "clients")
      end

      def verify_token(token)
        @client.request(:post, "#{@resource.collection_path}/verify",
                        body: {token: token})
      end

      def_delegators :@resource, :all, :find
    end
  end
end

