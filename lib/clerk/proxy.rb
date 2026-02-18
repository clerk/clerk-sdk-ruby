# frozen_string_literal: true

require 'clerk'
require 'clerk/authenticate_context'
require 'clerk/authenticate_request'

module Clerk
  class Proxy
    CACHE_TTL = 60 # seconds

    def initialize(session_claims: nil, session_token: nil)
      @session_claims = session_claims
      @session_token = session_token
    end

    def session
      @session_claims
    end

    def user?
      !@session_claims.nil?
    end

    def user
      return nil unless user?

      @user ||= fetch_user(user_id)
    end

    def user_id
      return nil unless user?

      @session_claims['sub']
    end

    def organization?
      !organization_id.nil?
    end

    def organization
      return nil unless organization?

      @organization ||= fetch_org(organization_id)
    end

    def organization_id
      return nil unless user?

      @session_claims['org_id']
    end

    def organization_role
      return nil if @session_claims.nil?

      @session_claims['org_role']
    end

    def organization_permissions
      return nil if @session_claims.nil?

      @session_claims['org_permissions']
    end

    # Returns true if the session needs to perform step up verification
    def user_reverified?(params)
      return false unless user?

      fva = @session_claims['fva']

      # the feature is disabled
      return true if fva.nil?

      level = params[:level]
      after_minutes = params[:after_minutes].to_i

      return false if after_minutes.nil? || level.nil?

      factor1_age, factor2_age = fva
      is_valid_factor1 = factor1_age != -1 && after_minutes > factor1_age
      is_valid_factor2 = factor2_age != -1 && after_minutes > factor2_age

      case level
      when :first_factor
        is_valid_factor1
      when :second_factor
        factor2_age == -1 ? is_valid_factor1 : is_valid_factor2
      when :multi_factor
        factor2_age == -1 ? is_valid_factor1 : is_valid_factor1 && is_valid_factor2
      end
    end

    def user_needs_reverification?(preset = StepUp::Preset::STRICT)
      !user_reverified?(preset)
    end

    def user_require_reverification!(preset = StepUp::Preset::STRICT, &block)
      return unless user_needs_reverification?(preset)
      yield(preset) if block_given?
    end

    def user_reverification_rack_response(config = nil)
      raise ArgumentError, 'Missing config, please pass a preset a la `Clerk::StepUp::Preset::*`' if config.nil?

      [
        403,
        {Clerk::CONTENT_TYPE_HEADER => 'application/json'},
        [StepUp::Reverification.error_payload(config).to_json]
      ]
    end

    def sign_in_url
      ENV['CLERK_SIGN_IN_URL']
    end

    def sign_out_url
      ENV['CLERK_SIGN_OUT_URL']
    end

    def sign_up_url
      ENV['CLERK_SIGN_UP_URL']
    end

    private

    def fetch_user(user_id)
      cached_fetch("clerk:user:#{user_id}") do
        sdk.users.get(user_id: user_id).user
      end
    end

    def fetch_org(org_id)
      cached_fetch("clerk:org:#{org_id}") do
        sdk.organizations.get(org_id: org_id).organization
      end
    end

    def cached_fetch(key, &block)
      store = Clerk.configuration.cache_store

      if store
        store.fetch(key, expires_in: CACHE_TTL, &block)
      else
        yield
      end
    end

    def sdk
      @sdk ||= Clerk::SDK.new
    end
  end
end
