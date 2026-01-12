# frozen_string_literal: true

require 'minitest/autorun'
require 'faraday'
require 'faraday/adapter/test'
require 'json'
require_relative '../lib/clerk'

class LiveTest < Minitest::Test

  def setup
    @secret_key = ENV['CLERK_SECRET_KEY']
    @email_address_id = ENV['EMAIL_ADDRESS_ID']

  end

  def test_basic
    @sdk = ::Clerk::SDK.new(secret_key: @secret_key)

    res = @sdk.email_addresses.get(email_address_id: @email_address_id)

    assert_equal 200, res.status_code
    assert_equal ::Clerk::Models::Components::EmailAddressObject::EMAIL_ADDRESS, res.email_address.object
    assert_equal @email_address_id, res.email_address.id
  end

  def test_configure
    Clerk.configure do |config|
      config.secret_key = @secret_key
    end

    @sdk = ::Clerk::SDK.new

    res = @sdk.email_addresses.get(email_address_id: @email_address_id)

    assert_equal 200, res.status_code
    assert_equal ::Clerk::Models::Components::EmailAddressObject::EMAIL_ADDRESS, res.email_address.object
    assert_equal @email_address_id, res.email_address.id
  end
end
