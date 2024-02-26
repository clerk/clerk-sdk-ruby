# frozen_string_literal: true

module Clerk
  module Utils
    module_function

    def camelize(term)
      string = term.to_s
      string = string.sub(/^[a-z\d]*/) { match.capitalize }
      string.gsub!(%r{(?:_|(/))([a-z\d]*)}) { "#{::Regexp.last_match(1)}#{::Regexp.last_match(2).capitalize}" }
      string
    end
  end
end
