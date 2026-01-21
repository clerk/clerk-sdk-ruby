# frozen_string_literal: true

require 'active_support/concern'

module Clerk
  module Authenticatable
    extend ActiveSupport::Concern

    protected

    def clerk
      request.env['clerk']
    end

    def require_reverification!(preset = StepUp::Preset::STRICT, &block)
      clerk.user_require_reverification!(preset) do
        return yield(preset) if block_given?
        render_reverification!(preset)
      end
    end

    def render_reverification!(preset = nil)
      render status: 403, json: StepUp::Reverification.error_payload(preset)
    end

    included do
      if respond_to?(:helper_method)
        helper_method :clerk, :require_reverification!, :render_reverification!
      end
    end
  end
end
