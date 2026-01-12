# frozen_string_literal: true

require 'minitest/autorun'
require 'faraday'
require 'faraday/adapter/test'
require 'json'
require_relative '../lib/clerk'

class ReadmeExampleTest < Minitest::Test
  def setup
    # Create a Faraday connection with test adapter
    @stubs = Faraday::Adapter::Test::Stubs.new
    test_connection = Faraday.new do |builder|
      builder.adapter :test, @stubs
    end

    # Initialize SDK with test connection
    @sdk = ::Clerk::SDK.new(
      secret_key: 'test_bearer_token',
      client: test_connection,
      server_url: 'https://api.clerk.com/v1'
    )
  end

  def test_readme_example_email_addresses_get
    # Mock response data matching EmailAddress structure
    email_address_id = 'email_address_id_example'
    mock_response_data = {
      'object' => 'email_address',
      'email_address' => 'test@example.com',
      'reserved' => false,
      'linked_to' => [],
      'created_at' => 1_234_567_890,
      'updated_at' => 1_234_567_890,
      'id' => email_address_id
    }

    # Stub the GET request to the full URL
    # The SDK will make a request to https://api.clerk.com/v1/email_addresses/{email_address_id}
    @stubs.get("https://api.clerk.com/v1/email_addresses/#{email_address_id}") do |env|
      # Verify Authorization header is set
      unless env[:request_headers]['Authorization'] == 'Bearer test_bearer_token'
        raise "Expected Authorization header 'Bearer test_bearer_token', got '#{env[:request_headers]['Authorization']}'"
      end
      [
        200,
        { 'Content-Type' => 'application/json' },
        mock_response_data.to_json
      ]
    end

    # Execute the example code from README
    res = @sdk.email_addresses.get(email_address_id: email_address_id)

    # Assertions matching the README example pattern
    assert_equal 200, res.status_code
    refute_nil res.email_address, 'email_address should not be nil'
    assert_equal 'test@example.com', res.email_address.email_address
    assert_equal email_address_id, res.email_address.id
    assert_equal ::Clerk::Models::Components::EmailAddressObject::EMAIL_ADDRESS, res.email_address.object
  end

  def test_readme_example_with_nil_response
    email_address_id = 'non_existent_id'

    # Stub a 404 response
    @stubs.get("https://api.clerk.com/v1/email_addresses/#{email_address_id}") do |_env|
      [
        404,
        { 'Content-Type' => 'application/json' },
        {
          'errors' => [{
            'message' => 'Email address not found',
            'long_message' => 'Email address not found',
            'code' => 'not_found'
          }]
        }.to_json
      ]
    end

    # Test error handling
    assert_raises(::Clerk::Models::Errors::ClerkErrors) do
      @sdk.email_addresses.get(email_address_id: email_address_id)
    end
  end
end
