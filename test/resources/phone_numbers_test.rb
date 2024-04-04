# frozen_string_literal: true

require "test_helper"

module Clerk
  module Resources
    class PhoneNumbersTest < Minitest::Test
      def mock_sdk
        faraday = Faraday.new do |f|
          f.adapter :test do |stub|
            stub.get("/phone_numbers/idn_phone") { json_ok("phone_number_1") }
            stub.post("/phone_numbers") { json_ok("phone_number_1") }
            stub.patch("/phone_numbers/idn_phone") { json_ok("phone_number_1_updated") }
            stub.delete("/phone_numbers/idn_phone") { json_ok("phone_number_1_deleted") }
          end
        end

        ::Clerk::SDK.new(connection: faraday)
      end

      def test_find_phone_number
        phone_number_id = "idn_phone"
        phone_number = mock_sdk.phone_numbers.find(phone_number_id)

        assert_equal "phone_number", phone_number["object"]
        assert_equal phone_number_id, phone_number["id"]
        assert_equal "+15555555555", phone_number["phone_number"]
        assert_nil phone_number["verification"]
      end

      def test_create_phone_number
        phone_number = mock_sdk.phone_numbers.create(user_id: "user_abcdefg", phone_number: "+15555555555")

        assert_equal "phone_number", phone_number["object"]
        assert_equal "+15555555555", phone_number["phone_number"]
        assert_nil phone_number["verification"]
      end

      def test_update_phone_number
        phone_number_id = "idn_phone"
        phone_number = mock_sdk.phone_numbers.update(phone_number_id, verified: true)

        assert_equal "phone_number", phone_number["object"]
        assert_equal phone_number_id, phone_number["id"]
        assert_equal "+15555555555", phone_number["phone_number"]
        refute_nil phone_number["verification"]
      end

      def test_delete_phone_number
        phone_number_id = "idn_phone"
        deleted_object = mock_sdk.phone_numbers.delete(phone_number_id)

        assert_equal "phone_number", deleted_object["object"]
        assert_equal phone_number_id, deleted_object["id"]
        assert deleted_object["deleted"]
      end
    end
  end
end
