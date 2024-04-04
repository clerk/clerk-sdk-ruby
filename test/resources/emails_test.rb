# frozen_string_literal: true

require "test_helper"

module Clerk
  module Resources
    class EmailsTest < Minitest::Test
      def mock_sdk
        faraday = Faraday.new do |f|
          f.adapter :test do |stub|
            stub.post("/emails") { json_ok("email_created") }
          end
        end

        ::Clerk::SDK.new(connection: faraday)
      end

      def test_create_email
        resp = mock_sdk.emails.create({
                                        email_address_id: "idn_xxx",
                                        from_email_name: "noreply",
                                        subject: "hi",
                                        body: "hello"
                                      })

        assert_equal "email", resp["object"]
      end
    end
  end
end
