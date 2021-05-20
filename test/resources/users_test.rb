# frozen_string_literal: true

require "test_helper"

class Clerk::Resources::UsersTest < Minitest::Test
  def mock_sdk
    faraday = Faraday.new do |faraday|
      faraday.adapter :test do |stub|
        stub.get("/users") { json_ok("all_users") }
        stub.get("/users/user_1") { json_ok("user_1") }
        stub.patch("/users/user_1") { json_ok("user_1_updated") }
        stub.delete("/users/user_1") { json_ok("user_1_deleted") }
        stub.get("/users/unknown_id") { json_404 }
      end
    end

    ::Clerk::SDK.new(connection: faraday)
  end

  def test_all_users
    users = mock_sdk.users.all
    assert_equal ["user", "user"], users.map { |h| h.dig("object") }
  end

  def test_find_user
    user = mock_sdk.users.find("user_1")
    assert_equal "user", user["object"]
    assert_equal "user_1", user["id"]
  end

  def test_update_user
    user = mock_sdk.users.update("user_1", {first_name: "Mary"})
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
    user = mock_sdk.users.find("unknown_id")
    assert_equal "not found", user.dig("errors", 0, "message")
  end
end
