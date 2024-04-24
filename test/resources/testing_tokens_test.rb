# frozen_string_literal: true

require "test_helper"

class Clerk::Resources::TestingTokensTest < Minitest::Test
  def mock_sdk
    faraday = Faraday.new do |faraday|
      faraday.adapter :test do |stub|
        stub.post("/testing_tokens") { json_ok("testing_token_1") }
      end
    end

    ::Clerk::SDK.new(connection: faraday)
  end

  def test_create_testing_token
    response = mock_sdk.testing_tokens.create

    assert_equal "testing_token", response["object"]
    assert_equal "1713877310-c_3n2MvPu9PnXcuhBPZNao0LOXqK9A7YrnBn0HmIWyy",
      response["token"]
    assert_equal 1713966600, response["expires_at"]

  end
end
