# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "clerk"

require "minitest/autorun"

FIXTURE_BASE = File.expand_path("fixtures", __dir__)

def test_sdk
  faraday = Faraday.new do |faraday|
    faraday.adapter :test do |stub|
      stub.get("/users") do |env|
        json_ok("all_users")
      end
      stub.get("/users/user_1") do |env|
        json_ok("user_1")
      end
      stub.patch("/users/user_1") do |env|
        json_ok("user_1_updated")
      end
      stub.delete("/users/user_1") do |env|
        json_ok("user_1_deleted")
      end
      stub.get("/users/unknown_id") do |env|
        json_404
      end
    end
  end

  ::Clerk::SDK.new(connection: faraday, api_key: "test")
end

def json_fixture(file)
  File.read(File.join(FIXTURE_BASE, "#{file}.json"))
end

def json_ok(file)
  [200, {"Content-Type" => "application/json"}, json_fixture(file)]
end

def json_404
  [404, {"Content-Type" => "application/json"}, JSON.dump(
    {"errors" => [
      {"message" => "not found"}
    ]}
  )]
end
