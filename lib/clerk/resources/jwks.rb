require "forwardable"
require_relative "plural_resource"

module Clerk
  module Resources
    class JWKS
      extend Forwardable

      def initialize(client)
        @client = client
      end

      def all(timeout: 5)
        @client.request(:get, "jwks", timeout: timeout)
      end
    end
  end
end
