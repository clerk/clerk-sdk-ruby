# frozen_string_literal: true

require "spec_helper"
require "clerk/authenticatable"

RSpec.describe Clerk::Authenticatable do
  let(:klass) do
    Class.new do
      include Clerk::Authenticatable

      attr_reader :request

      def initialize(request)
        @request = request
      end

      def render(options = {})
        @render_options = options
      end

      attr_reader :render_options
    end
  end

  let(:clerk_client) { instance_double("ClerkClient") }
  let(:request) { double("Request", env: {"clerk" => clerk_client}) }
  let(:controller) { klass.new(request) }

  describe "#clerk" do
    it "returns the clerk client from request.env" do
      expect(controller.send(:clerk)).to eq(clerk_client)
    end
  end

  describe "#require_reverification!" do
    let(:preset) { Clerk::StepUp::Preset::STRICT }

    context "when block is given" do
      it "yields to the block when reverification is required" do
        expect(clerk_client).to receive(:user_require_reverification!).with(preset).and_yield

        block_called = false
        controller.send(:require_reverification!, preset) { block_called = true }

        expect(block_called).to be true
      end
    end

    context "when no block is given" do
      it "renders reverification error" do
        expect(clerk_client).to receive(:user_require_reverification!).with(preset).and_yield

        controller.send(:require_reverification!, preset)

        expect(controller.render_options).to eq({
          status: 403,
          json: Clerk::StepUp::Reverification.error_payload(preset)
        })
      end
    end
  end

  describe "#render_reverification!" do
    let(:preset) { Clerk::StepUp::Preset::STRICT }
    let(:error_payload) { Clerk::StepUp::Reverification.error_payload(preset) }

    before do
      allow(Clerk::StepUp::Reverification).to receive(:error_payload).with(preset).and_return(error_payload)
    end

    it "renders error payload with 403 status" do
      controller.send(:render_reverification!, preset)

      expect(controller.render_options).to eq({
        status: 403,
        json: error_payload
      })
    end
  end

  describe "helper_method registration" do
    it "registers clerk helper methods" do
      expect(klass.class).to receive(:helper_method).with(:clerk, :require_reverification!, :render_reverification!)
      klass.class.send(:include, described_class)
    end
  end
end
