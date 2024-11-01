require 'clerk'
require_relative 'authenticate_context'
require_relative 'authenticate_request'

module Clerk
  class Proxy
    attr_reader :session_id, :error

    def initialize(env)
      req = Rack::Request.new(env)
      @token = req.cookies[SESSION_COOKIE]
      @session_id = req.params['_clerk_session_id']
      @session = nil
      @user_id = nil
      @user = nil
    end

    def session
      return nil if @token.nil?
      return @session if @session

      begin
        @session = fetch_session
      rescue Errors::Authentication => e
        @error = e
      end
      @session
    end

    def user_id
      @user_id ||= session.dig('user_id')
    end

    def user
      return nil if session.nil?

      @user ||= fetch_user(user_id)
    end

    def debug
      (instance_variables - [:@sdk]).map do |ivar|
        [ivar.to_s, instance_variable_get(ivar)]
      end.to_h
    end

    private

    def sdk
      @sdk ||= SDK.new
    end

    def cache_key
      @cache_key ||= @token.split('.')[1]
    end

    def fetch_session
      if session_id
        cached_fetch("clerk_session:#{session_id}:#{cache_key}") do
          sdk.sessions.verify_token(session_id, @token)
        end
      else
        cached_fetch("clerk_session:#{cache_key}") do
          client = sdk.clients.verify_token(@token)
          @session_id = client['last_active_session_id']
          client['sessions'].find do |sess|
            sess['id'] == @session_id
          end
        end
      end
    end

    def fetch_user(user_id)
      cached_fetch("clerk_user:#{user_id}") do
        sdk.users.find(user_id)
      end
    end

    def cached_fetch(key, &block)
      if store = Clerk.configuration.middleware_cache_store
        store.fetch(key, expires_in: cache_ttl, &block)
      else
        yield
      end
    end

    def cache_ttl
      60
    end
  end

  class ProxyV2
    CACHE_TTL = 60 # seconds

    attr_reader :session_claims, :session_token

    def initialize(session_claims: nil, session_token: nil)
      @session_claims = session_claims
      @session_token = session_token
    end

    def user
      return nil if user_id.nil?

      @user ||= fetch_user(user_id)
    end

    def user_id
      return nil if @session_claims.nil?

      @session_claims['sub']
    end

    def org
      return nil if org_id.nil?

      @org ||= fetch_org(org_id)
    end

    def org_id
      return nil if user_id.nil?

      @session_claims['org_id']
    end

    def org_role
      return nil if @session_claims.nil?

      @session_claims['org_role']
    end

    def org_permissions
      return nil if @session_claims.nil?

      @session_claims['org_permissions']
    end

    # Returns true if the session needs to perform step up verification
    def needs_reverification?(params)
      return false if session_claims.nil?

      fva           = session_claims["fva"]
      level         = params[:level]
      after_minutes = Integer(params[:after_minutes])

      return false if fva.nil? || after_minutes.nil? || level.nil?

      factor1_age, factor2_age = fva
      factor1_enabled = (factor1_age == -1 ? false : after_minutes > factor1_age)
      factor2_enabled = (factor2_age == -1 ? false : after_minutes > factor2_age)

      case level
      when :first_factor  then factor1_enabled
      when :second_factor then factor2_enabled
      when :multi_factor
        factor2_age == -1 ? factor1_enabled : factor1_enabled && factor2_enabled
      end
    end

    def reverification_mismatch_response(missing_config={})
      payload = {
        clerk_error: {
          type:     "forbidden",
          reason:   "reverification-mismatch",
          metadata: { reverification: missing_config, }
        }
      }

      [403, { "Content-Type" => "application/json" }, [payload.to_json]]
    end

    private

    def fetch_user(user_id)
      cached_fetch("clerk_user:#{user_id}") do
        sdk.users.find(user_id)
      end
    end

    def fetch_org(org_id)
      cached_fetch("clerk_org:#{org_id}") do
        sdk.organizations.find(org_id)
      end
    end

    def cached_fetch(key, &block)
      if store = Clerk.configuration.middleware_cache_store
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
