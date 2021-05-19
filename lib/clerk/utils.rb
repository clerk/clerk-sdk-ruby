module Clerk
  module Utils
    module_function
    def camelize(term)
      string = term.to_s
      string = string.sub(/^[a-z\d]*/) { match.capitalize }
      string.gsub!(/(?:_|(\/))([a-z\d]*)/) { "#{$1}#{$2.capitalize}" }
      string
    end
  end
end
