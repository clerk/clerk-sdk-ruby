# frozen_string_literal: true

require "test_helper"

module Clerk
  module Resources
    class SessionsTest < Minitest::Test
      def mock_sdk
        faraday = Faraday.new do |f|
          f.adapter :test do |stub|
            stub.get("/sessions") { json_ok("all_sessions") }
            stub.get("/sessions/sess_1") { json_ok("session_1") }
            stub.post("/sessions/sess_1/revoke") { json_ok("session_1") }
            stub.post("/sessions/sess_1/verify") { json_ok("session_1") }
          end
        end

        ::Clerk::SDK.new(connection: faraday)
      end

      def test_all_sessions
        sess = mock_sdk.sessions.all
        assert_equal(["session"], sess.map { |h| h["object"] })
      end

      def test_find_session
        sess = mock_sdk.sessions.find("sess_1")
        assert_equal "session", sess["object"]
        assert_equal "sess_1", sess["id"]
      end

      def test_revoke_session
        sess = mock_sdk.sessions.revoke("sess_1")
        assert_equal "session", sess["object"]
        assert_equal "sess_1", sess["id"]
      end

      def test_verify_session
        sess = mock_sdk.sessions.verify_token("sess_1", "token_1")
        assert_equal "session", sess["object"]
        assert_equal "sess_1", sess["id"]
      end
    end
  end
end
