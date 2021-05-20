# frozen_string_literal: true

require "test_helper"

class Clerk::Resources::UsersTest < Minitest::Test
  def test_all_users
    users = test_sdk.users.all
    assert_equal ["user", "user"], users.map { |h| h.dig("object") }
  end

  def test_find_user
    user = test_sdk.users.find("user_1")
    assert_equal "user", user["object"]
    assert_equal "user_1", user["id"]
  end

  def test_update_user
    user = test_sdk.users.update("user_1", {first_name: "Mary"})
    assert_equal "Mary", user["first_name"]
    assert_equal "user_1", user["id"]
  end

  def test_delete_user
    user = test_sdk.users.delete("user_1")
    assert_equal true, user["deleted"]
    assert_equal "user", user["object"]
    assert_equal "user_1", user["id"]
  end

  def test_find_user_404
    user = test_sdk.users.find("unknown_id")
    assert_equal "not found", user.dig("errors", 0, "message")
  end
end
