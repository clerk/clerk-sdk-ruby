require "clerk-http-client"
require "clerk/jwks_cache"
require "clerk/version"
require "jwt"

module Clerk
  class SDK < ClerkHttpClient::SDK
    # TODO: Move to constants?
    DEFAULT_HEADERS = {
      "User-Agent": "Clerk/#{Clerk::VERSION}; Faraday/#{Faraday::VERSION}; Ruby/#{RUBY_VERSION}",
      "X-Clerk-SDK": "ruby/#{Clerk::VERSION}" # TODO: Add framework identifier
    }

    # How often (in seconds) should JWKs be refreshed
    JWKS_CACHE_LIFETIME = 3600 # 1 hour / TODO: Move to constants?

    @@jwks_cache = JWKSCache.new(JWKS_CACHE_LIFETIME)

    def self.jwks_cache
      @@jwks_cache
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
    def verify_token(token, force_refresh_jwks: false, algorithms: ["RS256"], timeout: 5)
      jwk_loader = ->(options) do
        # JWT.decode requires that the 'keys' key in the Hash is a symbol (as
        # opposed to a string which our SDK returns by default)
        {keys: SDK.jwks_cache.fetch(self, kid_not_found: options[:invalidate] || options[:kid_not_found], force_refresh: force_refresh_jwks)}
      end

      JWT.decode(token, nil, true, algorithms: algorithms, exp_leeway: timeout, jwks: jwk_loader).first
    end
  end
end
