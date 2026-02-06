# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

Gem::Specification.new do |s|
  s.name        = 'clerk-sdk-ruby'
  s.version     = '5.0.2'
  s.platform    = Gem::Platform::RUBY
  s.licenses    = ['Apache-2.0']
  s.summary     = ''
  s.homepage    = 'https://github.com/clerk/clerk-sdk-ruby.git'
  s.description = 'Ruby Client SDK'
  s.authors     = ['Speakeasy']
  s.metadata    = {
    'homepage_uri' => 'https://github.com/clerk/clerk-sdk-ruby.git',
    'documentation_uri' => 'https://github.com/clerk/clerk-sdk-ruby.git',
    'source_code_uri' => 'https://github.com/clerk/clerk-sdk-ruby.git'
  }

  s.files         = Dir['{lib,test}/**/*']
  s.require_paths = ['lib']
  s.required_ruby_version = '>= 3.2'

  s.add_dependency('base64', '>= 0.2.0', '< 1.0')
  s.add_dependency('concurrent-ruby', '~> 1.3.5')
  s.add_dependency('faraday')
  s.add_dependency('faraday-multipart', '~> 1.2.0')
  s.add_dependency('faraday-retry', '~> 2.4.0')
  s.add_dependency('jwt', '~> 2.5')
  s.add_development_dependency('activesupport', '~> 8.0.0')
  s.add_development_dependency('dotenv', '~> 3.1')
  s.add_development_dependency('minitest', '>= 5.27.0')
  s.add_development_dependency('minitest-focus', '~> 1.4.1')
  s.add_development_dependency('puma', '~> 6.4.3')
  s.add_development_dependency('rack', '~> 3.1.18')
  s.add_development_dependency('rackup', '~> 2.2')
  s.add_development_dependency('rake', '~> 13.0')
  s.add_development_dependency('rubocop', '~> 1.73.2')
  s.add_development_dependency('rubocop-minitest', '~> 0.37.1')
  s.add_development_dependency('sinatra', '~> 4.1')
end
