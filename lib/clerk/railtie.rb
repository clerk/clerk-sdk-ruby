# frozen_string_literal: true

require 'clerk/rack_middleware'

module Clerk
  module Rails
    class Railtie < ::Rails::Railtie
      initializer 'clerk.configure_rails_initialization' do |app|
        unless ENV['CLERK_SKIP_RAILTIE']
          app.middleware.use Clerk::Rack::Middleware
        end
      end
    end
  end
end
