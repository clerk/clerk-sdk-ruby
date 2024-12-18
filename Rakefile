# frozen_string_literal: true

require "bundler/gem_tasks"
require "standard/rake"

################################
# COVERAGE
################################

desc "Open coverage report"
task(:cov) { system "open coverage/index.html" }

################################
# TESTING
################################

desc "Run all tests"
task spec: "spec:all"

namespace :spec do
  task(:all) { system "bundle exec rspec" }

  desc "Run tests on file changes"
  task(:watch) { system "bundle exec guard -g spec" }

  desc "Run failed tests only"
  task(:failed) { system "bundle exec rspec --only-failures" }
end

################################
# PLAYGROUND APPLICATIONS
################################

namespace :app do
  desc "Run Rails (full stack) application"
  task rails: "rails:full"

  namespace :rails do
    task :full do
      cd ("apps/rails-full") { system "bin/rails server" }
    end

    desc "Run Rails (API only) application"
    task :api do
      cd ("apps/rails-api") { system "bin/rails server" }
    end
  end

  desc "Run Rack application"
  task(:rack) { system "rerun --dir lib,apps/rack --pattern '**/*.{rb,ru}' -- bundle exec puma apps/rack/config.ru -p 3000" }

  desc "Run Sinatra application"
  task(:sinatra) { system "rerun --dir lib,apps/sinatra --pattern '**/*.{erb,rb,ru}' -- bundle exec puma apps/sinatra/config.ru -p 3000 -v" }
end


