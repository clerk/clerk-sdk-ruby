# frozen_string_literal: true

require 'base64'
require 'faraday'
require 'faraday/adapter/test'
require 'json'
require 'jwt'
require 'minitest/autorun'
require 'openssl'
require_relative '../../lib/clerk'

# Regression test for AISEC-84. The JWKS cache was a single class variable
# shared by every Clerk::SDK in the process, and verify_token performs no
# issuer check. While the cache held one instance's keys, a token minted by
# that instance verified against any other instance's SDK.
class JwksCacheScopingTest < Minitest::Test
  Tenant = Struct.new(:sdk, :token, :fetches)

  def test_cached_keys_are_not_served_to_another_instance
    tenant_a = build_tenant('tenant_a')
    tenant_b = build_tenant('tenant_b')

    # A legitimate tenant-B verification loads tenant B's keys.
    claims = tenant_b.sdk.verify_token(tenant_b.token)
    assert_equal 'user_tenant_b', claims['sub']
    assert_equal ['tenant_b'], tenant_b.fetches

    # The same token under tenant A must not resolve against tenant B's keys.
    assert_raises(JWT::DecodeError) do
      tenant_a.sdk.verify_token(tenant_b.token)
    end
    refute_empty tenant_a.fetches, 'tenant A must fetch its own JWKS'
  end

  def test_scope_differs_per_secret_key
    sdk_a = ::Clerk::SDK.new(secret_key: 'sk_test_a', server_url: 'https://api.clerk.com/v1')
    sdk_b = ::Clerk::SDK.new(secret_key: 'sk_test_b', server_url: 'https://api.clerk.com/v1')
    sdk_a_again = ::Clerk::SDK.new(secret_key: 'sk_test_a', server_url: 'https://api.clerk.com/v1')

    refute_equal sdk_a.jwks_cache_scope, sdk_b.jwks_cache_scope
    # The cache must still be shared across SDKs for the same instance, since
    # authenticate_request builds a fresh SDK per request.
    assert_equal sdk_a.jwks_cache_scope, sdk_a_again.jwks_cache_scope
    assert_same ::Clerk::SDK.jwks_cache(sdk_a.jwks_cache_scope),
                ::Clerk::SDK.jwks_cache(sdk_a_again.jwks_cache_scope)
  end

  private

  def build_tenant(name)
    key = OpenSSL::PKey::RSA.generate(2048)
    kid = "ins_#{name}"
    jwk = {
      kty: 'RSA', use: 'sig', alg: 'RS256', kid: kid,
      n: b64(key.n.to_s(2)),
      e: b64(key.e.to_s(2))
    }

    fetches = []
    stubs = Faraday::Adapter::Test::Stubs.new
    stubs.get('/v1/jwks') do
      fetches << name
      [200, {'Content-Type' => 'application/json'}, JSON.generate(keys: [jwk])]
    end
    client = Faraday.new { |builder| builder.adapter :test, stubs }

    sdk = ::Clerk::SDK.new(
      secret_key: "sk_test_#{name}",
      client: client,
      server_url: 'https://api.clerk.com/v1'
    )
    token = JWT.encode(
      {sub: "user_#{name}", exp: Time.now.to_i + 3600},
      key, 'RS256', {kid: kid}
    )

    Tenant.new(sdk, token, fetches)
  end

  def b64(bytes)
    Base64.urlsafe_encode64(bytes, padding: false)
  end
end
