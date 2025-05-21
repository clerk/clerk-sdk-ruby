require "spec_helper"
require "rack/test"
require "clerk/rack_middleware"

RSpec.describe Clerk::Rack::Middleware do
  include Rack::Test::Methods

  let(:env) { Rack::MockRequest.env_for }
  let(:output) { [200, {}, "OK"] }
  let(:app) { ->(env) { output } }

  let(:auth_request_double) { instance_double(Clerk::AuthenticateRequest) }
  let(:auth_context_double) { instance_double(Clerk::AuthenticateContext) }

  subject { described_class.new(app) }

  describe "#initialize" do
    it "processes excluded routes correctly" do
      skipped_middleware = described_class.new(app, {excluded_routes: ["/health", "/api/*", "/status"]})

      expect(skipped_middleware.instance_variable_get(:@excluded_routes)).to eq("/health" => true, "/status" => true)
      expect(skipped_middleware.instance_variable_get(:@excluded_routes_wildcards)).to eq(["/api/"])
    end
  end

  describe "#call" do
    before do
      allow(Clerk::AuthenticateContext).to receive(:new).and_return(auth_context_double)
      allow(Clerk::AuthenticateRequest).to receive(:new).and_return(auth_request_double)
      allow(auth_request_double).to receive(:resolve).and_return([nil, {}, nil])
    end

    it "sets clerk proxy and initialized to true in env" do
      expect(subject.call(env)).to eq(output)
      expect(env["clerk"]).to be_a(Clerk::Proxy)
      expect(env["clerk.initialized"]).to be(true)
    end

    context "when route is excluded" do
      it "skips authentication for excluded routes" do
        env["PATH_INFO"] = "/health"

        expect(subject.call(env)).to eq(output)
        expect(Clerk::AuthenticateRequest).not_to receive(:new)
        expect(env["clerk"]).to be_nil
        expect(env["clerk.excluded_route"]).to be(true)
      end

      it "skips authentication for wildcard excluded routes" do
        env["PATH_INFO"] = "/api/users"

        expect(subject.call(env)).to eq(output)
        expect(Clerk::AuthenticateRequest).not_to receive(:new)
        expect(env["clerk"]).to be_nil
        expect(env["clerk.excluded_route"]).to be(true)
      end
    end

    context "when status is present" do
      it "should pass-through the response" do
        response = [401, {}, "Unauthorized"]

        expect(auth_request_double).to receive(:resolve).and_return(response)
        expect(subject.call(env)).to eq(response)
      end
    end

    context "when status is nil" do
      it "should call the app" do
        expect(app).to receive(:call).with(env)
        subject.call(env)
      end

      context "when auth_request_headers are present" do
        let(:auth_request_response) { [nil, {Clerk::SET_COOKIE_HEADER => ["session=bar; path=/; expires=Fri, 15 Jan 2024 00:00:00 GMT; httponly; secure"], Clerk::CONTENT_TYPE_HEADER => "application/json"}, nil] }
        let(:app_response) { [200, {Clerk::SET_COOKIE_HEADER => ["session=foo; path=/; expires=Wed, 13 Jan 2024 00:00:00 GMT; httponly; secure"]}, "OK"] }

        it "should remove the `set-cookie` header to avoid overriding existing cookies set by other middleware" do
          allow(auth_request_double).to receive(:resolve).and_return(auth_request_response)
          allow(app).to receive(:call).with(env).and_return(app_response)

          expect(subject).to receive(:set_cookie_headers!).with(app_response[1], ["session=bar; path=/; expires=Fri, 15 Jan 2024 00:00:00 GMT; httponly; secure"]).and_call_original

          status, headers, body = subject.call(env)

          expect(status).to eq(200)
          expect(headers).to eq({
            Clerk::CONTENT_TYPE_HEADER => "application/json",
            Clerk::SET_COOKIE_HEADER => [
              "session=foo; path=/; expires=Wed, 13 Jan 2024 00:00:00 GMT; httponly; secure", 
              "session=bar; path=/; expires=Mon, 15 Jan 2024 00:00:00 GMT; secure; httponly"
            ]
          })
          expect(body).to eq("OK")
        end
      end

      context "when auth_request_headers are missing" do
        let(:auth_request_response) { [nil, {}, nil] }
        let(:app_response) { [200, {Clerk::SET_COOKIE_HEADER => "session=bar; path=/; expires=Wed, 13 Jan 2024 00:00:00 GMT; httponly; secure"}, "OK"] }

        it "returns the authenticated headers" do
          allow(auth_request_double).to receive(:resolve).and_return(auth_request_response)
          allow(app).to receive(:call).with(env).and_return(app_response)
          expect(subject).to_not receive(:set_cookie_headers!)
          expect(subject.call(env)).to eq(app_response)
        end
      end
    end
  end

  describe "#set_cookie_headers!" do
    let(:cookies) do
      [
        "session=abc123; Path=/; Expires=Wed, 13 Jan 2024 00:00:00 GMT; HttpOnly; Secure",
        "client=xyz789; Path=/; Expires=Fri, 15 Jan 2024 00:00:00 GMT; HttpOnly; Secure"
      ]
    end

    it "sets cookies in response headers" do
      headers = {}

      subject.send(:set_cookie_headers!, headers, cookies)

      expect(headers["set-cookie"]).to include(/session=abc123/)
      expect(headers["set-cookie"]).to include(/client=xyz789/)
    end
  end

  describe "#convert_http_cookie_to_cookie_setter_params" do
    let(:cookie) { {"session" => "abc123", "Expires" => "Wed, 13 Jan 2024 00:00:00 GMT", "Path" => "/", "HttpOnly" => true, "Secure" => true} }
    let(:cookie_key) { "session" }
    let(:result) { subject.send(:convert_http_cookie_to_cookie_setter_params, cookie_key, cookie) }

    it "should convert the cookie key to :value" do
      expect(result[:value]).to eq("abc123")
    end

    it "should downcase cookie keys" do
      expect(result.keys).to all(be_a(Symbol))

      expect(result).to have_key(:expires)
      expect(result).to have_key(:httponly)
      expect(result).to have_key(:path)
      expect(result).to have_key(:secure)
      expect(result).to have_key(:value)
    end

    it "should fix issue with cookie expiration expected to be Date type" do
      expect(result[:expires]).to be_a(Date)
    end
  end
