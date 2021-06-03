# frozen_string_literal: true
#
require "test_helper"

class Clerk::SdkTest < Minitest::Test
  def test_sdk_init_without_config
    sdk = ::Clerk::SDK.new
    assert sdk
  end

  def test_no_api_key_raises_on_api_call
    sdk = ::Clerk::SDK.new
    assert_raises ArgumentError do
      sdk.users.find("x")
    end
  end
end
