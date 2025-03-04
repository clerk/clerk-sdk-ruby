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
clerk.users.get_user_list
# Get your first user
user = clerk.users.get_user_list(limit: 1).first
# Extract their primary email address ID
email_id = user["primary_email_address_id"]

# Create an organization
p Clerk::SDK.organizations.create_organization({
  create_organization_request: ClerkHttpClient::CreateOrganizationRequest.new({
    name: 'example'
  })
})
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
  c.secret_key = "sk_(test|live)_...." # if omitted: ENV["CLERK_SECRET_KEY"] - API calls will fail if unset
  c.publishable_key = "pk_(test|live)_...." # if omitted: ENV["CLERK_PUBLISHABLE_KEY"] - Handshake mechanism (check section below) will fail if unset
  c.logger = Logger.new(STDOUT) # if omitted, no logging
  c.middleware_cache_store = ActiveSupport::Cache::FileStore.new("/tmp/clerk_middleware_cache") # if omitted: no caching
  c.excluded_routes ["/foo", "/bar/*"]
end
```

You can customize each instance of the `Clerk::SDK` object by passing keyword
arguments to the constructor:

```ruby
clerk = Clerk::SDK.new(
    logger: Logger.new()
    secret_key: "X",
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

```ruby
use Clerk::Rack::Middleware
```

### Reverification middleware

The SDK comes with a revalidation middleware which will automatically revalidate the session when the user navigates to a protected route.

```ruby
use Clerk::Rack::Reverification,
  preset: Clerk::StepUp::Preset::LAX,
  routes: ["/*"]
```



## Rails integration

The SDK will automatically add the [Rack middleware](#rack-middleware) to the
middleware stack. For easier access to the Clerk session and user, include the
`Clerk::Authenticatable` concern in your controller:

```ruby
class ApplicationController < ActionController::Base
  include Clerk::Authenticatable
end

class AdminController < ApplicationController
  before_action :require_reverification!, only: [:protected]

  def index
    @user = clerk.user
  end

  def protected
    render json: {message: clerk.user? ? "Valid session" : "Not logged in"}
  end
end
```

This gives your controller and views access to the following methods and more:

- `clerk.sdk.*`
- `clerk.user?`
- `clerk.user`: NOTE: This makes an additional request and attempts to cache it.
- `clerk.user_id`
- `clerk.organization?`
- `clerk.organization` NOTE: This makes an additional request and attempts to cache it.
- `clerk.organization_id`
- `clerk.organization_role`
- `clerk.organization_permissions`

### Skipping the Railtie

There are cases where you might not want to use the Railtie, for example, only using the SDK in a Rails application. To accomplish this, you can set the `CLERK_SKIP_RAILTIE` environment variable to `true`.

This will prevent the Railtie from being loaded and the Rack middleware from being added to the middleware stack.

You can still configure the SDK as normal, but you will need to call the SDK using `Clerk::SDK.new` instead of the `clerk.sdk` helper.

## Sinatra integration

The SDK enables the use of Extensions to add Clerk support to your Sinatra application.

`Sinatra::Clerk` will automatically add the [Rack middleware](#rack-middleware)to the
middleware stack and enable easy access to the Clerk session and user helper methods.

```ruby
class App < Sinatra::Base
  register Sinatra::Clerk

  get "/" do
    erb :index, format: :html5
  end

  get "/admin" do
    @user = clerk.user
    erb :index, format: :html5
  end

  get "/protected" do
    require_reverification!
    {message: clerk.user? ? "Valid session" : "Not logged in"}.to_json
  end
end
```

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

<a name="handshake"></a>

### Handshake

The Client Handshake is a mechanism that is used to resolve a request’s authentication state from “unknown” to definitively signed in or signed out. Clerk’s session management architecture relies on a short-lived session JWT to validate requests, along with a long-lived session that is used to keep the session JWT fresh by interacting with the Frontend API. The long-lived session token is stored in an HttpOnly cookie associated with the Frontend API domain. If a short-lived session JWT is expired on a request to an application’s backend, the SDK doesn’t know if the session has ended, or if a new short-lived JWT needs to be issued. When an SDK gets into this state, it triggers the handshake.

With the handshake, we can resolve the authentication state on the backend and ensure the request is properly handled as signed in or out, instead of being in a potentially “unknown” state. The handshake flow relies on redirects to exchange session information between FAPI and the application, ensuring the resolution of unknown authentication states minimizes performance impact and behaves consistently across different framework and language implementations.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run
`bundle exec rake spec` to run the tests. You can also run `bin/console` for an
interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. 

To run the example applications, run:

```bash
rake app:rack    
rake app:rails  
rake app:rails:api
rake app:sinatra
```

## Release

To release a new version:
- update the version number in `version.rb`
- update `CHANGELOG.md` to include information about the changes
- merge changes into main
- run `bundle exec rake release`

If gem publishing is NOT executed automatically:
- run `gem push pkg/clerk-sdk-ruby-{version}.gem` to push the `.gem` file to [rubygems.org](https://rubygems.org)

The `bundle exec rake release` command:
- creates a git tag with the version found in `version.rb`
- pushes the git tag

## Yank release

We should avoid yanking a releasing but if it's necessary execute `gem yank clerk-sdk-ruby -v {version}`

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/clerkinc/clerk-sdk-ruby.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
