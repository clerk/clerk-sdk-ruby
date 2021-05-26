# frozen_string_literal: true

require_relative "clerk/version"
require_relative "clerk/sdk"

if defined?(::Rails)
  require_relative "clerk/railtie"
end
