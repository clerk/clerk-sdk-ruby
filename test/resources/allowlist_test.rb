# frozen_string_literal: true

require "test_helper"

class Clerk::Resources::AllowlistTest < Minitest::Test
  def mock_sdk
    faraday = Faraday.new do |faraday|
      faraday.adapter :test do |stub|
        stub.patch("/beta_features/allowlist") { json_ok("allowlist_toggle") }
      end
    end

    ::Clerk::SDK.new(connection: faraday)
  end

  def test_toggle_allowlist
    resp = mock_sdk.allowlist.update({restricted_to_allowlist: true})
    assert_equal true, resp["restricted_to_allowlist"]
  end
end
