# frozen_string_literal: true

source "https://rubygems.org"

# Specify your gem's dependencies in clerk.gemspec
gemspec

group :development do
  gem "activesupport", "~> 8.0", require: false
  gem "dotenv", "~> 3.1", require: false
  gem "puma", "~> 6.4", ">= 6.4.3", require: false
  gem "rack", "~> 3.1", ">= 3.1.14", require: false
  gem "rbs", "~> 3.6"
  gem "rake", "~> 13.0"
  gem "rackup", "~> 2.2", require: false
  gem "rb-fsevent", "~> 0.11", ">= 0.11.2", platform: [:ruby], require: false
  gem "rerun", "~> 0.14", require: false
  gem "sinatra", "~> 4.1", ">= 4.1.1", require: false
  gem "standard", "~> 1.42"
  gem "wdm", "~> 0.2", platform: [:mswin, :windows]
end

group :development, :test do
  gem "rspec", "~> 3.0"
  gem "rspec-rails", "~> 7.1"
  gem "guard-rspec", "~> 4.7", require: false
  gem "guard-rake", "~> 1.0", require: false
end

group :test do
  gem "simplecov", require: false
  gem "climate_control", require: false
end
