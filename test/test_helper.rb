# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "clerk"
require "timecop"

require "minitest/autorun"

FIXTURE_BASE = File.expand_path("fixtures", __dir__)

def json_fixture(file)
  File.read(File.join(FIXTURE_BASE, "#{file}.json"))
end

def json_ok(file)
  [200, { "Content-Type" => "application/json" }, json_fixture(file)]
end

def json_404
  [404, { "Content-Type" => "application/json" }, JSON.dump(
    { "errors" => [
      { "message" => "not found" }
    ] }
  )]
end
