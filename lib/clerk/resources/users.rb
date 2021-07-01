require "forwardable"
require_relative "plural_resource"

module Clerk
  module Resources
    class Users
      extend Forwardable

      def initialize(client)
        @client = client
        @resource = PluralResource.new(client, "users")
      end

      def_delegators :@resource, :all, :find, :update, :delete

      def oauth_access_token(user_id, provider)
        @client.request(:get, "#{@resource.resource_path(user_id)}/oauth_access_token/#{provider}")
      end
    end
  end
end
