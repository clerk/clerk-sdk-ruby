# frozen_string_literal: true

source "https://rubygems.org"

# Specify your gem's dependencies in clerk.gemspec
gemspec

# TODO: Update when published
gem "clerk-sdk-ruby-backend", github: "clerk/clerk-sdk-ruby-backend", branch: "main"

group :development do
  gem "activesupport", "~> 8.0", require: false
  gem "dotenv", "~> 3.1", require: false
  gem "puma", "~> 6.4", ">= 6.4.3", require: false
  gem "rack", "~> 3.1", ">= 3.1.8", require: false
  gem "rbs", "~> 3.6"
  gem "rake", "~> 13.0"
  gem "rackup", "~> 2.2", require: false
  gem "sinatra", "~> 4.1", require: false
  gem "standard", "~> 1.42"
end

group :development, :test do
  gem "rspec", "~> 3.0"
  gem "rspec-rails", "~> 7.1"
end

group :test do
  gem "simplecov", require: false
  gem "climate_control"
end
