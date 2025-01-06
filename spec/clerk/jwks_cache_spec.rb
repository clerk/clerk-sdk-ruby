require "spec_helper"

RSpec.describe Clerk::JWKSCache do
  let(:lifetime) { 3600 } # 1 hour cache lifetime
  let(:cache) { described_class.new(lifetime) }
  let(:sdk) { Clerk::SDK.new }
  let(:jwks_api) { instance_double("ClerkHttpClient::JWKSApi") }
  let(:mock_keys) { [double(to_hash: {kid: "key1"}), double(to_hash: {kid: "key2"})] }
  let(:expected_result) { mock_keys.map(&:to_hash) }

  before do
    allow(sdk).to receive(:jwks).and_return(jwks_api)
    allow(jwks_api).to receive(:get).and_return(double(keys: mock_keys))
  end

  describe "#fetch" do
    it "fetches and caches JWKS on first call" do
      result = cache.fetch(sdk)
      expect(result).to eq(expected_result)
    end

    it "returns cached result on subsequent calls within lifetime" do
      first_result = cache.fetch(sdk)
      expect(jwks_api).to have_received(:get).once

      second_result = cache.fetch(sdk)
      expect(second_result).to eq(first_result)
      expect(jwks_api).to have_received(:get).once
    end

    it "refreshes cache when force_refresh is true" do
      cache.fetch(sdk)
      expect(jwks_api).to have_received(:get).once

      cache.fetch(sdk, force_refresh: true)
      expect(jwks_api).to have_received(:get).twice
    end

    it "refreshes cache when lifetime has expired" do
      cache.fetch(sdk)
      expect(jwks_api).to have_received(:get).once

      allow(Time).to receive(:now).and_return(Time.now + lifetime + 1)

      cache.fetch(sdk)
      expect(jwks_api).to have_received(:get).twice
    end

    it "refreshes cache when kid_not_found is true and last update was over 5 minutes ago" do
      cache.fetch(sdk)
      expect(jwks_api).to have_received(:get).once

      allow(Time).to receive(:now).and_return(Time.now + 301) # 5 minutes + 1 second

      cache.fetch(sdk, kid_not_found: true)
      expect(jwks_api).to have_received(:get).twice
    end

    it "returns nil when API call fails" do
      allow(jwks_api).to receive(:get).and_raise(ClerkHttpClient::ApiError)

      result = cache.fetch(sdk)
      expect(result).to be_nil
    end
  end
end