end

RSpec.describe Clerk::Rack::Reverification do
  let(:app) { ->(env) { [200, env, "app"] } }
  let(:middleware) { described_class.new(app) }
  let(:clerk_instance) { instance_double("Clerk::Instance") }

  let(:default_env) do
    {
      "clerk.initialized" => true,
      "clerk" => clerk_instance,
      "PATH_INFO" => "/test"
    }
  end

  describe "#call" do
    context "when clerk is not initialized" do
      it "raises ConfigurationError" do
        env = default_env.merge("clerk.initialized" => false)

        expect { middleware.call(env) }.to raise_error(
          Clerk::ConfigurationError,
          "`Clerk::Rack::Reverification` must be initialized after `Clerk::Rack::Middleware`"
        )
      end
    end

    context "when route is excluded" do
      it "passes through to the app" do
        env = default_env.merge("clerk.excluded_route" => true)

        expect(app).to receive(:call).with(env)
        middleware.call(env)
      end
    end

    context "with route matching" do
      let(:middleware) { described_class.new(app, routes: ["/protected/*", "/admin"]) }

      it "checks reverification for matching exact route" do
        env = default_env.merge("PATH_INFO" => "/admin")
        allow(clerk_instance).to receive(:user_needs_reverification?).and_return(true)
        allow(clerk_instance).to receive(:user_reverification_rack_response)

        middleware.call(env)

        expect(clerk_instance).to have_received(:user_needs_reverification?)
      end

      it "checks reverification for matching wildcard route" do
        env = default_env.merge("PATH_INFO" => "/protected/resource")
        allow(clerk_instance).to receive(:user_needs_reverification?).and_return(true)
        allow(clerk_instance).to receive(:user_reverification_rack_response)

        middleware.call(env)

        expect(clerk_instance).to have_received(:user_needs_reverification?)
      end

      it "skips reverification for non-matching route" do
        env = default_env.merge("PATH_INFO" => "/public")
        allow(clerk_instance).to receive(:user_needs_reverification?)

        middleware.call(env)

        expect(clerk_instance).not_to have_received(:user_needs_reverification?)
      end
    end

    context "when reverification is needed" do
      let(:reverification_response) { [302, {Clerk::LOCATION_HEADER => "/reverify"}, []] }

      it "returns reverification response" do
        allow(clerk_instance).to receive(:user_needs_reverification?).and_return(true)
        allow(clerk_instance).to receive(:user_reverification_rack_response).and_return(reverification_response)

        response = middleware.call(default_env)

        expect(response).to eq(reverification_response)
      end
    end

    context "when reverification is not needed" do
      it "passes through to the app" do
        allow(clerk_instance).to receive(:user_needs_reverification?).and_return(false)

        expect(app).to receive(:call).with(default_env)
        middleware.call(default_env)
      end
    end

    context "with custom preset" do
      let(:middleware) { described_class.new(app, preset: Clerk::StepUp::Preset::LAX) }

      it "uses the custom preset for reverification check" do
        allow(clerk_instance).to receive(:user_needs_reverification?).with(Clerk::StepUp::Preset::LAX).and_return(false)

        middleware.call(default_env)

        expect(clerk_instance).to have_received(:user_needs_reverification?).with(Clerk::StepUp::Preset::LAX)
      end
    end
  end
end
