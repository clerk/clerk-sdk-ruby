# Clerk Ruby SDK

Thank you for choosing [Clerk](https://clerk.dev/) for your authentication,
session & user management needs!

This SDK allows you to call the Clerk Backend API from Ruby code without having
to implement the calls yourself.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'clerk-sdk-ruby'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install clerk-sdk-ruby

## Quick Start

First, you need to get an API key for a Clerk instance. This is done via the [Clerk dashboard](https://dashboard.clerk.dev/applications).

Then you can instantiate a `Clerk::Client` instance and access all [Backend API](https://docs.clerk.dev/backend/backend-api-reference) endpoints.

```ruby
clerk = Clerk::Client.new(api_key: "your_api_key")
# List all users
clerk.users.all
# Get your first user
user = clerk.users.all(limit: 1).first
# Extract their primary email address ID
email_id = user["primary_email_address_id"]
# Send them a welcome email
clerk.emails.create(
    email_address_id: email_id,
    from_email_name: "welcome",
    subject: "Welcome to MyApp",
    body: "Welcome to MyApp, #{user["first_name"]}",
)
```

## Configuration

The SDK can be configured in two ways: environment variables and constructor arguments. Constructor arguments have priority over environment variables. If an argument is not provided, the environment variable will be `fetch`ed. Here's an example with all supported constructor arguments and their environment variable equivalents:

```ruby
clerk = Clerk::Client.new(
    # Fallback: ENV.fetch("CLERK_API_KEY") - fails if not set!
    api_key: "your_api_key",
    # Fallback: ENV.fetch("CLERK_API_BASE", "https://api.clerk.dev/v1/")
    base_url: "https://...",
    # Fallback: no logging
    logger: Logger.new(STDOUT),
    # Only for debugging. Omit on prouction
    ssl_verify_mode: "VERIFY_NONE",
)
```

## Internals

The API client sends all requests as `application/x-www-form-urlencoded`. The API then responds with JSON is then converted and returned as a Ruby `Hash`, or `Array` of hashes. Errors are also returned as a JSON object, with a single key (`errors`) containing an array of error objects.

Read the [API documentation](https://docs.clerk.dev/backend/backend-api-reference) for details on expected parameters and response formats.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/clerkinc/clerk-sdk-ruby.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
