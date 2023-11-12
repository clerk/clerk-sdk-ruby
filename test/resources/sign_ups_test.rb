# frozen_string_literal: true

require "test_helper"

class Clerk::Resources::SignUpsTest < Minitest::Test

  def mock_sdk
    faraday = Faraday.new do |faraday|
      faraday.adapter :test do |stub|
        stub.get("/sign_ups/sua_sign_up") { json_ok("sign_up_1") }
        stub.patch("/sign_ups/sua_sign_up") { json_ok("sign_up_1_updated") }
      end
    end

    ::Clerk::SDK.new(connection: faraday)
  end

  def test_find_sign_up
    sign_up_id = "sua_sign_up"
    sign_up = mock_sdk.sign_ups.find(sign_up_id)
    assert_equal "sign_up_attempt", sign_up["object"]
    assert_equal sign_up_id, sign_up["id"]
  end

  def test_update_sign_up
    sign_up_id = "sua_sign_up"
    sign_up = mock_sdk.sign_ups.update(sign_up_id, custom_action: true, external_id: "copacabana")
    assert_equal "sign_up_attempt", sign_up["object"]
    assert_equal sign_up_id, sign_up["id"]
    assert_equal "copacabana", sign_up["external_id"]
    assert sign_up["custom_action"]
  end

end
