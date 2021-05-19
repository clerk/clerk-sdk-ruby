module Clerk
  module Resources
    class PluralResource
      def initialize(client, path_prefix)
        @client = client
        @path_prefix = path_prefix
      end

      def all(query_params = {})
        @client.request(:get, collection_path, query: query_params)
      end

      def find(id)
        @client.request(:get, resource_path(id))
      end

      def create(data = nil)
        @client.request(:post, collection_path, body: data)
      end

      def update(id, changes = nil)
        @client.request(:patch, resource_path(id), body: changes)
      end

      def delete(id)
        @client.request(:delete, resource_path(id))
      end

      def collection_path
        @path_prefix
      end

      def resource_path(id)
        "#{@path_prefix}/#{id}"
      end
    end
  end
end
