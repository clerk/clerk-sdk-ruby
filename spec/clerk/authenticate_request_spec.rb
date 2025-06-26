# frozen_string_literal: true

require "spec_helper"
require "clerk/authenticate_context"
require "clerk/authenticate_request"

RSpec.describe Clerk::AuthenticateRequest do
  let(:session_token_in_header) { nil }
  let(:session_token_in_cookie) { nil }
  let(:auth_context) do
    instance_double(
      Clerk::AuthenticateContext,
      session_token_in_header: session_token_in_header,
      session_token_in_cookie: session_token_in_cookie
    )
  end
  let(:sdk) { instance_double(Clerk::SDK) }
  let(:env) { {} }
  let(:instance) { described_class.new(auth_context) }

  before do
    allow(Clerk::SDK).to receive(:new).and_return(sdk)
  end

  describe "#initialize" do
    it "initializes with an auth_context" do
      expect(instance.auth_context).to eq(auth_context)
    end
  end

  describe "#resolve" do
    context "when using header token based authentication" do
      it "should resolve the header token" do
        allow(auth_context).to receive(:session_token_in_header?).and_return(true)
        expect(instance).to receive(:resolve_header_token).with(env)

        instance.resolve(env)
      end
    end

    context "when using cookie token based authentication" do
      it "should resolve the cookie token" do
        allow(auth_context).to receive(:session_token_in_header?).and_return(false)
        expect(instance).to receive(:resolve_cookie_token).with(env)

        instance.resolve(env)
      end
    end
  end

  describe "#resolve_header_token" do
    before { allow(sdk).to receive(:decode_token).and_return(true) }
    after { instance.send(:resolve_header_token, env) }

    context "signed in" do
      context "valid token" do
        let(:claims) { {"sub" => "user_123"} }
        let(:session_token_in_header) { "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c" }

        context "has claims" do
          it "should return signed in" do
            expect(instance).to receive(:verify_token).with(auth_context.session_token_in_header).and_return(claims)
            expect(instance).to receive(:signed_in).with(env, claims, auth_context.session_token_in_header)
          end
        end

        context "no claims" do
          it "should return signed out" do
            expect(instance).to receive(:verify_token).with(auth_context.session_token_in_header).and_return(nil)
            expect(instance).to receive(:signed_out).with(enforce_auth: true)
          end
        end
      end
    end

    context "signed out" do
      context "malformed token" do
        let(:session_token_in_header) { "invalid_token" }

        it "should return signed out with #{Clerk::TokenVerificationErrorReason::TOKEN_INVALID}" do
          expect(sdk).to receive(:decode_token).with(auth_context.session_token_in_header).and_return(false)
          expect(instance).to receive(:signed_out).with(reason: Clerk::TokenVerificationErrorReason::TOKEN_INVALID)
        end
      end

      context "expired token" do
        let(:session_token_in_header) { "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyLCJleHAiOjE1MTYyMjkwMjJ9.dWa-WdWJPb1x16REqjSQVLX9Po8DiJNHGr7NhCW62kk" }

        it "should return signed out with `#{Clerk::TokenVerificationErrorReason::TOKEN_EXPIRED}`" do
          expect(instance).to receive(:verify_token).with(auth_context.session_token_in_header).and_raise(JWT::ExpiredSignature)
          expect(instance).to receive(:signed_out).with(enforce_auth: true, reason: Clerk::TokenVerificationErrorReason::TOKEN_EXPIRED)
        end
      end

      context "token not active yet" do
        let(:session_token_in_header) { "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0Ijo1NTE2MjM5MDIyfQ.KA4waP1mBe_P6kS9inaGZTxOLNV64KQOMQSTkpVYRF8" }

        it "should return signed out with `#{Clerk::TokenVerificationErrorReason::TOKEN_NOT_ACTIVE_YET}`" do
          expect(instance).to receive(:verify_token).with(auth_context.session_token_in_header).and_raise(JWT::InvalidIatError)
          expect(instance).to receive(:signed_out).with(enforce_auth: true, reason: Clerk::TokenVerificationErrorReason::TOKEN_NOT_ACTIVE_YET)
        end
      end

      context "decoding error" do
        let(:session_token_in_header) { "invalid_token" }

        it "should return signed out with `#{Clerk::TokenVerificationErrorReason::TOKEN_INVALID}`" do
          expect(instance).to receive(:verify_token).with(auth_context.session_token_in_header).and_raise(JWT::DecodeError)
          expect(instance).to receive(:signed_out).with(reason: Clerk::TokenVerificationErrorReason::TOKEN_INVALID)
        end
      end
    end
  end

  describe "#resolve_cookie_token" do
    context "cross origin request" do
      it "should return signed out" do
        allow(auth_context).to receive(:cross_origin_request?).and_return(true)
        expect(instance).to receive(:signed_out)
        instance.send(:resolve_cookie_token, env)
      end
    end

    context "handshake token present" do
      let(:auth_context) do
        instance_double(
          Clerk::AuthenticateContext,
          cross_origin_request?: false,
          handshake_token?: true
        )
      end

      it "should attempt to resolve the handshake token" do
        expect(instance).to receive(:resolve_handshake).with(env)
        instance.send(:resolve_cookie_token, env)
      end
    end

    context "development instance" do
      let(:auth_context) do
        instance_double(
          Clerk::AuthenticateContext,
          cross_origin_request?: false,
          development_instance?: true,
          dev_browser_in_url?: true,
          dev_browser?: false,
          handshake_token?: false
        )
      end

      it "should handle the handshake maybe status (dev browser in url)" do
        expect(instance).to receive(:handle_handshake_maybe_status).with(env, reason: Clerk::AuthErrorReason::DEV_BROWSER_SYNC)
        instance.send(:resolve_cookie_token, env)
      end

      it "should handle the handshake maybe status (dev browser)" do
        allow(auth_context).to receive(:dev_browser_in_url?).and_return(false)
        expect(instance).to receive(:handle_handshake_maybe_status).with(env, reason: Clerk::AuthErrorReason::DEV_BROWSER_MISSING)
        instance.send(:resolve_cookie_token, env)
      end
    end

    context "active/inactive clients" do
      let(:auth_context) do
        instance_double(
          Clerk::AuthenticateContext,
          active_client?: false,
          cross_origin_request?: false,
          development_instance?: true,
          dev_browser_in_url?: false,
          dev_browser?: true,
          handshake_token?: false
        )
      end

      it "should return signed out if inactive client and session token is missing" do
        allow(auth_context).to receive(:session_token_in_cookie?).and_return(false)

        expect(instance).to receive(:signed_out).with(reason: Clerk::AuthErrorReason::SESSION_TOKEN_AND_UAT_MISSING)
        instance.send(:resolve_cookie_token, env)
      end

      it "should handle the handshake maybe status if inactive client and session token is present" do
        allow(auth_context).to receive(:session_token_in_cookie?).and_return(true)

        expect(instance).to receive(:handle_handshake_maybe_status).with(env, reason: Clerk::AuthErrorReason::SESSION_TOKEN_WITHOUT_CLIENT_UAT)
        instance.send(:resolve_cookie_token, env)
      end

      it "should handle the handshake maybe status if active client and session token is missing" do
        allow(auth_context).to receive(:active_client?).and_return(true)
        allow(auth_context).to receive(:session_token_in_cookie?).and_return(false)

        expect(instance).to receive(:handle_handshake_maybe_status).with(env, reason: Clerk::AuthErrorReason::CLIENT_UAT_WITHOUT_SESSION_TOKEN)
        instance.send(:resolve_cookie_token, env)
      end
    end

    context "active client & session token is present" do
      let(:auth_context) do
        instance_double(
          Clerk::AuthenticateContext,
          active_client?: true,
          client_uat: 1733967555,
          cross_origin_request?: false,
          development_instance?: true,
          dev_browser_in_url?: false,
          dev_browser?: true,
          handshake_token?: false,
          session_token_in_cookie: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c",
          session_token_in_cookie?: true
        )
      end

      it "should return signed out if token could not be verified" do
        expect(instance).to receive(:verify_token).with(auth_context.session_token_in_cookie).and_return(false)
        expect(instance).to receive(:signed_out)

        instance.send(:resolve_cookie_token, env)
      end

      it "should handle the handshake maybe status if token iat is less than client uat" do
        claims = {"sub" => "user_123", "iat" => 1733967554}

        expect(instance).to receive(:verify_token).with(auth_context.session_token_in_cookie).and_return(claims)
        expect(instance).to receive(:handle_handshake_maybe_status).with(env, reason: Clerk::AuthErrorReason::SESSION_TOKEN_OUTDATED)

        instance.send(:resolve_cookie_token, env)
      end

      it "should return signed in" do
        claims = {"sub" => "user_123", "iat" => 1733967556}

        expect(instance).to receive(:verify_token).with(auth_context.session_token_in_cookie).and_return(claims)
        expect(instance).to receive(:signed_in).with(env, claims, auth_context.session_token_in_cookie)

        instance.send(:resolve_cookie_token, env)
      end

      context "verification error" do
        it "should run handshake for expired tokens" do
          expect(instance).to receive(:verify_token).with(auth_context.session_token_in_cookie).and_raise(JWT::ExpiredSignature)
          expect(instance).to receive(:handshake).with(env, reason: Clerk::TokenVerificationErrorReason::TOKEN_EXPIRED)

          instance.send(:resolve_cookie_token, env)
        end

        it "should run handshake for inactive tokens" do
          expect(instance).to receive(:verify_token).with(auth_context.session_token_in_cookie).and_raise(JWT::InvalidIatError)
          expect(instance).to receive(:handshake).with(env, reason: Clerk::TokenVerificationErrorReason::TOKEN_NOT_ACTIVE_YET)

          instance.send(:resolve_cookie_token, env)
        end

        it "should run handshake for inactive tokens" do
          expect(instance).to receive(:verify_token).with(auth_context.session_token_in_cookie).and_raise(JWT::InvalidIatError)
          expect(instance).to receive(:handshake).with(env, reason: Clerk::TokenVerificationErrorReason::TOKEN_NOT_ACTIVE_YET)

          instance.send(:resolve_cookie_token, env)
        end

        it "should return signed out for malformed tokens" do
          expect(instance).to receive(:verify_token).with(auth_context.session_token_in_cookie).and_raise(JWT::DecodeError)
          expect(instance).to receive(:signed_out).with(reason: Clerk::TokenVerificationErrorReason::TOKEN_INVALID)
          instance.send(:resolve_cookie_token, env)
        end

        it "should return signed out if token is invalid in any other way" do
          expect(instance).to receive(:verify_token).with(auth_context.session_token_in_cookie).and_raise
          expect(instance).to receive(:signed_out)

          instance.send(:resolve_cookie_token, env)
        end
      end
    end
  end

  describe "#handle_handshake_maybe_status" do
    it "should return signed out if not eligible for handshake" do
      expect(instance).to receive(:eligible_for_handshake?).and_return(false)
      expect(instance).to receive(:signed_out)
      expect(instance).to_not receive(:handshake)

      instance.send(:handle_handshake_maybe_status, env)
    end

    it "should return handshake if eligible for handshake" do
      expect(instance).to receive(:eligible_for_handshake?).and_return(true)
      expect(instance).to_not receive(:signed_out)
      expect(instance).to receive(:handshake).with(env)

      instance.send(:handle_handshake_maybe_status, env)
    end

    it "should pass through options" do
      opts = {reason: "reason", message: "message", status: "status"}

      expect(instance).to receive(:eligible_for_handshake?).and_return(true)
      expect(instance).to_not receive(:signed_out)
      expect(instance).to receive(:handshake).with(env, **opts)

      instance.send(:handle_handshake_maybe_status, env, **opts)
    end
  end

  describe "#handshake" do
    it "should return a redirect response" do
      expect(instance).to receive(:redirect_to_handshake).and_return("https://example.com")

      status, headers = instance.send(:handshake, env, reason: "reason", message: "message", status: "status")
      expect(status).to eq 307
      expect(headers).to eq(
        Clerk::LOCATION_HEADER => "https://example.com",
        Clerk::AUTH_REASON_HEADER => "reason",
        Clerk::AUTH_MESSAGE_HEADER => "message",
        Clerk::AUTH_STATUS_HEADER => "status"
      )
    end
  end

  describe "#signed_out" do
    context "when `enforce_auth` is true" do
      it "should return 401" do
        status, headers = instance.send(:signed_out, reason: "reason", message: "message", status: "status", enforce_auth: true)

        expect(status).to eq(401)
        expect(headers).to eq({
          Clerk::AUTH_REASON_HEADER => "reason",
          Clerk::AUTH_MESSAGE_HEADER => "message",
          Clerk::AUTH_STATUS_HEADER => "status"
        })
      end
    end

    context "when `enforce_auth` is false" do
      it "should return nil status" do
        status, headers = instance.send(:signed_out, reason: "reason", message: "message", status: "status")

        expect(status).to be_nil
        expect(headers).to eq({
          Clerk::AUTH_REASON_HEADER => "reason",
          Clerk::AUTH_MESSAGE_HEADER => "message",
          Clerk::AUTH_STATUS_HEADER => "status"
        })
      end
    end

    context "debug auth headers" do
      it "should return debug auth headers" do
        status, headers = instance.send(:signed_out, reason: "reason", message: "message", status: "status")

        expect(status).to be_nil
        expect(headers).to eq({
          Clerk::AUTH_REASON_HEADER => "reason",
          Clerk::AUTH_MESSAGE_HEADER => "message",
          Clerk::AUTH_STATUS_HEADER => "status"
        })
      end

      it "should merge existing headers" do
        input_headers = {"foo" => "bar"}
        status, headers = instance.send(:signed_out, reason: "reason", message: "message", status: "status", headers: input_headers)

        expect(status).to be_nil
        expect(headers).to eq({
          Clerk::AUTH_REASON_HEADER => "reason",
          Clerk::AUTH_MESSAGE_HEADER => "message",
          Clerk::AUTH_STATUS_HEADER => "status",
          "foo" => "bar"
        })
      end
    end
  end

  describe "#signed_in" do
    let(:claims) { {"sub" => "user_123"} }
    let(:token) { "valid_token" }

    it "should set the clerk env" do
      _, headers = instance.send(:signed_in, env, claims, token)

      expect(headers).to eq({})

      expect(env["clerk"]).to be_a(Clerk::Proxy)
      expect(env["clerk"].session_claims).to eq(claims)
      expect(env["clerk"].session_token).to eq(token)
    end

    it "should pass through headers" do
      input_headers = {"foo" => "bar"}

      _, headers = instance.send(:signed_in, env, claims, token, **input_headers)

      expect(headers).to eq(input_headers)
    end
  end

  describe "#eligible_for_handshake?" do
    it "should be true if it's a document request" do
      allow(auth_context).to receive(:document_request?).and_return(true)
      expect(instance.send(:eligible_for_handshake?)).to be true
    end

    it "should be true if it's not a document request and accepts html" do
      allow(auth_context).to receive(:document_request?).twice.and_return(false)
      allow(auth_context).to receive(:accepts_html?).and_return(true)
      expect(instance.send(:eligible_for_handshake?)).to be true
    end

    it "should be false if it's not a document request and does not accept html" do
      allow(auth_context).to receive(:document_request?).twice.and_return(false)
      allow(auth_context).to receive(:accepts_html?).and_return(false)
      expect(instance.send(:eligible_for_handshake?)).to be false
    end
  end

  describe "#verify_token" do
    it "should be truthy if the token is valid" do
      output = {"sub" => "user_123"}
      expect(sdk).to receive(:verify_token).and_return(output)
      expect(instance.send(:verify_token, "valid_token")).to eq output
    end

    it "should return false if the token is nil" do
      expect(sdk).to_not receive(:verify_token)
      expect(instance.send(:verify_token, nil)).to be false
    end

    it "should return false if the token is empty" do
      expect(sdk).to_not receive(:verify_token)
      expect(instance.send(:verify_token, "")).to be false
    end

    it "should return false if the token has a decoding error" do
      expect(sdk).to receive(:verify_token).and_raise(JWT::DecodeError)
      expect(instance.send(:verify_token, "invalid_token")).to be false
    end

    it "should re-raise the error if the token is expired" do
      expect(sdk).to receive(:verify_token).and_raise(JWT::ExpiredSignature)
      expect { instance.send(:verify_token, "invalid_token") }.to raise_error(JWT::ExpiredSignature)
    end

    it "should re-raise the error if the token is invalid" do
      expect(sdk).to receive(:verify_token).and_raise(JWT::InvalidIatError)
      expect { instance.send(:verify_token, "invalid_token") }.to raise_error(JWT::InvalidIatError)
    end
  end

  describe "#verify_token_with_retry" do
    let(:token) { "valid_token" }
    let(:claims) { {"sub" => "user_123"} }

    it "should return signed_in if the token is valid" do
      expect(instance).to receive(:verify_token).with(token).and_return(claims)
      expect(instance).to receive(:signed_in).with(env, claims, token).and_return("stubbed")
      expect(instance.send(:verify_token_with_retry, env, token)).to eq "stubbed"
    end

    context "production instance" do
      before { expect(auth_context).to receive(:development_instance?).and_return(false) }

      it "should re-raise the error if the initial verification fails" do
        expect(instance).to receive(:verify_token).and_raise(JWT::InvalidIatError)
        expect { instance.send(:verify_token_with_retry, env, token) }.to raise_error(JWT::InvalidIatError)
      end
    end

    context "development instance" do
      before { expect(auth_context).to receive(:development_instance?).and_return(true) }

      it "should retry the token verification" do
        expect(instance).to receive(:verify_token).and_raise(JWT::InvalidIatError)
        expect(instance).to receive(:verify_token).with(token, {timeout: 86_400}).and_return(claims)
        expect(instance).to receive(:signed_in).with(env, claims, token).and_return("stubbed")

        expect(instance.send(:verify_token_with_retry, env, token)).to eq "stubbed"
      end

      it "should retry the token verification and raise an error if it fails" do
        expect(instance).to receive(:verify_token).and_raise(JWT::InvalidIatError)
        expect(instance).to receive(:verify_token).with(token, {timeout: 86_400}).and_raise(JWT::InvalidIatError)
        expect(instance).to_not receive(:signed_in)

        expect { instance.send(:verify_token_with_retry, env, token) }.to raise_error(JWT::InvalidIatError)
      end
    end
  end

  describe "#remove_from_query_string" do
    it "should remove the key from the query string" do
      url = URI("http://example.com?foo=bar&baz=qux")
      result = instance.send(:remove_from_query_string, url, "foo")
      expect(url.query).to eq("baz=qux")
      expect(result).to eq("baz=qux")
    end
  end

  describe "#debug_auth_headers" do
    it "should format the headers" do
      result = instance.send(:debug_auth_headers, reason: "reason", message: "message", status: "status")

      expect(result).to eq({
        Clerk::AUTH_REASON_HEADER => "reason",
        Clerk::AUTH_MESSAGE_HEADER => "message",
        Clerk::AUTH_STATUS_HEADER => "status"
      })
    end

    it "should remove nil values from the headers" do
      result = instance.send(:debug_auth_headers, reason: "reason")
      expect(result).to eq({Clerk::AUTH_REASON_HEADER => "reason"})
    end
  end

  describe "#redirect_to_handshake" do
    before do
      allow(auth_context).to receive(:clerk_url).and_return(URI.parse("http://localhost:3000?#{Clerk::DEV_BROWSER_COOKIE}=foobar"))
      allow(auth_context).to receive(:frontend_api).and_return("clerk.foobar.dev")
      allow(auth_context).to receive(:development_instance?).and_return(true)
    end

    it "should return the handshake url" do
      allow(auth_context).to receive(:dev_browser?).and_return(false)
      expect(instance.send(:redirect_to_handshake)).to eq("https://clerk.foobar.dev/v1/client/handshake?redirect_url=http%3A%2F%2Flocalhost%3A3000%3F")
    end

    it "should return the handshake url" do
      allow(auth_context).to receive(:dev_browser?).and_return(true)
      allow(auth_context).to receive(:dev_browser).and_return("DVB_TOKEN")
      expect(instance.send(:redirect_to_handshake)).to eq("https://clerk.foobar.dev/v1/client/handshake?redirect_url=http%3A%2F%2Flocalhost%3A3000%3F&__clerk_db_jwt=DVB_TOKEN")
    end
  end

  describe "#resolve_handshake" do
    context "failed handshake token verification" do
      it "should return signed out" do
        allow(auth_context).to receive(:handshake_token).and_return("")

        expect(instance).to receive(:verify_token).with(auth_context.handshake_token).and_return(false)
        expect(instance).to receive(:signed_out).and_call_original

        status, headers = instance.send(:resolve_handshake, env)

        expect(status).to eq(401)
        expect(headers).to eq({Clerk::AUTH_REASON_HEADER => Clerk::TokenVerificationErrorReason::JWK_FAILED_TO_RESOLVE})
      end
    end

    context "sucessful handshake token verification" do
      let(:cookie_directives) { [] }

      before do
        allow(auth_context).to receive(:handshake_token).and_return("valid_token")
        allow(instance).to receive(:verify_token).with(auth_context.handshake_token).and_return(false)
        allow(instance).to receive(:signed_out).and_call_original

        expect(instance).to receive(:verify_token).with(auth_context.handshake_token).and_return({
          Clerk::HANDSHAKE_COOKIE_DIRECTIVES_KEY => cookie_directives
        })

        allow(auth_context).to receive(:development_instance?).and_return(true)
        allow(auth_context).to receive(:clerk_url).and_return(URI.parse("http://localhost:3000/admin?#{Clerk::HANDSHAKE_COOKIE}=foobar"))
      end

      context "without session token" do
        let(:cookie_directives) do
          [
            "__client_uat=; Path=/; Expires=Thu, 01 Jan 1970 00:00:00 GMT; SameSite=Lax",
            "__client_uat=1733967555; Path=/; Domain=127.0.0.1; Max-Age=315360000; SameSite=Lax",
            "__clerk_db_jwt=dvb_2p2djNDxepFC8K98VArq3efkHWw; Path=/; Expires=Fri, 12 Dec 2025 01:39:48 GMT; SameSite=Lax"
          ]
        end

        it "should set as signed out" do
          expect(instance).to_not receive(:verify_token_with_retry)

          status, headers = instance.send(:resolve_handshake, env)

          expect(status).to be_nil
          expect(headers).to eq({
            Clerk::ACCESS_CONTROL_ALLOW_CREDENTIALS_HEADER => "true",
            Clerk::ACCESS_CONTROL_ALLOW_ORIGIN_HEADER => "null",
            Clerk::LOCATION_HEADER => "http://localhost:3000/admin?",
            Clerk::SET_COOKIE_HEADER => cookie_directives,
            Clerk::AUTH_REASON_HEADER => Clerk::AuthErrorReason::SESSION_TOKEN_MISSING
          })
        end
      end

      context "with session token" do
        let(:cookie_directives) { ["__session=VALID_SESSION_TOKEN; Path=/; Expires=Fri, 12 Dec 2025 01:39:48 GMT; SameSite=Lax"] }

        it "should attempt to verify the session token" do
          expect(instance).to_not receive(:signed_out)
          expect(instance).to receive(:verify_token_with_retry)

          instance.send(:resolve_handshake, env)
        end
      end
    end
  end
end
