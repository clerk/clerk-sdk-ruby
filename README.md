# clerk-sdk-ruby

Developer-friendly & type-safe Ruby SDK specifically catered to leverage *clerk-sdk-ruby* API.

[![Built by Speakeasy](https://img.shields.io/badge/Built_by-SPEAKEASY-374151?style=for-the-badge&labelColor=f3f4f6)](https://www.speakeasy.com/?utm_source=clerk-sdk-ruby&utm_campaign=ruby)
[![License: MIT](https://img.shields.io/badge/LICENSE_//_MIT-3b5bdb?style=for-the-badge&labelColor=eff6ff)](https://opensource.org/licenses/MIT)


<br /><br />
> [!IMPORTANT]
> This SDK is not yet ready for production use. To complete setup please follow the steps outlined in your [workspace](https://app.speakeasy.com/org/clerk/clerk). Delete this section before > publishing to a package manager.

<!-- Start Summary [summary] -->
## Summary

Clerk Backend API: The Clerk REST Backend API, meant to be accessed by backend servers.

### Versions

When the API changes in a way that isn't compatible with older versions, a new version is released.
Each version is identified by its release date, e.g. `2025-04-10`. For more information, please see [Clerk API Versions](https://clerk.com/docs/versioning/available-versions).

Please see https://clerk.com/docs for more information.

More information about the API can be found at https://clerk.com/docs
<!-- End Summary [summary] -->

## Table of Contents
<!-- $toc-max-depth=2 -->
* [clerk-sdk-ruby](#clerk-sdk-ruby)
  * [SDK Installation](#sdk-installation)
  * [Configuration](#configuration)
  * [Framework Integration](#framework-integration)
  * [Step-Up Verification](#step-up-verification)
  * [Available Resources and Operations](#available-resources-and-operations)
  * [Error Handling](#error-handling)
* [Development](#development)
  * [Maturity](#maturity)
  * [Contributions](#contributions)

<!-- No Table of Contents [toc] -->

## SDK Installation

Add this line to your application's Gemfile:

```ruby
gem 'clerk-sdk-ruby', require: "clerk"
```

And then execute:

```
$ bundle install
```


## Configuration

### Environment Variables

The SDK automatically reads these environment variables:

| Variable	            | Description                                  |
------------------------|----------------------------------------------|
| CLERK_SECRET_KEY	    | Your Clerk secret key (starts with sk_)      |
| CLERK_PUBLISHABLE_KEY	| Your Clerk publishable key (starts with pk_) |
| CLERK_SIGN_IN_URL     | to redirect unauthenticated users            |
| CLERK_SIGN_UP_URL     | for new user registration                    |
| CLERK_SIGN_OUT_URL	  | URL for sign out                             |

### Programmatic Configuration

```ruby
require 'clerk'

Clerk.configure do |config|
  # Optional: Override environment variables
  config.publishable_key = ENV['CLERK_PUBLISHABLE_KEY']
  config.secret_key = ENV['CLERK_SECRET_KEY']
  
  # Enable debug logging
  config.debug = true
  config.logger = Logger.new($stdout)
  
  # Exclude routes from authentication middleware
  config.excluded_routes = ['/health', '/public/*']
  
  # Custom cache store (defaults to Rails.cache or ActiveSupport::Cache::MemoryStore)
  config.cache_store = Rails.cache
end
```

## Framework Integration

### Rails
The SDK automatically integrates with Rails via a Railtie. Simply include Clerk::Authenticatable in your controllers:

config/initializers/clerk.rb
```ruby
Clerk.configure do |config|
  # Configuration options here
end
```

app/controllers/application_controller.rb
```ruby
class ApplicationController < ActionController::Base 
  include Clerk::Authenticatable
end
```

For API-only Rails apps:
```ruby
class ApplicationController < ActionController::API
  include Clerk::Authenticatable
end
```

Skip the Railtie (for custom middleware setup):

```bash
export CLERK_SKIP_RAILTIE=true
```

### Sinatra

```ruby
require 'clerk/sinatra'
require 'sinatra/base'

class App < Sinatra::Base
  register Sinatra::Clerk
  
  get '/' do
    if clerk.user?
      "Hello, #{clerk.user.first_name}!"
    else
      "Please sign in"
    end
  end
  
  # Require authentication for specific routes
  get '/dashboard', auth: true do
    erb :dashboard
  end
  
  # Require reverification for sensitive routes
  get '/settings', reverify: true do
    erb :settings
  end
end
```

### Rack
config.ru

```ruby
require 'clerk/rack'

use Clerk::Rack::Middleware

# Optional: Add reverification middleware
use Clerk::Rack::Reverification,
    preset: Clerk::StepUp::Preset::STRICT,
    routes: ['/admin/*', '/settings/*']

run MyApp
```

## Authentication & Session Management

### Accessing the Clerk Helper

In all frameworks, the clerk helper provides access to authentication state:


```ruby
# Check if user is authenticated
clerk.user?  # => true/false

# Get current user (makes API call, cached for 60 seconds)
clerk.user   # => Clerk::Models::User or nil

# Get user ID without API call
clerk.user_id  # => "user_abc123" or nil

# Get session claims (JWT payload)
clerk.session  # => Hash with JWT claims
```

### Session Claims
The session contains JWT claims including:

```ruby
clerk.session
# {
#   "sub" => "user_abc123",           # User ID
#   "sid" => "sess_xyz789",           # Session ID
#   "org_id" => "org_123",            # Organization ID (if applicable)
#   "org_slug" => "my-org",           # Organization slug
#   "org_role" => "org:admin",        # Organization role
#   "org_permissions" => [...],       # Organization permissions
#   "iat" => 1234567890,              # Issued at
#   "exp" => 1234571490,              # Expiration
#   ...
# }
```

### Accessing User & Organization Data

```ruby
# Get full user object (API call, cached)
user = clerk.user

# Access user properties
user.id                  # => "user_abc123"
user.first_name          # => "John"
user.last_name           # => "Doe"
user.email_addresses     # => Array of email addresses
user.primary_email_address_id
user.phone_numbers
user.created_at
user.updated_at
user.public_metadata
user.private_metadata
```

### Organization Information

```ruby
# Check if user is in an organization context
clerk.organization?  # => true/false

# Get organization ID
clerk.organization_id  # => "org_123" or nil

# Get full organization object (API call, cached)
org = clerk.organization

# Access organization properties
org.id
org.name
org.slug
org.members_count

# Get user's role in the organization
clerk.organization_role  # => "org:admin"

# Get user's permissions
clerk.organization_permissions  # => ["org:billing:manage", "org:users:read"]
```


## Backend API Operations

```ruby
require 'clerk'

# Initialize the SDK
sdk = Clerk::SDK.new

# Or with explicit credentials
sdk = Clerk::SDK.new(secret_key: 'sk_test_...')

# List users
response = sdk.users.list(limit: 10, offset: 0)
response.user_list.each do |user|
  puts user.email_addresses.first.email_address
end
```

## Step-Up Verification (Reverification)

Reverification requires users to re-authenticate for sensitive operations.

### Presets
| Preset	                          | Timeout	Level             |
------------------------------------|---------------------------|
| Clerk::StepUp::Preset::STRICT   	| 10 minutes	Second factor |
| Clerk::StepUp::Preset::STRICT_MFA	| 10 minutes	Multi-factor  |
| Clerk::StepUp::Preset::MODERATE	  | 60 minutes	Second factor |
| Clerk::StepUp::Preset::LAX	      | 24 hours	Second factor   |


### Rails Usage

```ruby
class SettingsController < ApplicationController
  before_action :require_reverification!, only: [:update_password]
  
  def update_password
    # Only reached if reverification passed
  end
  
  # Or with custom preset
  def delete_account
    require_reverification!(Clerk::StepUp::Preset::STRICT_MFA) do |preset|
      # Custom handling when reverification is needed
      render json: { error: 'Please re-authenticate' }, status: 403
    end
  end
end
```

### Sinatra Usage

```ruby
class App < Sinatra::Base
  register Sinatra::Clerk
  
  before '/admin/*' do
    require_reverification!(Clerk::StepUp::Preset::STRICT)
  end
  
  # Or using route condition
  post '/delete-account', reverify: Clerk::StepUp::Preset::STRICT_MFA do
    # Handle deletion
  end
end
```

### Rack Middleware

```ruby
use Clerk::Rack::Reverification,
    preset: Clerk::StepUp::Preset::MODERATE,
    routes: ['/settings/*', '/billing/*']
```

### Manual Check

```ruby
if clerk.user_needs_reverification?(Clerk::StepUp::Preset::STRICT)
  # User needs to re-authenticate
end

# Check if user has passed reverification
if clerk.user_reverified?(level: :second_factor, after_minutes: 10)
  # User has recently verified
end
```

<!-- No SDK Installation [installation] -->
<!-- No SDK Example Usage [usage] -->
<!-- No Authentication [security] -->

<!-- Start Available Resources and Operations [operations] -->
## Available Resources and Operations

<details open>
<summary>Available methods</summary>

### [ActorTokens](docs/sdks/actortokens/README.md)

* [create](docs/sdks/actortokens/README.md#create) - Create actor token
* [revoke](docs/sdks/actortokens/README.md#revoke) - Revoke actor token

### [AllowlistIdentifiers](docs/sdks/allowlistidentifiers/README.md)

* [list](docs/sdks/allowlistidentifiers/README.md#list) - List all identifiers on the allow-list
* [create](docs/sdks/allowlistidentifiers/README.md#create) - Add identifier to the allow-list
* [delete](docs/sdks/allowlistidentifiers/README.md#delete) - Delete identifier from allow-list

### [APIKeys](docs/sdks/apikeys/README.md)

* [create_api_key](docs/sdks/apikeys/README.md#create_api_key) - Create an API Key
* [get_api_keys](docs/sdks/apikeys/README.md#get_api_keys) - Get API Keys
* [get_api_key](docs/sdks/apikeys/README.md#get_api_key) - Get an API Key by ID
* [update_api_key](docs/sdks/apikeys/README.md#update_api_key) - Update an API Key
* [delete_api_key](docs/sdks/apikeys/README.md#delete_api_key) - Delete an API Key
* [get_api_key_secret](docs/sdks/apikeys/README.md#get_api_key_secret) - Get an API Key Secret
* [revoke_api_key](docs/sdks/apikeys/README.md#revoke_api_key) - Revoke an API Key
* [verify_api_key](docs/sdks/apikeys/README.md#verify_api_key) - Verify an API Key

### [BetaFeatures](docs/sdks/betafeatures/README.md)

* [update_instance_settings](docs/sdks/betafeatures/README.md#update_instance_settings) - Update instance settings
* [~~update_production_instance_domain~~](docs/sdks/betafeatures/README.md#update_production_instance_domain) - Update production instance domain :warning: **Deprecated**

### [Billing](docs/sdks/billing/README.md)

* [list_plans](docs/sdks/billing/README.md#list_plans) - List all billing plans
* [list_subscription_items](docs/sdks/billing/README.md#list_subscription_items) - List all subscription items
* [cancel_subscription_item](docs/sdks/billing/README.md#cancel_subscription_item) - Cancel a subscription item
* [extend_subscription_item_free_trial](docs/sdks/billing/README.md#extend_subscription_item_free_trial) - Extend free trial for a subscription item
* [create_price_transition](docs/sdks/billing/README.md#create_price_transition) - Create a price transition for a subscription item
* [list_statements](docs/sdks/billing/README.md#list_statements) - List all billing statements
* [get_statement](docs/sdks/billing/README.md#get_statement) - Retrieve a billing statement
* [get_statement_payment_attempts](docs/sdks/billing/README.md#get_statement_payment_attempts) - List payment attempts for a billing statement

### [BlocklistIdentifiers](docs/sdks/blocklistidentifiers/README.md)

* [list](docs/sdks/blocklistidentifiers/README.md#list) - List all identifiers on the block-list
* [create](docs/sdks/blocklistidentifiers/README.md#create) - Add identifier to the block-list
* [delete](docs/sdks/blocklistidentifiers/README.md#delete) - Delete identifier from block-list

### [Clients](docs/sdks/clients/README.md)

* [~~list~~](docs/sdks/clients/README.md#list) - List all clients :warning: **Deprecated**
* [verify](docs/sdks/clients/README.md#verify) - Verify a client
* [get](docs/sdks/clients/README.md#get) - Get a client

### [Domains](docs/sdks/domains/README.md)

* [list](docs/sdks/domains/README.md#list) - List all instance domains
* [add](docs/sdks/domains/README.md#add) - Add a domain
* [delete](docs/sdks/domains/README.md#delete) - Delete a satellite domain
* [update](docs/sdks/domains/README.md#update) - Update a domain

### [EmailAddresses](docs/sdks/emailaddresses/README.md)

* [create](docs/sdks/emailaddresses/README.md#create) - Create an email address
* [get](docs/sdks/emailaddresses/README.md#get) - Retrieve an email address
* [delete](docs/sdks/emailaddresses/README.md#delete) - Delete an email address
* [update](docs/sdks/emailaddresses/README.md#update) - Update an email address

### [~~EmailAndSmsTemplates~~](docs/sdks/emailandsmstemplates/README.md)

* [~~upsert~~](docs/sdks/emailandsmstemplates/README.md#upsert) - Update a template for a given type and slug :warning: **Deprecated**

### [~~EmailSMSTemplates~~](docs/sdks/emailsmstemplates/README.md)

* [~~list~~](docs/sdks/emailsmstemplates/README.md#list) - List all templates :warning: **Deprecated**
* [~~get~~](docs/sdks/emailsmstemplates/README.md#get) - Retrieve a template :warning: **Deprecated**
* [~~revert~~](docs/sdks/emailsmstemplates/README.md#revert) - Revert a template :warning: **Deprecated**
* [~~toggle_template_delivery~~](docs/sdks/emailsmstemplates/README.md#toggle_template_delivery) - Toggle the delivery by Clerk for a template of a given type and slug :warning: **Deprecated**

### [InstanceSettings](docs/sdks/instancesettings/README.md)

* [get](docs/sdks/instancesettings/README.md#get) - Fetch the current instance
* [update](docs/sdks/instancesettings/README.md#update) - Update instance settings
* [update_restrictions](docs/sdks/instancesettings/README.md#update_restrictions) - Update instance restrictions
* [change_domain](docs/sdks/instancesettings/README.md#change_domain) - Update production instance domain
* [update_organization_settings](docs/sdks/instancesettings/README.md#update_organization_settings) - Update instance organization settings
* [get_instance_protect](docs/sdks/instancesettings/README.md#get_instance_protect) - Get instance protect settings
* [update_instance_protect](docs/sdks/instancesettings/README.md#update_instance_protect) - Update instance protect settings

### [Invitations](docs/sdks/invitations/README.md)

* [create](docs/sdks/invitations/README.md#create) - Create an invitation
* [list](docs/sdks/invitations/README.md#list) - List all invitations
* [bulk_create](docs/sdks/invitations/README.md#bulk_create) - Create multiple invitations
* [revoke](docs/sdks/invitations/README.md#revoke) - Revokes an invitation

### [Jwks](docs/sdks/jwks/README.md)

* [get_jwks](docs/sdks/jwks/README.md#get_jwks) - Retrieve the JSON Web Key Set of the instance

### [JwtTemplates](docs/sdks/jwttemplates/README.md)

* [list](docs/sdks/jwttemplates/README.md#list) - List all templates
* [create](docs/sdks/jwttemplates/README.md#create) - Create a JWT template
* [get](docs/sdks/jwttemplates/README.md#get) - Retrieve a template
* [update](docs/sdks/jwttemplates/README.md#update) - Update a JWT template
* [delete](docs/sdks/jwttemplates/README.md#delete) - Delete a Template

### [M2m](docs/sdks/m2m/README.md)

* [create_token](docs/sdks/m2m/README.md#create_token) - Create a M2M Token
* [list_tokens](docs/sdks/m2m/README.md#list_tokens) - Get M2M Tokens
* [revoke_token](docs/sdks/m2m/README.md#revoke_token) - Revoke a M2M Token
* [verify_token](docs/sdks/m2m/README.md#verify_token) - Verify a M2M Token

### [Machines](docs/sdks/machines/README.md)

* [list](docs/sdks/machines/README.md#list) - Get a list of machines for an instance
* [create](docs/sdks/machines/README.md#create) - Create a machine
* [get](docs/sdks/machines/README.md#get) - Retrieve a machine
* [update](docs/sdks/machines/README.md#update) - Update a machine
* [delete](docs/sdks/machines/README.md#delete) - Delete a machine
* [get_secret_key](docs/sdks/machines/README.md#get_secret_key) - Retrieve a machine secret key
* [rotate_secret_key](docs/sdks/machines/README.md#rotate_secret_key) - Rotate a machine's secret key
* [create_scope](docs/sdks/machines/README.md#create_scope) - Create a machine scope
* [delete_scope](docs/sdks/machines/README.md#delete_scope) - Delete a machine scope

### [Miscellaneous](docs/sdks/miscellaneous/README.md)

* [get_public_interstitial](docs/sdks/miscellaneous/README.md#get_public_interstitial) - Returns the markup for the interstitial page

### [OauthAccessTokens](docs/sdks/oauthaccesstokens/README.md)

* [verify](docs/sdks/oauthaccesstokens/README.md#verify) - Verify an OAuth Access Token

### [OauthApplications](docs/sdks/oauthapplications/README.md)

* [list](docs/sdks/oauthapplications/README.md#list) - Get a list of OAuth applications for an instance
* [create](docs/sdks/oauthapplications/README.md#create) - Create an OAuth application
* [get](docs/sdks/oauthapplications/README.md#get) - Retrieve an OAuth application by ID
* [update](docs/sdks/oauthapplications/README.md#update) - Update an OAuth application
* [delete](docs/sdks/oauthapplications/README.md#delete) - Delete an OAuth application
* [rotate_secret](docs/sdks/oauthapplications/README.md#rotate_secret) - Rotate the client secret of the given OAuth application

### [OrganizationDomains](docs/sdks/organizationdomains/README.md)

* [create](docs/sdks/organizationdomains/README.md#create) - Create a new organization domain.
* [list](docs/sdks/organizationdomains/README.md#list) - Get a list of all domains of an organization.
* [update](docs/sdks/organizationdomains/README.md#update) - Update an organization domain.
* [delete](docs/sdks/organizationdomains/README.md#delete) - Remove a domain from an organization.
* [list_all](docs/sdks/organizationdomains/README.md#list_all) - List all organization domains

### [OrganizationInvitations](docs/sdks/organizationinvitations/README.md)

* [get_all](docs/sdks/organizationinvitations/README.md#get_all) - Get a list of organization invitations for the current instance
* [create](docs/sdks/organizationinvitations/README.md#create) - Create and send an organization invitation
* [list](docs/sdks/organizationinvitations/README.md#list) - Get a list of organization invitations
* [bulk_create](docs/sdks/organizationinvitations/README.md#bulk_create) - Bulk create and send organization invitations
* [~~list_pending~~](docs/sdks/organizationinvitations/README.md#list_pending) - Get a list of pending organization invitations :warning: **Deprecated**
* [get](docs/sdks/organizationinvitations/README.md#get) - Retrieve an organization invitation by ID
* [revoke](docs/sdks/organizationinvitations/README.md#revoke) - Revoke a pending organization invitation

### [OrganizationMemberships](docs/sdks/organizationmemberships/README.md)

* [create](docs/sdks/organizationmemberships/README.md#create) - Create a new organization membership
* [list](docs/sdks/organizationmemberships/README.md#list) - Get a list of all members of an organization
* [update](docs/sdks/organizationmemberships/README.md#update) - Update an organization membership
* [delete](docs/sdks/organizationmemberships/README.md#delete) - Remove a member from an organization
* [update_metadata](docs/sdks/organizationmemberships/README.md#update_metadata) - Merge and update organization membership metadata

### [OrganizationPermissions](docs/sdks/organizationpermissions/README.md)

* [list](docs/sdks/organizationpermissions/README.md#list) - Get a list of all organization permissions
* [create](docs/sdks/organizationpermissions/README.md#create) - Create a new organization permission
* [get](docs/sdks/organizationpermissions/README.md#get) - Get an organization permission
* [update](docs/sdks/organizationpermissions/README.md#update) - Update an organization permission
* [delete](docs/sdks/organizationpermissions/README.md#delete) - Delete an organization permission

### [OrganizationRoles](docs/sdks/organizationroles/README.md)

* [list](docs/sdks/organizationroles/README.md#list) - Get a list of organization roles
* [create](docs/sdks/organizationroles/README.md#create) - Create an organization role
* [get](docs/sdks/organizationroles/README.md#get) - Retrieve an organization role
* [update](docs/sdks/organizationroles/README.md#update) - Update an organization role
* [delete](docs/sdks/organizationroles/README.md#delete) - Delete an organization role
* [assign_permission](docs/sdks/organizationroles/README.md#assign_permission) - Assign a permission to an organization role
* [remove_permission](docs/sdks/organizationroles/README.md#remove_permission) - Remove a permission from an organization role

### [Organizations](docs/sdks/organizations/README.md)

* [list](docs/sdks/organizations/README.md#list) - Get a list of organizations for an instance
* [create](docs/sdks/organizations/README.md#create) - Create an organization
* [get](docs/sdks/organizations/README.md#get) - Retrieve an organization by ID or slug
* [update](docs/sdks/organizations/README.md#update) - Update an organization
* [delete](docs/sdks/organizations/README.md#delete) - Delete an organization
* [merge_metadata](docs/sdks/organizations/README.md#merge_metadata) - Merge and update metadata for an organization
* [upload_logo](docs/sdks/organizations/README.md#upload_logo) - Upload a logo for the organization
* [delete_logo](docs/sdks/organizations/README.md#delete_logo) - Delete the organization's logo.
* [get_billing_subscription](docs/sdks/organizations/README.md#get_billing_subscription) - Retrieve an organization's billing subscription

### [PhoneNumbers](docs/sdks/phonenumbers/README.md)

* [create](docs/sdks/phonenumbers/README.md#create) - Create a phone number
* [get](docs/sdks/phonenumbers/README.md#get) - Retrieve a phone number
* [delete](docs/sdks/phonenumbers/README.md#delete) - Delete a phone number
* [update](docs/sdks/phonenumbers/README.md#update) - Update a phone number

### [ProxyChecks](docs/sdks/proxychecks/README.md)

* [verify](docs/sdks/proxychecks/README.md#verify) - Verify the proxy configuration for your domain

### [RedirectUrls](docs/sdks/redirecturls/README.md)

* [list](docs/sdks/redirecturls/README.md#list) - List all redirect URLs
* [create](docs/sdks/redirecturls/README.md#create) - Create a redirect URL
* [get](docs/sdks/redirecturls/README.md#get) - Retrieve a redirect URL
* [delete](docs/sdks/redirecturls/README.md#delete) - Delete a redirect URL

### [RoleSets](docs/sdks/rolesets/README.md)

* [list](docs/sdks/rolesets/README.md#list) - Get a list of role sets
* [create](docs/sdks/rolesets/README.md#create) - Create a role set
* [get](docs/sdks/rolesets/README.md#get) - Retrieve a role set
* [update](docs/sdks/rolesets/README.md#update) - Update a role set
* [replace](docs/sdks/rolesets/README.md#replace) - Replace a role set
* [add_roles](docs/sdks/rolesets/README.md#add_roles) - Add roles to a role set
* [replace_role](docs/sdks/rolesets/README.md#replace_role) - Replace a role in a role set

### [SamlConnections](docs/sdks/samlconnections/README.md)

* [list](docs/sdks/samlconnections/README.md#list) - Get a list of SAML Connections for an instance
* [create](docs/sdks/samlconnections/README.md#create) - Create a SAML Connection
* [get](docs/sdks/samlconnections/README.md#get) - Retrieve a SAML Connection by ID
* [update](docs/sdks/samlconnections/README.md#update) - Update a SAML Connection
* [delete](docs/sdks/samlconnections/README.md#delete) - Delete a SAML Connection

### [Sessions](docs/sdks/sessions/README.md)

* [list](docs/sdks/sessions/README.md#list) - List all sessions
* [create](docs/sdks/sessions/README.md#create) - Create a new active session
* [get](docs/sdks/sessions/README.md#get) - Retrieve a session
* [refresh](docs/sdks/sessions/README.md#refresh) - Refresh a session
* [revoke](docs/sdks/sessions/README.md#revoke) - Revoke a session
* [create_token](docs/sdks/sessions/README.md#create_token) - Create a session token
* [create_token_from_template](docs/sdks/sessions/README.md#create_token_from_template) - Create a session token from a JWT template

### [SignInTokens](docs/sdks/signintokens/README.md)

* [create](docs/sdks/signintokens/README.md#create) - Create sign-in token
* [revoke](docs/sdks/signintokens/README.md#revoke) - Revoke the given sign-in token

### [SignUps](docs/sdks/signups/README.md)

* [get](docs/sdks/signups/README.md#get) - Retrieve a sign-up by ID
* [update](docs/sdks/signups/README.md#update) - Update a sign-up

### [~~Templates~~](docs/sdks/templates/README.md)

* [~~preview~~](docs/sdks/templates/README.md#preview) - Preview changes to a template :warning: **Deprecated**

### [TestingTokens](docs/sdks/testingtokens/README.md)

* [create](docs/sdks/testingtokens/README.md#create) - Retrieve a new testing token

### [Users](docs/sdks/users/README.md)

* [list](docs/sdks/users/README.md#list) - List all users
* [create](docs/sdks/users/README.md#create) - Create a new user
* [count](docs/sdks/users/README.md#count) - Count users
* [get](docs/sdks/users/README.md#get) - Retrieve a user
* [update](docs/sdks/users/README.md#update) - Update a user
* [delete](docs/sdks/users/README.md#delete) - Delete a user
* [ban](docs/sdks/users/README.md#ban) - Ban a user
* [unban](docs/sdks/users/README.md#unban) - Unban a user
* [bulk_ban](docs/sdks/users/README.md#bulk_ban) - Ban multiple users
* [bulk_unban](docs/sdks/users/README.md#bulk_unban) - Unban multiple users
* [lock](docs/sdks/users/README.md#lock) - Lock a user
* [unlock](docs/sdks/users/README.md#unlock) - Unlock a user
* [set_profile_image](docs/sdks/users/README.md#set_profile_image) - Set user profile image
* [delete_profile_image](docs/sdks/users/README.md#delete_profile_image) - Delete user profile image
* [update_metadata](docs/sdks/users/README.md#update_metadata) - Merge and update a user's metadata
* [get_billing_subscription](docs/sdks/users/README.md#get_billing_subscription) - Retrieve a user's billing subscription
* [get_o_auth_access_token](docs/sdks/users/README.md#get_o_auth_access_token) - Retrieve the OAuth access token of a user
* [get_organization_memberships](docs/sdks/users/README.md#get_organization_memberships) - Retrieve all memberships for a user
* [get_organization_invitations](docs/sdks/users/README.md#get_organization_invitations) - Retrieve all invitations for a user
* [verify_password](docs/sdks/users/README.md#verify_password) - Verify the password of a user
* [verify_totp](docs/sdks/users/README.md#verify_totp) - Verify a TOTP or backup code for a user
* [disable_mfa](docs/sdks/users/README.md#disable_mfa) - Disable a user's MFA methods
* [delete_backup_codes](docs/sdks/users/README.md#delete_backup_codes) - Disable all user's Backup codes
* [delete_passkey](docs/sdks/users/README.md#delete_passkey) - Delete a user passkey
* [delete_web3_wallet](docs/sdks/users/README.md#delete_web3_wallet) - Delete a user web3 wallet
* [delete_totp](docs/sdks/users/README.md#delete_totp) - Delete all the user's TOTPs
* [delete_external_account](docs/sdks/users/README.md#delete_external_account) - Delete External Account
* [set_password_compromised](docs/sdks/users/README.md#set_password_compromised) - Set a user's password as compromised
* [unset_password_compromised](docs/sdks/users/README.md#unset_password_compromised) - Unset a user's password as compromised
* [get_instance_organization_memberships](docs/sdks/users/README.md#get_instance_organization_memberships) - Get a list of all organization memberships within an instance.

### [WaitlistEntries](docs/sdks/waitlistentries/README.md)

* [list](docs/sdks/waitlistentries/README.md#list) - List all waitlist entries
* [create](docs/sdks/waitlistentries/README.md#create) - Create a waitlist entry
* [delete](docs/sdks/waitlistentries/README.md#delete) - Delete a pending waitlist entry
* [invite](docs/sdks/waitlistentries/README.md#invite) - Invite a waitlist entry
* [reject](docs/sdks/waitlistentries/README.md#reject) - Reject a waitlist entry

### [Webhooks](docs/sdks/webhooks/README.md)

* [create_svix_app](docs/sdks/webhooks/README.md#create_svix_app) - Create a Svix app
* [delete_svix_app](docs/sdks/webhooks/README.md#delete_svix_app) - Delete a Svix app
* [generate_svix_auth_url](docs/sdks/webhooks/README.md#generate_svix_auth_url) - Create a Svix Dashboard URL

</details>
<!-- End Available Resources and Operations [operations] -->

<!-- No Retries [retries] -->

<!-- Start Error Handling [errors] -->
## Error Handling

Handling errors in this SDK should largely match your expectations. All operations return a response object or raise an error.

By default an API error will raise a `Errors::APIError`, which has the following properties:

| Property       | Type                                    | Description           |
|----------------|-----------------------------------------|-----------------------|
| `message`     | *string*                                 | The error message     |
| `status_code`  | *int*                                   | The HTTP status code  |
| `raw_response` | *Faraday::Response*                     | The raw HTTP response |
| `body`        | *string*                                 | The response content  |

When custom error responses are specified for an operation, the SDK may also throw their associated exception. You can refer to respective *Errors* tables in SDK docs for more details on possible exception types for each operation. For example, the `verify` method throws the following exceptions:

| Error Type                  | Status Code   | Content Type     |
| --------------------------- | ------------- | ---------------- |
| Models::Errors::ClerkErrors | 400, 401, 404 | application/json |
| Errors::APIError            | 4XX, 5XX      | \*/\*            |

### Example

#### API Errors

```ruby
begin
  response = sdk.users.get(user_id: 'invalid')
rescue Clerk::Models::Errors::ClerkErrors => e
  # Clerk-specific errors (400, 401, 404)
  puts e.message
  puts e.raw_response.status
rescue Clerk::Errors::APIError => e
  # General API errors
  puts e.status_code
  puts e.body
end
```

#### Authentication Errors 

```ruby
rescue Clerk::AuthenticationError => e
  puts e.status  # HTTP status code
  puts e.message
rescue Clerk::ConfigurationError => e
  # Missing or invalid configuration
  puts e.message
end
```

#### JWT Errors

```ruby
begin
  claims = sdk.verify_token(token)
rescue JWT::ExpiredSignature
  # Token has expired
rescue JWT::InvalidIatError
  # Token not yet active
rescue JWT::DecodeError
  # Malformed or invalid token
end
```

<!-- No Error Handling [errors] -->
<!-- No Server Selection [server] -->

<!-- Placeholder for Future Speakeasy SDK Sections -->

# Development

## Maturity

This SDK is in beta, and there may be breaking changes between versions without a major version update. Therefore, we recommend pinning usage
to a specific package version. This way, you can install the same version each time without breaking changes unless you are intentionally
looking for the latest version.

## Contributions

While we value open-source contributions to this SDK, this library is generated programmatically. Any manual changes added to internal files will be overwritten on the next generation. 
We look forward to hearing your feedback. Feel free to open a PR or an issue with a proof of concept and we'll do our best to include it in a future release. 

### SDK Created by [Speakeasy](https://www.speakeasy.com/?utm_source=clerk-sdk-ruby&utm_campaign=ruby)
