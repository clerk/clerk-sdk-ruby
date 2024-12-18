require "spec_helper"

RSpec.describe Clerk::Proxy do
  let(:user_id) { "user_123" }
  let(:org_id) { "org_456" }
  let(:session_claims) do
    {
      "sub" => user_id,
      "org_id" => org_id,
      "org_role" => "admin",
      "org_permissions" => ["read", "write"],
      "fva" => [10, 5]
    }
  end
  let(:session_token) { "test_token" }
  let(:proxy) { described_class.new(session_claims: session_claims, session_token: session_token) }
  let(:sdk_double) { instance_double(Clerk::SDK) }

  before do
    allow(Clerk::SDK).to receive(:new).and_return(sdk_double)
  end

  describe "#user?" do
    it "returns true when session_claims exists" do
      expect(proxy.user?).to be true
    end

    it "returns false when session_claims is nil" do
      proxy = described_class.new
      expect(proxy.user?).to be false
    end
  end

  describe "#user" do
    let(:user_object) { double("User") }

    before do
      allow(sdk_double).to receive_message_chain(:users, :find).with(user_id).and_return(user_object)
    end

    it "returns nil when not authenticated" do
      proxy = described_class.new
      expect(proxy.user).to be_nil
    end

    it "fetches and returns user when authenticated" do
      expect(proxy.user).to eq(user_object)
    end

    context "with caching" do
      let(:cache_store) { double("CacheStore") }

      before do
        allow(Clerk.configuration).to receive(:cache_store).and_return(cache_store)
      end

      it "uses cache when available" do
        expect(cache_store).to receive(:fetch).with(
          "clerk:user:#{user_id}",
          expires_in: described_class::CACHE_TTL
        ).and_return(user_object)

        expect(proxy.user).to eq(user_object)
      end
    end
  end

  describe "#organization?" do
    it "returns true when org_id exists" do
      expect(proxy.organization?).to be true
    end

    it "returns false when org_id is nil" do
      proxy = described_class.new(session_claims: {"sub" => user_id})
      expect(proxy.organization?).to be false
    end
  end

  describe "#organization" do
    let(:org_object) { double("Organization") }

    before do
      allow(sdk_double).to receive_message_chain(:organizations, :find).with(org_id).and_return(org_object)
    end

    it "returns nil when no organization" do
      proxy = described_class.new
      expect(proxy.organization).to be_nil
    end

    it "fetches and returns organization when present" do
      expect(proxy.organization).to eq(org_object)
    end
  end

  describe "#organization_role" do
    it "returns nil when no session_claims" do
      proxy = described_class.new
      expect(proxy.organization_role).to be_nil
    end

    it "fetches and returns organization role when present" do
      expect(proxy.organization_role).to eq(session_claims["org_role"])
    end
  end

  describe "#organization_permissions" do
    it "returns nil when no session_claims" do
      proxy = described_class.new
      expect(proxy.organization_permissions).to be_nil
    end

    it "fetches and returns organization permissions when present" do
      expect(proxy.organization_permissions).to eq(session_claims["org_permissions"])
    end
  end

  describe "#user_reverified?" do
    context "with first factor verification" do
      it "returns true when first factor is valid" do
        params = {level: :first_factor, after_minutes: 15}
        expect(proxy.user_reverified?(params)).to be true
      end

      it "returns false when first factor is invalid" do
        params = {level: :first_factor, after_minutes: 5}
        expect(proxy.user_reverified?(params)).to be false
      end
    end

    context "with second factor verification" do
      it "returns true when second factor is valid" do
        params = {level: :second_factor, after_minutes: 10}
        expect(proxy.user_reverified?(params)).to be true
      end

      it "returns false when second factor is invalid" do
        params = {level: :second_factor, after_minutes: 3}
        expect(proxy.user_reverified?(params)).to be false
      end
    end

    context "with multi factor verification" do
      it "returns true when both factors are valid" do
        params = {level: :multi_factor, after_minutes: 15}
        expect(proxy.user_reverified?(params)).to be true
      end

      it "returns false when either factor is invalid" do
        params = {level: :multi_factor, after_minutes: 7}
        expect(proxy.user_reverified?(params)).to be false
      end
    end
  end

  describe "#user_require_reverification!" do
    let(:preset) { {level: :first_factor, after_minutes: 5} }

    it "yields block when reverification is needed" do
      expect { |b| proxy.user_require_reverification!(preset, &b) }.to yield_with_args(preset)
    end

    it "doesn't yield when reverification is not needed" do
      allow(proxy).to receive(:user_needs_reverification?).and_return(false)
      expect { |b| proxy.user_require_reverification!(preset, &b) }.not_to yield_control
    end
  end

  describe "#user_reverification_rack_response" do
    it "returns a rack response array" do
      config = {some: "config"}
      response = proxy.user_reverification_rack_response(config)

      expect(response).to be_an(Array)
      expect(response[0]).to eq(403)
      expect(response[1]).to include("Content-Type" => "application/json")
      expect(response[2]).to be_an(Array)
    end

    it "raises ArgumentError when config is missing" do
      expect { proxy.user_reverification_rack_response(nil) }.to raise_error(ArgumentError)
    end
  end
end
