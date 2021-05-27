require "active_support/concern"

module Clerk
  module Authenticatable
    extend ActiveSupport::Concern

    protected
    def clerk_session
      request.env["clerk_session"]
    end

    def clerk_user
      request.env["clerk_user"]
    end

    def clerk_user_signed_in?
      !!clerk_user
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
      helper_method :clerk_session, :clerk_user, :clerk_user_signed_in?,
        :clerk_sign_in_url, :clerk_sign_up_url, :clerk_user_profile_url
    end
  end
end
