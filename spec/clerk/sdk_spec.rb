require "spec_helper"

RSpec.describe Clerk::SDK do
  let(:secret_key) { OpenSSL::PKey::RSA.new(2048) }
  let(:public_key) { secret_key.public_key }

  let(:kid) { "test-key-id" }
  let(:sk) { "sk_test_123" }
  let(:sub) { "user_123" }

  let(:valid_payload) do
    {
      sub: sub,
      exp: Time.now.to_i + 3600,
      iat: Time.now.to_i
    }
  end

  let(:valid_token) do
    JWT.encode(valid_payload, secret_key, "RS256", {kid: kid})
  end

  let(:expired_payload) do
    {
      sub: sub,
      exp: Time.now.to_i - 3600,
      iat: Time.now.to_i - 7200
    }
  end

  let(:expired_token) do
    JWT.encode(expired_payload, secret_key, "RS256", {kid: kid})
  end

  let(:jwk) do
    JWT::JWK.new(public_key, kid: kid).export
  end

  let(:clerk_client) { described_class.new(sk) }

  describe "#decode_token" do
    it "decodes a valid token without verification" do
      result = clerk_client.decode_token(valid_token)
      expect(result["sub"]).to eq(sub)
    end

    it "decodes an expired token without verification" do
      result = clerk_client.decode_token(expired_token)
      expect(result["sub"]).to eq(sub)
    end

    it "raises error for invalid JWT format" do
      expect {
        clerk_client.decode_token("invalid.token.format")
      }.to raise_error(JWT::DecodeError)
    end
  end

  describe "#verify_token" do
    before do
      allow(described_class.jwks_cache).to receive(:fetch).and_return([jwk])
    end

    it "verifies and decodes a valid token" do
      result = clerk_client.verify_token(valid_token)
      expect(result["sub"]).to eq(sub)
    end

    it "raises error for expired token" do
      expect {
        clerk_client.verify_token(expired_token)
      }.to raise_error(JWT::ExpiredSignature)
    end

    it "raises error for invalid signature" do
      different_key = OpenSSL::PKey::RSA.new(2048)
      invalid_token = JWT.encode(valid_payload, different_key, "RS256", {kid: kid})

      expect {
        clerk_client.verify_token(invalid_token)
      }.to raise_error(JWT::VerificationError)
    end

    context "when forcing JWKS refresh" do
      it "forces cache refresh when flag is set" do
        expect(described_class.jwks_cache).to receive(:fetch).with(
          clerk_client,
          kid_not_found: nil,
          force_refresh: true
        )

        clerk_client.verify_token(valid_token, force_refresh_jwks: true)
      end
    end

    context "with different algorithms" do
      it "accepts specified algorithms" do
        result = clerk_client.verify_token(valid_token, algorithms: ["RS256"])
        expect(result["sub"]).to eq(sub)
      end

      it "raises error for unaccepted algorithms" do
        expect {
          clerk_client.verify_token(valid_token, algorithms: ["HS256"])
        }.to raise_error(JWT::IncorrectAlgorithm)
      end
    end
  end

  describe "SDK helpers" do
    {
      actor_tokens: ClerkHttpClient::ActorTokensApi,
      allowlist: ClerkHttpClient::AllowListBlockListApi,
      beta_features: ClerkHttpClient::BetaFeaturesApi,
      blocklist: ClerkHttpClient::AllowListBlockListApi,
      clients: ClerkHttpClient::ClientsApi,
      domains: ClerkHttpClient::DomainsApi,
      email_addresses: ClerkHttpClient::EmailAddressesApi,
      email_sms_templates: ClerkHttpClient::EmailSMSTemplatesApi,
      instance_settings: ClerkHttpClient::InstanceSettingsApi,
      invitations: ClerkHttpClient::InvitationsApi,
      jwks: ClerkHttpClient::JWKSApi,
      jwt_templates: ClerkHttpClient::JWTTemplatesApi,
      miscellaneous: ClerkHttpClient::MiscellaneousApi,
      oauth_applications: ClerkHttpClient::OAuthApplicationsApi,
      organization_domain: ClerkHttpClient::OrganizationDomainApi,
      organization_domains: ClerkHttpClient::OrganizationDomainsApi,
      organization_invitations: ClerkHttpClient::OrganizationInvitationsApi,
      organization_memberships: ClerkHttpClient::OrganizationMembershipsApi,
      organizations: ClerkHttpClient::OrganizationsApi,
      phone_numbers: ClerkHttpClient::PhoneNumbersApi,
      proxy_checks: ClerkHttpClient::ProxyChecksApi,
      redirect_urls: ClerkHttpClient::RedirectURLsApi,
      saml_connections: ClerkHttpClient::SAMLConnectionsApi,
      sessions: ClerkHttpClient::SessionsApi,
      sign_in_tokens: ClerkHttpClient::SignInTokensApi,
      sign_ups: ClerkHttpClient::SignUpsApi,
      testing_tokens: ClerkHttpClient::TestingTokensApi,
      users: ClerkHttpClient::UsersApi,
      webhooks: ClerkHttpClient::WebhooksApi
    }.each do |method, instance_class|
      it "##{method} returns an instance of #{instance_class}" do
        expect(clerk_client.send(:respond_to?, method)).to be true
        expect(clerk_client.send(method)).to be_an_instance_of(instance_class)
      end
    end

    it "should appropriately report on methods that are not implemented" do
      expect(clerk_client.respond_to?(:foo)).to be false
      expect {
        clerk_client.foo
      }.to raise_error(NoMethodError, "undefined method `foo` for #{clerk_client.class.name}")
    end
  end
end
