# frozen_string_literal: true

require_relative "lib/clerk/version"

Gem::Specification.new do |spec|
  spec.name          = "clerk-sdk-ruby"
  spec.version       = Clerk::VERSION
  spec.authors       = ["Clerk"]
  spec.email         = ["ruby-sdk@clerk.dev"]

  spec.summary       = "Clerk SDK for Ruby."
  spec.description   = "Client SDK for the Clerk backend API."
  spec.homepage      = "https://github.com/clerkinc/clerk-sdk-ruby"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.4.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/clerkinc/clerk-sdk-ruby"
  spec.metadata["changelog_uri"] = "https://github.com/clerkinc/clerk-sdk-ruby/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "faraday", "~> 1.4.1"
  spec.add_dependency "jwt", '~> 2.5'
  spec.add_dependency "concurrent-ruby", "~> 1.1"

  spec.add_development_dependency "byebug", "~> 11.1"
  spec.add_development_dependency "timecop", "~> 0.9.4"
end
