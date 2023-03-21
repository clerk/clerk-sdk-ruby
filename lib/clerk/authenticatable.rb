require "active_support/concern"

module Clerk
  module Authenticatable
    extend ActiveSupport::Concern

    protected

    # Makes a request to the Clerk API to verify the session again and return
    # the Session object. Subsequent calls to this method will return the cached
    # Session object.
    #
    # NOTE: For better performance, you can instead use `#clerk_verified_session_claims`
    # which already contains the verified claims as retrieved from the session
    # token.
    def clerk_session
      request.env["clerk"].session
    end

    # Makes a request to the Clerk API to verify the session again. Returns the
    # session object as fetched from the API.
    #
    # NOTE: For better performance, you can instead use `#clerk_verified_session_claims`
    # which already contains the verified claims as retrieved from the session
    # token.
    #
    # See https://clerk.com/docs/reference/backend-api/tag/Sessions#operation/VerifySession
    def clerk_reverify_session!
      request.env["clerk"].verify_session
    end

    def clerk_verified_session_claims
      request.env["clerk"].session_claims
    end

    def clerk_verified_session_token
      request.env["clerk"].session_token
    end

    # Makes a request to the Clerk API to fetch the data of the authenticated
    # session's user. If caching is configured (see
    # Config.middleware_cache_store), subsequent calls will return the cached
    # object.
    def clerk_user
      request.env["clerk"].user
    end

    def clerk_user_id
      request.env["clerk"].user_id
    end

    # Makes a request to the Clerk API to fetch the data of the authenticated
    # session's organization. If caching is configured (see
    # Config.middleware_cache_store), subsequent calls will return the cached
    # object.
    def clerk_organization
      request.env["clerk"].org
    end

    def clerk_organization_id
      request.env["clerk"].org_id
    end

    def clerk_user_signed_in?
      !!clerk_verified_session_claims
    end

    def clerk_sign_in_url
      ENV.fetch("CLERK_SIGN_IN_URL")
    end

    def clerk_sign_up_url
      ENV.fetch("CLERK_SIGN_UP_URL")
    end

    def clerk_user_profile_url
      ENV.fetch("CLERK_USER_PROFILE_URL")
    end

    included do
      helper_method :clerk_session, :clerk_reverify_session!,
        :clerk_verified_session_claims, :clerk_verified_session_token,
        :clerk_user, :clerk_user_id, :clerk_user_signed_in?, :clerk_sign_in_url,
        :clerk_sign_up_url, :clerk_user_profile_url,
        :clerk_organization, :clerk_organization_id
    end
  end
end
