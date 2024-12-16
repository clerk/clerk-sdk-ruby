# frozen_string_literal: true

require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "standard/rake"

RSpec::Core::RakeTask.new(:spec)

task default: :spec

namespace :app do
  desc "Run Rack application"
  task :rack do
    cd "apps/rack" do
      system("bundle exec puma -p 3000")
    end
  end

  desc "Run Rails (full stack) application"
  task :rails do
    cd "apps/rails-full" do
      system("bin/rails server")
    end
  end

  namespace :rails do
    desc "Run Rails (API only) application"
    task :api do
      cd "apps/rails-api" do
        system("bin/rails server")
      end
    end
  end

  desc "Run Sinatra application"
  task :sinatra do
    cd "apps/sinatra" do
      system("bundle exec ruby app.rb")
    end
  end
end
