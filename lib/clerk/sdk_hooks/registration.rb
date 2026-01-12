# typed: true
# frozen_string_literal: true

#
# This file is only ever generated once on the first generation and then is free to be modified.
# Any hooks you wish to add should be registered in the init_hooks method.
#
# Hooks are registered per SDK instance, and are valid for the lifetime of the SDK instance.
#

require_relative './types'

begin
  require 'sorbet-runtime'
rescue LoadError
  # sorbet-runtime not available, skip type annotations
end

module Clerk
  module SDKHooks
    class Registration
      extend T::Sig if defined?(T::Sig)

      if defined?(T::Sig)
        sig do
          params(
            hooks: Hooks
          ).void
        end
      end
      def self.init_hooks(hooks)
        # example_hook = ExampleHook.new

        # hooks.register_sdk_init_hook example_hook
        # hooks.register_before_request_hook example_hook
        # hooks.register_after_error_hook example_hook
        # hooks.register_after_success_hook example_hook
      end
    end
  end
end
