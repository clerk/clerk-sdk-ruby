require "spec_helper"
require "clerk/utils"

RSpec.describe Clerk::Utils do
  describe ".filter_routes" do
    it "converts regular routes into a hash with true values" do
      routes = ["/api/v1/users", "/api/v1/posts"]
      filtered_routes, wildcard_routes = described_class.filter_routes(routes)

      expect(filtered_routes).to eq({
        "/api/v1/users" => true,
        "/api/v1/posts" => true
      })
      expect(wildcard_routes).to be_empty
    end

    it "handles wildcard routes correctly" do
      routes = ["/api/v1/*", "/admin/*"]
      filtered_routes, wildcard_routes = described_class.filter_routes(routes)

      expect(filtered_routes).to be_empty
      expect(wildcard_routes).to eq(["/api/v1/", "/admin/"])
    end

    it "handles mixed regular and wildcard routes" do
      routes = ["/api/v1/users", "/api/v1/*", "/admin/dashboard", "/admin/*"]
      filtered_routes, wildcard_routes = described_class.filter_routes(routes)

      expect(filtered_routes).to eq({
        "/api/v1/users" => true,
        "/admin/dashboard" => true
      })
      expect(wildcard_routes).to eq(["/api/v1/", "/admin/"])
    end

    it "removes duplicate wildcard routes" do
      routes = ["/api/v1/*", "/api/v1/*", "/admin/*"]
      filtered_routes, wildcard_routes = described_class.filter_routes(routes)

      expect(filtered_routes).to be_empty
      expect(wildcard_routes).to eq(["/api/v1/", "/admin/"])
    end

    it "handles routes with whitespace" do
      routes = [" /api/v1/users ", "  /api/v1/*  "]
      filtered_routes, wildcard_routes = described_class.filter_routes(routes)

      expect(filtered_routes).to eq({
        "/api/v1/users" => true
      })
      expect(wildcard_routes).to eq(["/api/v1/"])
    end
  end

  describe "#valid_publishable_key?" do
    it "returns true for valid live publishable key" do
      valid_key = "pk_live_#{Base64.encode64("test$")}"
      expect(described_class.valid_publishable_key?(valid_key)).to be true
    end

    it "returns true for valid test publishable key" do
      valid_key = "pk_test_#{Base64.encode64("test$")}"
      expect(described_class.valid_publishable_key?(valid_key)).to be true
    end

    it "returns false for invalid prefix" do
      invalid_key = "invalid_#{Base64.encode64("test$")}"
      expect(described_class.valid_publishable_key?(invalid_key)).to be false
    end

    it "returns false for invalid postfix" do
      invalid_key = "pk_test_#{Base64.encode64("test")}"
      expect(described_class.valid_publishable_key?(invalid_key)).to be false
    end

    it "raises ArgumentError when key cannot be converted to string" do
      expect {
        described_class.valid_publishable_key?(Object.new)
      }.to raise_error(ArgumentError, "publishable_key must be a string")
    end
  end

  describe "#valid_publishable_key_prefix?" do
    it "returns true for pk_live_ prefix" do
      expect(described_class.valid_publishable_key_prefix?("pk_live_abc")).to be true
    end

    it "returns true for pk_test_ prefix" do
      expect(described_class.valid_publishable_key_prefix?("pk_test_abc")).to be true
    end

    it "returns false for invalid prefix" do
      expect(described_class.valid_publishable_key_prefix?("invalid_abc")).to be false
    end
  end

  describe "#valid_publishable_key_postfix?" do
    it "returns true when decoded key ends with $" do
      key = "pk_test_#{Base64.encode64("test$")}"
      expect(described_class.valid_publishable_key_postfix?(key)).to be true
    end

    it "returns false when decoded key does not end with $" do
      key = "pk_test_#{Base64.encode64("test")}"
      expect(described_class.valid_publishable_key_postfix?(key)).to be false
    end
  end

  describe "#decode_publishable_key" do
    it "correctly decodes the third part of the key" do
      encoded = Base64.encode64("test")
      key = "pk_test_#{encoded}"
      expect(described_class.decode_publishable_key(key)).to eq "test"
    end

    it "handles invalid key format gracefully" do
      expect(described_class.decode_publishable_key("invalid")).to eq ""
    end
  end

  describe "#retrieve_from_query_string" do
    let(:host) { "http://example.com" }

    it "retrieves value from query string" do
      url = URI("#{host}?key=value")
      expect(described_class.retrieve_from_query_string(url, "key")).to eq "value"
    end

    it "returns nil when key is not present" do
      url = URI("#{host}?other=value")
      expect(described_class.retrieve_from_query_string(url, "key")).to be_nil
    end

    it "handles empty query string" do
      url = URI(host)
      expect(described_class.retrieve_from_query_string(url, "key")).to be_nil
    end
  end
end
