require "forwardable"
require_relative "singular_resource"

module Clerk
  module Resources
    class Allowlist
      extend Forwardable

      def initialize(client)
        @resource = SingularResource.new(client, "beta_features/allowlist")
      end

      def_delegators :@resource, :update
    end
  end
end
