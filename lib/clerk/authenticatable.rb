# frozen_string_literal: true

require 'active_support/concern'

module Clerk
  # Concern containing Clerk Auth related helper methods
  module Authenticatable
    extend ActiveSupport::Concern

    protected

    # Returns the verified claims as retrieved from the session token.
    def clerk_session_claims
      request.env['clerk'].session_claims
    end

    # Returns the verified session token.
    def clerk_session_token
      request.env['clerk'].session_token
    end

    # Makes a request to the Clerk API to fetch the data of the authenticated
    # session's user. If caching is configured (see
    # Config.middleware_cache_store), subsequent calls will return the cached
    # object.
    def clerk_user
      request.env['clerk'].user
    end

    # Returns the verified user_id from the token claims without making a request to Clerk API.
    def clerk_user_id
      request.env['clerk'].user_id
    end

    # Makes a request to the Clerk API to fetch the data of the authenticated
    # session's organization. If caching is configured (see
    # Config.middleware_cache_store), subsequent calls will return the cached
    # object.
    def clerk_organization
      request.env['clerk'].org
    end

    # Returns the verified organization_id from the token claims without making a request to Clerk API.
    def clerk_organization_id
      request.env['clerk'].org_id
    end

    def clerk_organization_role
      request.env['clerk'].org_role
    end

    def clerk_organization_permissions
      request.env['clerk'].org_permissions
    end

    def clerk_user_signed_in?
      !!clerk_session_claims
    end

    def clerk_sign_in_url
      ENV.fetch('CLERK_SIGN_IN_URL')
    end

    def clerk_sign_up_url
      ENV.fetch('CLERK_SIGN_UP_URL')
    end

    def clerk_user_profile_url
      ENV.fetch('CLERK_USER_PROFILE_URL')
    end

    included do
      helper_method :clerk_session_claims, :clerk_user, :clerk_user_id, :clerk_user_signed_in?,
                    :clerk_sign_in_url, :clerk_sign_up_url, :clerk_user_profile_url,
                    :clerk_organization, :clerk_organization_id, :clerk_organization_role,
                    :clerk_organization_permissions
    end
  end
end
