# frozen_string_literal: true

RSpec.describe Clerk do
  it "has a version number" do
    expect(Clerk::VERSION).not_to be nil
  end

  describe ".configure" do
    let(:publishable_key) { "pk_test_key" }

    context "when a block is given" do
      it "yields the configuration object" do
        expect { |b| Clerk.configure(&b) }.to yield_with_args(Clerk::Configuration)
      end

      it "allows configuration to be set" do
        Clerk.configure do |config|
          config.publishable_key = publishable_key
        end

        expect(Clerk.configuration.publishable_key).to eq(publishable_key)
      end
    end

    context "when no block is given" do
      it "returns the configuration object" do
        expect(Clerk.configure).to be_an_instance_of(Clerk::Configuration)
      end
    end
  end

  describe ".configuration" do
    it "returns a Configuration instance" do
      expect(Clerk.configuration).to be_an_instance_of(Clerk::Configuration)
    end

    it "memoizes the configuration" do
      config = Clerk.configuration
      expect(Clerk.configuration).to be(config)
    end

    it "returns the default configuration initially" do
      allow(Clerk::Configuration).to receive(:default).and_return(double("default_config"))

      # Reset the memoized configuration
      Clerk.instance_variable_set(:@configuration, nil)

      expect(Clerk::Configuration).to receive(:default)
      Clerk.configuration
    end
  end
end
