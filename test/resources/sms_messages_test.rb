# frozen_string_literal: true

require "test_helper"

class Clerk::Resources::SMSMessagesTest < Minitest::Test
  def mock_sdk
    faraday = Faraday.new do |faraday|
      faraday.adapter :test do |stub|
        stub.post("/sms_messages") { json_ok("sms_message_created") }
      end
    end

    ::Clerk::SDK.new(connection: faraday)
  end

  def test_create_sms_message
    resp = mock_sdk.sms_messages.create({
      phone_number_id: "idn_xxx",
      message: "hello"
    })
    assert_equal "sms_message", resp["object"]
  end
end
