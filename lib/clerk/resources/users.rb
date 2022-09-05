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

      def_delegators :@resource, :all, :find, :create, :update, :delete

      def oauth_access_token(user_id, provider)
        @client.request(:get, "#{@resource.resource_path(user_id)}/oauth_access_tokens/#{provider}")
      end

      def verify_password(user_id, password)
        @client.request(:post, "#{@resource.resource_path(user_id)}/verify_password", body: { password: password })
      end

      def disable_mfa(user_id)
        @client.request(:delete, "#{@resource.resource_path(user_id)}/mfa")
      end
    end
  end
end
