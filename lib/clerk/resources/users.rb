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

      def verify_totp(user_id, totp_or_backup_code)
        @client.request(:post, "#{@resource.resource_path(user_id)}/verify_totp", body: { code: totp_or_backup_code })
      end

      def disable_mfa(user_id)
        @client.request(:delete, "#{@resource.resource_path(user_id)}/mfa")
      end

      def organization_memberships(user_id, query_params = {})
        @client.request(:get, "#{@resource.resource_path(user_id)}/organization_memberships", query: query_params)
      end
    end
  end
end
