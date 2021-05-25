require_relative "sdk"
require "active_support/concern"

module Clerk
  module Authenticatable
    class AuthenticationRequired < StandardError

    end

    extend ActiveSupport::Concern

    protected
    def clerk_sdk
      @_clerk_sdk ||= Clerk::SDK.new
    end

    def clerk_client
      @_clerk_client ||= clerk_sdk.clients.verify_token(cookies["__session"])
    end

    def clerk_session_id
      clerk_client["last_active_session_id"]
    end

    def clerk_session
      @_clerk_session ||= clerk_client["sessions"]&.find do |sess|
        sess["id"] == clerk_session_id
      end
    end

    def clerk_user_id
      @_clerk_user_id ||= clerk_session["user_id"]
    end

    def clerk_user
      @_clerk_user ||= clerk_user_id && clerk_sdk.users.find(clerk_user_id)
    end

    def clerk_user_signed_in?
      !!clerk_user_id
    end

    def require_clerk_session!
      raise AuthenticationRequired unless clerk_session
    end

    included do
      helper_method :clerk_user, :clerk_user_signed_in?
    end
  end
end
