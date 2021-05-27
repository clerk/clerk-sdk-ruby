# frozen_string_literal: true
#
require_relative "rack_middleware"

module Clerk
  class Railtie < ::Rails::Railtie
    initializer "clerk_railtie.configure_rails_initialization" do |app|
      app.middleware.use Clerk::RackMiddleware
    end

    config.to_prepare do
      Clerk.configure do |c|
        c.middleware_cache_store ||= Rails.cache
      end
    end
  end
end
