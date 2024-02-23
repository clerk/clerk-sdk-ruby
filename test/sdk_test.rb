# frozen_string_literal: true

require "test_helper"

module Clerk
  class SdkTest < Minitest::Test
    TIME_WHEN_JWT_IS_VALID = Time.new(2021, 7, 29, 13, 31, 30, "+03:00")
    TIME_WHEN_JWT_HAS_EXPIRED = Time.new(2021, 7, 29, 13, 33, 0o0, "+03:00")

    def test_sdk_init_without_config
      sdk = ::Clerk::SDK.new
      assert sdk
    end

    def test_application_json_encoding
      unparsed_payload  = { a: "b", c: ["d"], d: { e: 3 } }
      json_payload      = '{"a":"b","c":["d"],"d":{"e":3}}'

      conn = Faraday.new do |faraday|
        faraday.adapter :test do |stub|
          stub.patch("/users/user_1", json_payload, { "Content-Type" => "application/json" }) do |env|
            parsed = JSON.parse(env.request_body)
            parsed["a"] = "b"
            parsed["c"] = ["d"]
            parsed["d"] = { "e" => 3 }

            json_ok("user_1_updated")
          end
        end
      end

      sdk = ::Clerk::SDK.new(connection: conn)
      user = sdk.users.update("user_1", unparsed_payload)

      assert_equal "Mary", user["first_name"]
      assert_equal "user_1", user["id"]
    end

    def test_no_api_key_raises_on_api_call
      sdk = ::Clerk::SDK.new
      assert_raises ArgumentError do
        sdk.users.find("x")
      end
    end

    def test_verify_token
      conn = Faraday.new do |faraday|
        faraday.adapter :test do |stub|
          stub.get("/jwks") { json_ok("jwks") }
        end
      end

      sdk = ::Clerk::SDK.new(connection: conn)
      valid_jwt = json_fixture("jwt_valid")

      Timecop.freeze(TIME_WHEN_JWT_HAS_EXPIRED) do
        assert_raises JWT::ExpiredSignature do
          sdk.verify_token(valid_jwt)
        end
      end

      Timecop.freeze(TIME_WHEN_JWT_IS_VALID) do
        assert sdk.verify_token(valid_jwt)

        assert_raises JWT::IncorrectAlgorithm do
          sdk.verify_token(valid_jwt, algorithms: ["RS512"])
        end

        assert_raises JWT::VerificationError do
          malformed_token = json_fixture("jwt_valid")[0..-2]
          sdk.verify_token(malformed_token)
        end
      end
    end

    def test_verify_token_jwks_cache
      jwks_endpoint_hits = 0

      conn = Faraday.new do |faraday|
        faraday.adapter :test do |stub|
          stub.get("/jwks") do
            jwks_endpoint_hits += 1
            json_ok("jwks")
          end
        end
      end

      sdk = ::Clerk::SDK.new(connection: conn)

      Timecop.freeze(TIME_WHEN_JWT_IS_VALID) do
        sdk.verify_token(json_fixture("jwt_valid"), force_refresh_jwks: true)
        assert_equal 1, jwks_endpoint_hits

        sdk.verify_token(json_fixture("jwt_valid"))
        assert_equal 1, jwks_endpoint_hits

        sdk.verify_token(json_fixture("jwt_valid"), force_refresh_jwks: true)
        assert_equal 2, jwks_endpoint_hits

        sdk.verify_token(json_fixture("jwt_valid"))
        assert_equal 2, jwks_endpoint_hits
      end

      # cache expired
      Timecop.freeze(TIME_WHEN_JWT_IS_VALID + Clerk::SDK::JWKS_CACHE_LIFETIME + 1) do
        begin
          sdk.verify_token(json_fixture("jwt_valid"))
        rescue JWT::ExpiredSignature
          # we know the token is going to be expired in this travelled to time
        end

        assert_equal 3, jwks_endpoint_hits
      end

      # assert that if the server (BAPI) returns an error to the JWKS request
      # (i.e. BAPI was down momentarily) and therefore the received token couldn't
      # be verified, then we're going to try one more time
      jwks_endpoint_hits = 0
      conn = Faraday.new do |faraday|
        faraday.adapter :test do |stub|
          stub.get("/jwks") do
            jwks_endpoint_hits += 1
            jwks_endpoint_hits < 2 ? json_404 : json_ok("jwks")
          end
        end
      end

      sdk = ::Clerk::SDK.new(connection: conn)
      Timecop.freeze(TIME_WHEN_JWT_IS_VALID) do
        claims = sdk.verify_token(json_fixture("jwt_valid"), force_refresh_jwks: true)
        assert_equal 2, jwks_endpoint_hits
        assert_equal "foo@bar.com", claims["email"]

        sdk.verify_token(json_fixture("jwt_valid"))
        assert_equal 2, jwks_endpoint_hits # cached response
      end
    end
  end
end
