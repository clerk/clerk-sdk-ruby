# frozen_string_literal: true

require "spec_helper"
require "clerk/authenticate_context"

RSpec.describe Clerk::AuthenticateContext do
  let(:cookies) { {} }
  let(:env) { {} }
  let(:host) { "example.com" }
  let(:port) { 443 }
  let(:url) { "https://example.com/path" }

  let(:request) do
    double(
      cookies: cookies,
      env: env,
      host: host,
      port: port,
      url: url
    )
  end

  let(:publishable_key) { "pk_test_key123" }
  let(:secret_key) { "sk_test_key123" }

  let(:config) do
    double(
      publishable_key: publishable_key,
      secret_key: secret_key
    )
  end

  subject(:context) { described_class.new(request, config) }

  describe "#initialize" do
    it "creates a new context with empty cookies and headers" do
      expect(context.session_token_in_cookie).to be_nil
      expect(context.session_token_in_header).to be_empty
    end
  end

  describe "key validations" do
    context "when secret key is missing" do
      let(:secret_key) { "" }

      it "raises ConfigurationError" do
        expect { context.secret_key }.to raise_error(Clerk::ConfigurationError, "Clerk secret key is not set")
      end
    end

    context "when publishable key is missing" do
      let(:publishable_key) { "" }

      it "raises ConfigurationError" do
        expect { context.publishable_key }.to raise_error(Clerk::ConfigurationError, "Clerk publishable key is not set")
      end
    end
  end

  describe "#publishable_key" do
    context "when publishable key is present" do
      it "returns the publishable key" do
        expect(context.publishable_key).to eq("pk_test_key123")
      end
    end

    context "when publishable key is missing" do
      let(:publishable_key) { nil }

      it "raises ConfigurationError" do
        expect { context.publishable_key }.to raise_error(Clerk::ConfigurationError, "Clerk publishable key is not set")
      end
    end
  end

  describe "#development_instance?" do
    it "returns true for test secret key" do
      expect(context.development_instance?).to be true
    end

    context "with live secret key" do
      let(:secret_key) { "sk_live_key123" }

      it "returns false" do
        expect(context.development_instance?).to be false
      end
    end
  end

  describe "#production_instance?" do
    it "returns false for test secret key" do
      expect(context.production_instance?).to be false
    end

    context "with live secret key" do
      let(:secret_key) { "sk_live_key123" }

      it "returns true" do
        expect(context.production_instance?).to be true
      end
    end
  end

  describe "#cross_origin_request?" do
    context "when origin matches host" do
      let(:env) { {Clerk::ORIGIN_HEADER => "https://example.com"} }

      it "returns false" do
        expect(context.cross_origin_request?).to be false
      end
    end

    context "when origin differs from host" do
      let(:env) { {Clerk::ORIGIN_HEADER => "https://different.com"} }

      it "returns true" do
        expect(context.cross_origin_request?).to be true
      end
    end
  end

  describe "#active_client?" do
    context "when client_uat is positive" do
      let(:cookies) { {Clerk::CLIENT_UAT_COOKIE => "1"} }

      it "returns true" do
        expect(context.active_client?).to be true
      end
    end

    context "when client_uat is zero or missing" do
      it "returns false" do
        expect(context.active_client?).to be false
      end
    end
  end

  describe "#accepts_html?" do
    context "when accept header includes text/html" do
      let(:env) { {Clerk::ACCEPT_HEADER => "text/html,application/xhtml+xml"} }

      it "returns true" do
        expect(context.accepts_html?).to be true
      end
    end

    context "when accept header doesn't include text/html" do
      let(:env) { {Clerk::ACCEPT_HEADER => "application/json"} }

      it "returns false" do
        expect(context.accepts_html?).to be false
      end
    end
  end

  describe "#dev_browser" do
    context "when the #{Clerk::DEV_BROWSER_COOKIE} cookie is present" do
      let(:cookies) { {Clerk::DEV_BROWSER_COOKIE => "foo"} }

      it "returns the dev_browser cookie value" do
        expect(context.dev_browser).to eq("foo")
      end
    end

    context "when the #{Clerk::DEV_BROWSER_COOKIE} query param is present" do
      let(:url) { "https://example.com/path?#{Clerk::DEV_BROWSER_COOKIE}=foo" }

      it "returns the dev_browser query param value" do
        expect(context.dev_browser).to eq("foo")
      end
    end

    context "when the #{Clerk::DEV_BROWSER_COOKIE} cookie is not present" do
      it "returns an empty string" do
        expect(context.dev_browser).to eq("")
      end
    end
  end

  describe "#dev_browser?" do
    context "when the #dev_browser is present" do
      it "returns true" do
        allow(context).to receive(:dev_browser).and_return("foo")
        expect(context.dev_browser?).to be true
      end
    end

    context "when the #dev_browser is not present" do
      it "returns false" do
        allow(context).to receive(:dev_browser).and_return("")
        expect(context.dev_browser?).to be false
      end
    end
  end

  describe "#handshake_token" do
    context "when the handshake token is present in the query string" do
      let(:url) { "https://example.com/path?#{Clerk::HANDSHAKE_COOKIE}=foo" }

      it "returns the handshake token as a string" do
        expect(context.handshake_token).to eq("foo")
      end
    end

    context "when the handshake token is present in the cookies" do
      let(:cookies) { {Clerk::HANDSHAKE_COOKIE => "bar"} }

      it "returns the handshake token as a string" do
        expect(context.handshake_token).to eq("bar")
      end
    end

    context "when the handshake token is not present in the query string or cookies" do
      it "returns an empty string" do
        expect(context.handshake_token).to eq("")
      end
    end
  end

  describe "#handshake_token?" do
    context "when the handshake token is present" do
      it "returns true" do
        allow(context).to receive(:handshake_token).and_return("foo")
        expect(context.handshake_token?).to be true
      end
    end

    context "when the handshake token is empty" do
      it "returns true" do
        allow(context).to receive(:handshake_token).and_return("")
        expect(context.handshake_token?).to be false
      end
    end

    context "when the handshake token is not present" do
      it "returns false" do
        allow(context).to receive(:handshake_token).and_return(nil)
        expect(context.handshake_token?).to be false
      end
    end
  end

  describe "#session_token_in_cookie?" do
    context "when session token is present in cookies" do
      let(:cookies) { {Clerk::SESSION_COOKIE => "foo"} }

      it "returns true" do
        expect(context.session_token_in_cookie?).to be true
      end
    end

    context "when session token is not present in cookies" do
      it "returns false" do
        expect(context.session_token_in_cookie?).to be false
      end
    end
  end

  describe "#session_token_in_header?" do
    context "when session token is present in headers" do
      let(:env) { {Clerk::AUTHORIZATION_HEADER => "Bearer foo"} }

      it "returns true" do
        expect(context.session_token_in_header?).to be true
      end
    end

    context "when session token is not present in headers" do
      it "returns false" do
        expect(context.session_token_in_header?).to be false
      end
    end
  end

  describe "#document_request?" do
    context "when #{Clerk::SEC_FETCH_DEST_HEADER} is document" do
      let(:env) { {Clerk::SEC_FETCH_DEST_HEADER => "document"} }

      it "returns true" do
        expect(context.document_request?).to be true
      end
    end

    context "when #{Clerk::SEC_FETCH_DEST_HEADER} is not document" do
      it "returns false" do
        expect(context.document_request?).to be false
      end
    end
  end

  describe "#dev_browser_in_url" do
    context "when #{Clerk::DEV_BROWSER_COOKIE} is present in url" do
      let(:url) { "https://example.com/path?#{Clerk::DEV_BROWSER_COOKIE}=bar" }

      it "returns value" do
        expect(context.dev_browser_in_url).to eq("bar")
      end
    end

    context "when #{Clerk::DEV_BROWSER_COOKIE} is not present in url" do
      it "returns nil" do
        expect(context.dev_browser_in_url).to be_nil
      end
    end
  end

  describe "#dev_browser_in_url?" do
    context "when #{Clerk::DEV_BROWSER_COOKIE} is present in url" do
      let(:url) { "https://example.com/path?#{Clerk::DEV_BROWSER_COOKIE}=bar" }

      it "returns true" do
        expect(context.dev_browser_in_url?).to be true
      end
    end

    context "when #{Clerk::DEV_BROWSER_COOKIE} is not present in url" do
      it "returns false" do
        expect(context.dev_browser_in_url?).to be false
      end
    end
  end

  describe "#frontend_api" do
    context "when publishable key is not valid" do
      before do
        allow(Clerk::Utils).to receive(:valid_publishable_key?).and_return(false)
      end

      it "returns an empty string" do
        expect(context.frontend_api).to eq("")
      end
    end

    context "when the publishable key is valid" do
      before do
        allow(Clerk::Utils).to receive(:valid_publishable_key?).and_return(true)
      end

      context "when proxy_url is present" do
        it "returns the proxy_url" do
          allow(context).to receive(:proxy_url).and_return("https://proxy.example.com")
          expect(context.frontend_api).to eq("https://proxy.example.com")
        end
      end

      context "when development instance and domain is present" do
        it "returns the `clerk.*` frontend api" do
          allow(context).to receive(:development_instance?).and_return(true)
          allow(context).to receive(:domain).and_return("example.com")

          expect(context.frontend_api).to eq("clerk.example.com")
        end
      end

      context "when production instance" do
        it "returns the frontend api from the publishable key" do
          allow(context).to receive(:development_instance?).and_return(false)
          allow(context).to receive(:publishable_key).and_return("pk_live_Y2xlcmsuY2xlcmstcnVieS1zZGsuZGV2JA")

          expect(context.frontend_api).to eq("clerk.clerk-ruby-sdk.dev")
        end
      end
    end
  end

  # describe "#eligible_for_multi_domain?" do
  #   context "when the #{Clerk::DEV_BROWSER_COOKIE} cookie is present" do
  #     let(:cookies) { {Clerk::DEV_BROWSER_COOKIE => "foo"} }

  #     it "returns true" do
  #       expect(context.eligible_for_multi_domain?).to be true
  #     end
  #   end
  # end
end
