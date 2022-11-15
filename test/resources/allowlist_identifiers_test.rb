# frozen_string_literal: true

require "test_helper"

class Clerk::Resources::AllowlistIdentifierTest < Minitest::Test
  def mock_sdk
    faraday = Faraday.new do |faraday|
      faraday.adapter :test do |stub|
        stub.get("/allowlist_identifiers") { json_ok("all_allowlist_identifiers") }
        stub.post("/allowlist_identifiers") { json_ok("allowlist_identifier_1") }
        stub.delete("/allowlist_identifiers/alid_1") { json_ok("allowlist_identifier_1_deleted") }
      end
    end

    ::Clerk::SDK.new(connection: faraday)
  end

  def test_all_allowlist_identifiers
    allowlist_identifiers = mock_sdk.allowlist_identifiers.all
    assert_equal ["allowlist_identifier"], allowlist_identifiers.map { |h| h.dig("object") }
  end

  def test_delete_allowlist_identifier
    user = mock_sdk.allowlist_identifiers.delete("alid_1")
    assert_equal true, user["deleted"]
    assert_equal "allowlist_identifier", user["object"]
    assert_equal "alid_1", user["id"]
  end
end
