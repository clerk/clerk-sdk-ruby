# frozen_string_literal: true
#
require_relative "rack_middleware"
require_relative "rack_middleware_v2"

module Clerk
  class Railtie < ::Rails::Railtie
    initializer "clerk_railtie.configure_rails_initialization" do |app|
      app.middleware.use Clerk::RackMiddlewareV2
    end
  end
end
