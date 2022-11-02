require "forwardable"
require_relative "plural_resource"

module Clerk
  module Resources
    class Organizations
      extend Forwardable

      def initialize(client)
        @client = client
        @resource = PluralResource.new(client, "organizations")
      end

      def_delegators :@resource, :all, :find, :create, :update, :delete

      def update_metadata(org_id, private_metadata: {}, public_metadata: {})
        data = {}
        data["private_metadata"] = private_metadata.to_json if !private_metadata.empty?
        data["public_metadata"] = public_metadata.to_json if !public_metadata.empty?

        @client.request(:patch, "#{@resource.resource_path(org_id)}/metadata", body: data)
      end

      #
      # Invitations
      #
      def pending_invitations(org_id, query_params = {})
        @client.request(:get, "#{invitations_path(org_id)}/pending", query: query_params)
      end

      def create_invitation(org_id, data)
        @client.request(:post, invitations_path(org_id), body: data)
      end

      def revoke_invitation(org_id, invitation_id, data)
        @client.request(:post, "#{invitations_path(org_id, invitation_id)}/revoke", body: data)
      end

      #
      # Memberships
      #
      def memberships(org_id, query_params = {})
        @client.request(:get, memberships_path(org_id), query: query_params)
      end

      def create_membership(org_id, data)
        @client.request(:post, memberships_path(org_id), body: data)
      end

      def update_membership(org_id, user_id, data)
        @client.request(:patch, memberships_path(org_id, user_id), body: data)
      end

      def delete_membership(org_id, user_id)
        @client.request(:delete, memberships_path(org_id, user_id))
      end

      private

      def invitations_path(org_id, invitation_id=nil)
        path = "#{@resource.resource_path(org_id)}/invitations"
        path << "/#{invitation_id}" if invitation_id
        path
      end

      def memberships_path(org_id, user_id=nil)
        path = "#{@resource.resource_path(org_id)}/memberships"
        path << "/#{user_id}" if user_id
        path
      end
    end
  end
end
