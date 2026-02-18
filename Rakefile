# typed: false
# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'minitest/test_task'
require 'rubocop/rake_task'

RuboCop::RakeTask.new do |task|
  task.options = ['--parallel']
end

Minitest::TestTask.create do |t|
  # workaround to avoid throwing warnings from Janeway library circular require...
  t.warning = false
end

namespace :sorbet do
  desc "Remove legacy Sorbet artifacts like extra.rbi"
  task :clean do
    extra = File.join(__dir__, "extra.rbi")

    if File.exist?(extra)
      puts "Removing legacy file: extra.rbi"
      File.delete(extra)
    else
      puts "extra.rbi not present — nothing to clean"
    end
  end
end

task :default => :test


# Developers can run all tests with:
#
# $ rake test
#
# Developers can run individual test files with:
#
# $ rake test test/parameter_test
#
# and run individual tests by adding `focus` to the line before the test definition.