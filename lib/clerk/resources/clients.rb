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

      def exchange_nonce(nonce)
        @client.request(:get, "#{@resource.collection_path}/exchange_nonce?nonce=#{nonce}")
      end

      def_delegators :@resource, :all, :find
    end
  end
end

