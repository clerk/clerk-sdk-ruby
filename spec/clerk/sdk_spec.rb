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
      actor_tokens: ClerkBackend::ActorTokensApi,
      allowlist: ClerkBackend::AllowListBlockListApi,
      beta_features: ClerkBackend::BetaFeaturesApi,
      blocklist: ClerkBackend::AllowListBlockListApi,
      clients: ClerkBackend::ClientsApi,
      domains: ClerkBackend::DomainsApi,
      email_addresses: ClerkBackend::EmailAddressesApi,
      email_sms_templates: ClerkBackend::EmailSMSTemplatesApi,
      instance_settings: ClerkBackend::InstanceSettingsApi,
      invitations: ClerkBackend::InvitationsApi,
      jwks: ClerkBackend::JWKSApi,
      jwt_templates: ClerkBackend::JWTTemplatesApi,
      miscellaneous: ClerkBackend::MiscellaneousApi,
      oauth_applications: ClerkBackend::OAuthApplicationsApi,
      organization_domain: ClerkBackend::OrganizationDomainApi,
      organization_domains: ClerkBackend::OrganizationDomainsApi,
      organization_invitations: ClerkBackend::OrganizationInvitationsApi,
      organization_memberships: ClerkBackend::OrganizationMembershipsApi,
      organizations: ClerkBackend::OrganizationsApi,
      phone_numbers: ClerkBackend::PhoneNumbersApi,
      proxy_checks: ClerkBackend::ProxyChecksApi,
      redirect_urls: ClerkBackend::RedirectURLsApi,
      saml_connections: ClerkBackend::SAMLConnectionsApi,
      sessions: ClerkBackend::SessionsApi,
      sign_in_tokens: ClerkBackend::SignInTokensApi,
      sign_ups: ClerkBackend::SignUpsApi,
      testing_tokens: ClerkBackend::TestingTokensApi,
      users: ClerkBackend::UsersApi,
      webhooks: ClerkBackend::WebhooksApi
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
