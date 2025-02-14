require_relative './app'

Clerk.configure do |config|
  config.debug = true
  config.logger = Logger.new($stdout)
end

run App