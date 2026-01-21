# frozen_string_literal: true

require 'active_support'
require 'rack'
require 'clerk/rack'
require 'dotenv'

require_relative 'app'
require_relative 'middleware/disable_paths'

Dotenv.load('.env')

use DisablePaths, paths: ['/favicon.ico']
use Clerk::Rack::Middleware
# use Clerk::Rack::Reverification,
#     preset: Clerk::StepUp::Preset::LAX,
#     routes: ['/*']

run App.new
