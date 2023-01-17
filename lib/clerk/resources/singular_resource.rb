module Clerk
  module Resources
    class SingularResource
      def initialize(client, resource_path)
        @client = client
        @resource_path = resource_path
      end

      def update(changes = {})
        @client.request(:patch, @resource_path, body: changes)
      end
    end
  end
end
