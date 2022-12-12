# frozen_string_literal: true

require "test_helper"

class Clerk::Resources::EmailAddressesTest < Minitest::Test

  def mock_sdk
    faraday = Faraday.new do |faraday|
      faraday.adapter :test do |stub|
        stub.get("/email_addresses/idn_email") { json_ok("email_address_1") }
        stub.post("/email_addresses") { json_ok("email_address_1") }
        stub.patch("/email_addresses/idn_email") { json_ok("email_address_1_updated") }
        stub.delete("/email_addresses/idn_email") { json_ok("email_address_1_deleted") }
      end
    end

    ::Clerk::SDK.new(connection: faraday)
  end

  def test_find_email_address
    email_address_id = "idn_email"
    email_address = mock_sdk.email_addresses.find(email_address_id)
    assert_equal "email_address", email_address["object"]
    assert_equal email_address_id, email_address["id"]
    assert_equal "john@doe.com", email_address["email_address"]
    assert_nil email_address["verification"]
  end

  def test_create_email_address
    email_address = mock_sdk.email_addresses.create(user_id: "user_abcdefg", email_address: "")
    assert_equal "email_address", email_address["object"]
    assert_equal "john@doe.com", email_address["email_address"]
    assert_nil email_address["verification"]
  end

  def test_update_email_address
    email_address_id = "idn_email"
    email_address = mock_sdk.email_addresses.update(email_address_id, verified: true)
    assert_equal "email_address", email_address["object"]
    assert_equal email_address_id, email_address["id"]
    assert_equal "john@doe.com", email_address["email_address"]
    refute_nil email_address["verification"]
  end

  def test_delete_email_address
    email_address_id = "idn_email"
    deleted_object = mock_sdk.email_addresses.delete(email_address_id)
    assert_equal "email_address", deleted_object["object"]
    assert_equal email_address_id, deleted_object["id"]
    assert deleted_object["deleted"]
  end

end
