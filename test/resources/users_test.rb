# frozen_string_literal: true

require "test_helper"

module Clerk
  module Resources
    class UsersTest < Minitest::Test
      def mock_sdk
        faraday = Faraday.new do |faraday|
          faraday.adapter :test do |stub|
            stub.get("/users") { json_ok("all_users") }
            stub.get("/users?limit=10") { json_ok("all_users") }
            stub.get("/users/user_1") { json_ok("user_1") }
            stub.patch("/users/user_1") { json_ok("user_1_updated") }
            stub.delete("/users/user_1") { json_ok("user_1_deleted") }
            stub.get("/users/unknown_id") { json_404 }
            stub.get("/users/user_1/oauth_access_tokens/hubspot") { json_ok("users_oauth_access_token") }
          end
        end

        ::Clerk::SDK.new(connection: faraday)
      end

      def test_all_users
        users = mock_sdk.users.all
        assert_equal(%w[user user], users.map { |h| h["object"] })
      end

      def test_all_users_query_params
        users = mock_sdk.users.all(limit: 1)
        assert_equal(%w[user user], users.map { |h| h["object"] })
      end

      def test_find_user
        user = mock_sdk.users.find("user_1")
        assert_equal "user", user["object"]
        assert_equal "user_1", user["id"]
      end

      def test_update_user
        user = mock_sdk.users.update("user_1", { first_name: "Mary" })
        assert_equal "Mary", user["first_name"]
        assert_equal "user_1", user["id"]
      end

      def test_delete_user
        user = mock_sdk.users.delete("user_1")
        assert_equal true, user["deleted"]
        assert_equal "user", user["object"]
        assert_equal "user_1", user["id"]
      end

      def test_find_user_404
        assert_raises Clerk::Errors::Fatal do
          mock_sdk.users.find("unknown_id")
        end
      end

      def test_oauth_access_token
        response = mock_sdk.users.oauth_access_token("user_1", "hubspot")
        assert_equal "xxxx", response["token"]
        assert_equal "hubspot", response["provider"]
        assert_equal %w[oauth contacts], response["scopes"]
      end
    end
  end
end
