# frozen_string_literal: true

require 'clerk/jwks_cache'
require 'clerk/openapiclient'
# require 'clerk/version'
require 'jwt'

module Clerk
  class SDK < Clerk::OpenAPIClient
    # DEFAULT_HEADERS = {
    #   "User-Agent": "Clerk/#{Clerk::VERSION}; Faraday/#{Faraday::VERSION}; Ruby/#{RUBY_VERSION}",
    #   "X-Clerk-SDK": "ruby/#{Clerk::VERSION}",
    #   "Clerk-API-Version": "2025-04-10",
    # }

    # How often (in seconds) should JWKs be refreshed
    JWKS_CACHE_LIFETIME = 3600 # 1 hour

    # rubocop:disable Style/ClassVars
    @@jwks_cache = JWKSCache.new(JWKS_CACHE_LIFETIME)
    # rubocop:enable Style/ClassVars
    
    def self.jwks_cache
      @@jwks_cache
    end

    def initialize(client: nil, retry_config: nil, timeout_ms: nil, secret_key: nil, security_source: nil, server_idx: nil, server_url: nil, url_params: nil)
      secret_key ||= Clerk.configuration.secret_key
      super(
        client: client,
        retry_config: retry_config,
        timeout_ms: timeout_ms,
        bearer_auth: secret_key,
        security_source: security_source,
        server_idx: server_idx,
        server_url: server_url,
        url_params: url_params
      )
    end

    # Returns the decoded JWT payload without verifying if the signature is valid.
    #
    # WARNING: This will not verify whether the signature is valid. You should not
    # use this for untrusted messages! You most likely want to use `verify_token`.
    def decode_token(token)
      JWT.decode(token, nil, false).first
    end

    # Decode the JWT and verify it's valid (verify claims, signature etc.) using the provided algorithms.
    #
    # JWKS are cached for JWKS_CACHE_LIFETIME seconds, in order to avoid unecessary roundtrips.
    # In order to invalidate the cache, pass `force_refresh_jwks: true`.
    #
    # A timeout for the request to the JWKs endpoint can be set with the `timeout` argument.
    def verify_token(token, force_refresh_jwks: false, algorithms: ['RS256'], timeout: 5)
      jwk_loader = lambda do |options|
        # JWT.decode requires that the 'keys' key in the Hash is a symbol (as
        # opposed to a string which our SDK returns by default)
        {keys: SDK.jwks_cache.fetch(self, kid_not_found: options[:invalidate] || options[:kid_not_found], force_refresh: force_refresh_jwks)}
      end

      begin
        claims = JWT.decode(token, nil, true, algorithms: algorithms, exp_leeway: timeout, jwks: jwk_loader).first
      rescue JWT::ExpiredSignature => e
        raise e
      rescue JWT::InvalidIatError => e
        raise e
      rescue JWT::DecodeError => e
        raise e
      rescue StandardError => e
        raise e
      end

      # orgs
      if claims['v'].nil? || claims['v'] == 1
        claims['v'] = 1
      elsif claims['v'] == 2 && claims['o']
        claims['org_id']          = claims['o'].fetch('id', nil)
        claims['org_slug']        = claims['o'].fetch('slg', nil)
        claims['org_role']        = "org:#{claims['o'].fetch('rol', nil)}"

        org_permissions = compute_org_permissions_from_v2_token(claims)
        claims['org_permissions'] = org_permissions if org_permissions.any?
        claims.delete('o')
        claims.delete('fea')
      end

      claims
    end

    private

    def compute_org_permissions_from_v2_token(claims)
      features    = claims['fea'] ? claims['fea'].split(',') : []
      permissions = claims['o']['per'] ? claims['o']['per'].split(',') : []
      mappings    = claims['o']['fpm'] ? claims['o']['fpm'].split(',') : []
      org_permissions = []

      mappings.each_with_index do |mapping, i|
        scope, feature = features[i].split(':')

        next if !scope.include?('o') # not an orgs-related permission

        mapping.to_i.to_s(2).reverse.each_char.each_with_index do |bit, j|
          org_permissions << "org:#{feature}:#{permissions[j]}" if bit == '1'
        end
      end

      org_permissions
    end
  end
end
