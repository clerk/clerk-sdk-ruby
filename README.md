<p align="center">
  <a href="https://www.clerk.com/?utm_source=github&utm_medium=starter_repos&utm_campaign=sdk_ruby" target="_blank" align="center">
    <picture>
      <source media="(prefers-color-scheme: dark)" srcset="./docs/clerk-logo-dark.png">
      <img src="./docs/clerk-logo-light.png" height="64">
    </picture>
  </a>
  <br />
</p>

# Clerk Ruby SDK

This SDK allows you to call the [Clerk](https://www.clerk.com/?utm_source=github&utm_medium=starter_repos&utm_campaign=sdk_ruby) Backend API from Ruby code without having to implement the calls yourself.

[![chat on Discord](https://img.shields.io/discord/856971667393609759.svg?logo=discord)](https://discord.com/invite/b5rXHjAg7A)
[![documentation](https://img.shields.io/badge/documentation-clerk-green.svg)](https://clerk.com/docs)
[![twitter](https://img.shields.io/twitter/follow/ClerkDev?style=social)](https://twitter.com/intent/follow?screen_name=ClerkDev)

---

**Clerk is Hiring!**

Would you like to work on Open Source software and help maintain this repository? [Apply today!](https://apply.workable.com/clerk-dev/)

---

**Note**: You're looking at the main branch, which requires that you use [Auth
v2](https://clerk.com/docs/upgrade-guides/auth-v2).

If you're looking for the legacy authentication scheme, refer to the
[`v1`](https://github.com/clerkinc/clerk-sdk-ruby/tree/v1) branch.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'clerk-sdk-ruby', require: "clerk"
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install clerk-sdk-ruby

## Quick Start

First, you need to get an API key for a Clerk instance. This is done via the
[Clerk dashboard](https://dashboard.clerk.com/applications).

Then you can instantiate a `Clerk::SDK` instance and access all
[Backend API](https://clerk.com/docs/reference/backend-api) endpoints.
Here's a quick example:

```ruby
clerk = Clerk::SDK.new(api_key: "your_api_key")
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

The SDK can be configured in three ways: environment variables, configuration
singleton and constructor arguments. The priority goes like this:

1. Constructor arguments
2. Configuration object
3. Environment variables

If an argument is not provided, the configuration object is looked up, which
falls back to the associated environment variable. Here's an example with all
supported configuration settings their environment variable equivalents:

```ruby
Clerk.configure do |c|
  c.api_key = "your_api_key" # if omitted: ENV["CLERK_API_KEY"] - API calls will fail if unset
  c.base_url = "https://..." # if omitted: "https://api.clerk.dev/v1/"
  c.logger = Logger.new(STDOUT) # if omitted, no logging
  c.middleware_cache_store = ActiveSupport::Cache::FileStore.new("/tmp/clerk_middleware_cache") # if omitted: no caching
  c.excluded_routes ["/foo", "/bar/*"]
end
```

You can customize each instance of the `Clerk::SDK` object by passing keyword
arguments to the constructor:

```ruby
clerk = Clerk::SDK.new(
    api_key: "X",
    base_url: "Y",
    logger: Logger.new()
)
```

For full customization, you can instead pass a `Faraday` object directly, which
will ignore all the other arguments, if passed:

```ruby
faraday = Faraday.new()
clerk = Clerk::SDK.new(connection: faraday)
```

Refer to the [Faraday documentation](https://lostisland.github.io/faraday/usage/#customizing-faradayconnection)
for details.

## Rack middleware

The SDK comes with a Rack middleware which lazily loads the Clerk session and
user. It inserts a `clerk` key in the Rack environment, which is an instance
of `Clerk::Proxy`. To get the session or the user of the session, you call
`session` or `user` respectively. In case there is no session, you can retrieve
the API error with the `error` getter method.

## Rails integration

The SDK will automatically add the [Rack middleware](#rack-middleware) to the
middleware stack. For easier access to the Clerk session and user, include the
`Clerk::Authenticatable` concern in your controller:

```ruby
require "clerk/authenticatable"

class ApplicationController < ActionController::Base
  include Clerk::Authenticatable
end
```

This gives your controller and views access to the following methods:

- `clerk_session`
- `clerk_user`
- `clerk_user_signed_in?`

## Internals

The API client depends on the excellent [Faraday](https://rubygems.org/gems/faraday)
gem for HTTP requests. You can swap out the original implementation with your
own customized instance.

The API client sends all requests as `application/x-www-form-urlencoded`. The
API then responds with JSON which is then converted and returned as a Ruby
`Hash`, or `Array` of hashes. Errors are also returned as a JSON object, with a
single key (`errors`) containing an array of error objects.

Read the [API documentation](https://clerk.com/docs/reference/backend-api)
for details on expected parameters and response formats.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run
`bundle exec rake` to run the tests. You can also run `bin/console` for an
interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To
release a new version, update the version number in `version.rb`, and then run
`bundle exec rake release`, which will create a git tag for the version, push
git commits and the created tag, and push the `.gem` file to
[rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/clerkinc/clerk-sdk-ruby.

## License

The gem is available as open source under the terms of the
[MIT License](https://opensource.org/licenses/MIT).
