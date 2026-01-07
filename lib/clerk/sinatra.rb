require "sinatra/base"
require "clerk/rack"

module Sinatra
  module Clerk
    module Helpers
      def clerk
        env["clerk"]
      end

      def require_reverification!(preset = ::Clerk::StepUp::Preset::STRICT, &block)
        clerk.user_require_reverification!(preset) do
          return yield(preset) if block_given?
          render_reverification!(preset)
        end
      end

      def render_reverification!(preset = nil)
        halt 403, ::Clerk::StepUp::Reverification.error_payload(preset).to_json
      end

      def clerk_sdk
        @@sdk ||= ::Clerk::SDK.new
      end
    end

    def self.registered(app)
      app.helpers Clerk::Helpers
      app.use ::Clerk::Rack::Middleware

      app.set(:auth) do |active|
        condition do
          redirect ENV["CLERK_SIGN_IN_URL"] if active && !clerk.user?
        end
      end

      app.set(:reverify) do |preset|
        condition do
          if preset === true
            preset = ::Clerk::StepUp::Preset::STRICT
          end

          if preset
            require_reverification!(preset)
          end
        end
      end
    end
  end

  register Clerk
end
