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

<!-- Start Table of Contents [toc] -->
## Table of Contents
<!-- $toc-max-depth=2 -->
* [clerk-sdk-ruby](#clerk-sdk-ruby)
  * [SDK Installation](#sdk-installation)
  * [SDK Example Usage](#sdk-example-usage)
  * [Authentication](#authentication)
  * [Available Resources and Operations](#available-resources-and-operations)
  * [Retries](#retries)
  * [Error Handling](#error-handling)
  * [Server Selection](#server-selection)
* [Development](#development)
  * [Maturity](#maturity)
  * [Contributions](#contributions)

<!-- End Table of Contents [toc] -->

<!-- Start SDK Installation [installation] -->
## SDK Installation

The SDK can be installed using [RubyGems](https://rubygems.org/):

```bash
gem install clerk-sdk-ruby
```
<!-- End SDK Installation [installation] -->

<!-- Start SDK Example Usage [usage] -->
## SDK Example Usage

### Example

```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.email_addresses.get(email_address_id: 'email_address_id_example')

unless res.email_address.nil?
  # handle response
end

```
<!-- End SDK Example Usage [usage] -->

<!-- Start Authentication [security] -->
## Authentication

### Per-Client Security Schemes

This SDK supports the following security scheme globally:

| Name          | Type | Scheme      |
| ------------- | ---- | ----------- |
| `bearer_auth` | http | HTTP Bearer |

To authenticate with the API the `bearer_auth` parameter must be set when initializing the SDK client instance. For example:
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

req = Models::Operations::GetPublicInterstitialRequest.new(
  frontend_api_query_parameter1: 'pub_1a2b3c4d',
)

res = s.miscellaneous.get_public_interstitial(request: req)

if res.status_code == 200
  # handle response
end

```
<!-- End Authentication [security] -->

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
* [unset_password_compromised](docs/sdks/users/README.md#unset_password_compromised) - Unmark a user's password as compromised
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

<!-- Start Retries [retries] -->
## Retries

Some of the endpoints in this SDK support retries. If you use the SDK without any configuration, it will fall back to the default retry strategy provided by the API. However, the default retry strategy can be overridden on a per-operation basis, or across the entire SDK.

To change the default retry strategy for a single API call, simply provide a `RetryConfig` object to the call:
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new

req = Models::Operations::GetPublicInterstitialRequest.new(
  frontend_api_query_parameter1: 'pub_1a2b3c4d',
)

res = s.miscellaneous.get_public_interstitial(request: req)

if res.status_code == 200
  # handle response
end

```

If you'd like to override the default retry strategy for all operations that support retries, you can use the `retry_config` optional parameter when initializing the SDK:
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      retry_config: Utils::RetryConfig.new(
        backoff: Utils::BackoffStrategy.new(
          exponent: 1.1,
          initial_interval: 1,
          max_elapsed_time: 100,
          max_interval: 50
        ),
        retry_connection_errors: false,
        strategy: 'backoff'
      ),
    )

req = Models::Operations::GetPublicInterstitialRequest.new(
  frontend_api_query_parameter1: 'pub_1a2b3c4d',
)

res = s.miscellaneous.get_public_interstitial(request: req)

if res.status_code == 200
  # handle response
end

```
<!-- End Retries [retries] -->

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

```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

begin
    req = Models::Operations::VerifyClientRequest.new(
      token: 'jwt_token_example',
    )

    res = s.clients.verify(request: req)

    unless res.client.nil?
      # handle response
    end
rescue Models::Errors::ClerkErrors => e
  # handle e.container data
  raise e
rescue Errors::APIError => e
  # handle default exception
  raise e
end

```
<!-- End Error Handling [errors] -->

<!-- Start Server Selection [server] -->
## Server Selection

### Override Server URL Per-Client

The default server can be overridden globally by passing a URL to the `server_url (String)` optional parameter when initializing the SDK client instance. For example:
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      server_url: 'https://api.clerk.com/v1',
    )

req = Models::Operations::GetPublicInterstitialRequest.new(
  frontend_api_query_parameter1: 'pub_1a2b3c4d',
)

res = s.miscellaneous.get_public_interstitial(request: req)

if res.status_code == 200
  # handle response
end

```
<!-- End Server Selection [server] -->

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
