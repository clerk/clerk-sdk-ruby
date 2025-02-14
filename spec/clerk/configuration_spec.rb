# frozen_string_literal: true

require "spec_helper"
require "logger"

RSpec.describe Clerk::Configuration do
  let(:valid_pk) { "pk_test_key" }
  let(:valid_sk) { "sk_test_key" }

  describe "#initialize" do
    it "initializes with default values" do
      with_modified_env(CLERK_PUBLISHABLE_KEY: valid_pk, CLERK_SECRET_KEY: valid_sk) do
        config = described_class.new

        expect(config.excluded_routes).to eq([])
        expect(config.publishable_key).to eq(ENV["CLERK_PUBLISHABLE_KEY"])
        expect(config.secret_key).to eq(ENV["CLERK_SECRET_KEY"])
        expect(config.cache_store).to be_nil
        expect(config.logger).to be_nil
      end
    end

    it "initializes ClerkHttpClient with the secret key" do
      with_modified_env(CLERK_SECRET_KEY: valid_sk) do
        described_class.new
        expect(ClerkHttpClient::Configuration.default.access_token).to eq(ENV["CLERK_SECRET_KEY"])
      end
    end

    context "cache store defaults" do
      context "when ::Rails is defined" do
        before do
          stub_const("Rails", Class.new)
          allow(Rails).to receive(:cache)
        end

        it "uses Rails.cache as the default cache store" do
          expect(described_class.new.cache_store).to eq(Rails.cache)
        end
      end

      context "when ::ActiveSupport::Cache::MemoryStore is defined" do
        before do
          stub_const("ActiveSupport::Cache::MemoryStore", Class.new)
        end

        it "uses ActiveSupport::Cache::MemoryStore as the default cache store" do
          expect(described_class.new.cache_store).to be_an_instance_of(ActiveSupport::Cache::MemoryStore)
        end
      end

      context "when neither is defined" do
        it "returns nil" do
          expect(described_class.new.cache_store).to be_nil
        end
      end
    end
  end

  describe "#update" do
    it "updates multiple configuration options" do
      config = described_class.new
      options = {
        publishable_key: valid_pk,
        secret_key: valid_sk,
        excluded_routes: ["/health"]
      }

      config.update(options)

      expect(config.publishable_key).to eq(valid_pk)
      expect(config.secret_key).to eq(valid_sk)
      expect(config.excluded_routes).to eq(["/health"])
    end
  end

  describe "#cache_store=" do
    let(:valid_cache) { double("cache_store", fetch: nil) }

    it "accepts a valid cache store" do
      config = described_class.new
      config.cache_store = valid_cache
      expect(config.cache_store).to eq(valid_cache)
    end

    it "allows setting to nil" do
      config = described_class.new
      config.cache_store = nil
      expect(config.cache_store).to be_nil
    end

    it "raises error when cache store doesn't respond to fetch" do
      config = described_class.new
      invalid_cache = double("invalid_cache")

      expect { config.cache_store = invalid_cache }
        .to raise_error(ArgumentError, "cache_store must respond to :fetch")
    end
  end

  describe "#excluded_routes=" do
    it "accepts an array of strings" do
      config = described_class.new
      routes = ["/health", "/status"]

      config.excluded_routes = routes
      expect(config.excluded_routes).to eq(routes)
    end

    it "raises error when input is not an array" do
      config = described_class.new

      expect { config.excluded_routes = "not_an_array" }
        .to raise_error(ArgumentError, "excluded_routes must be an array")
    end

    it "raises error when array contains non-string elements" do
      config = described_class.new

      expect { config.excluded_routes = ["/health", 123] }
        .to raise_error(ArgumentError, "All elements in the excluded_routes array must be strings")
    end
  end

  describe "#publishable_key=" do
    it "accepts a valid publishable key" do
      config = described_class.new
      config.publishable_key = valid_pk
      expect(config.publishable_key).to eq(valid_pk)
    end

    it "raises error when key doesn't start with 'pk_'" do
      config = described_class.new

      expect { config.publishable_key = "invalid_key" }
        .to raise_error(ArgumentError, "publishable_key must start with 'pk_'")
    end
  end

  describe "#secret_key=" do
    it "accepts a valid secret key" do
      config = described_class.new
      config.secret_key = valid_sk
      expect(config.secret_key).to eq(valid_sk)
    end

    it "raises error when key doesn't start with 'sk_'" do
      config = described_class.new

      expect { config.secret_key = "invalid_key" }
        .to raise_error(ArgumentError, "secret_key must start with 'sk_'")
    end

    it "updates ClerkHttpClient configuration" do
      config = described_class.new
      expect(ClerkHttpClient::Configuration.default)
        .to receive(:access_token=)
        .with(valid_sk)

      config.secret_key = valid_sk
    end
  end

  describe "#debug=" do
    it "updates debug flag and ClerkHttpClient configuration" do
      config = described_class.new
      expect(ClerkHttpClient::Configuration.default)
        .to receive(:debugging=)
        .with(true)

      config.debug = true
      expect(config.debug).to be true
    end
  end

  describe "#logger=" do
    it "updates logger ClerkHttpClient configuration" do
      config = described_class.new
      logger = Logger.new($stdout)
      expect(ClerkHttpClient::Configuration.default)
        .to receive(:logger=)
        .with(logger)

      config.logger = logger
      expect(config.logger).to be_a(Logger)
    end
  end

  describe ".default" do
    it "returns the same instance on multiple calls" do
      instance1 = described_class.default
      instance2 = described_class.default

      expect(instance1).to be(instance2)
    end
  end
end
