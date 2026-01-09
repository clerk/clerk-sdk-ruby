# InstanceSettings

## Overview

### Available Operations

* [get](#get) - Fetch the current instance
* [update](#update) - Update instance settings
* [update_restrictions](#update_restrictions) - Update instance restrictions
* [change_domain](#change_domain) - Update production instance domain
* [update_organization_settings](#update_organization_settings) - Update instance organization settings

## get

Fetches the current instance

### Example Usage

<!-- UsageSnippet language="ruby" operationID="GetInstance" method="get" path="/instance" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.instance_settings.get()

unless res.instance.nil?
  # handle response
end

```

### Response

**[Crystalline::Nilable.new(Models::Operations::GetInstanceResponse)](../../models/operations/getinstanceresponse.md)**

### Errors

| Error Type       | Status Code      | Content Type     |
| ---------------- | ---------------- | ---------------- |
| Errors::APIError | 4XX, 5XX         | \*/\*            |

## update

Updates the settings of an instance

### Example Usage

<!-- UsageSnippet language="ruby" operationID="UpdateInstance" method="patch" path="/instance" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

req = Models::Operations::UpdateInstanceRequest.new(
  test_mode: true,
  hibp: false,
  support_email: 'support@example.com',
  clerk_js_version: '2.3.1',
  development_origin: 'http://localhost:3000',
  allowed_origins: [
    'http://localhost:3000',
    'chrome-extension://extension_uiid',
    'capacitor://localhost',
  ],
  url_based_session_syncing: true,
)

res = s.instance_settings.update(request: req)

if res.status_code == 200
  # handle response
end

```

### Parameters

| Parameter                                                                                     | Type                                                                                          | Required                                                                                      | Description                                                                                   |
| --------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------- |
| `request`                                                                                     | [Models::Operations::UpdateInstanceRequest](../../models/operations/updateinstancerequest.md) | :heavy_check_mark:                                                                            | The request object to use for the request.                                                    |

### Response

**[Crystalline::Nilable.new(Models::Operations::UpdateInstanceResponse)](../../models/operations/updateinstanceresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 422                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## update_restrictions

Updates the restriction settings of an instance

### Example Usage

<!-- UsageSnippet language="ruby" operationID="UpdateInstanceRestrictions" method="patch" path="/instance/restrictions" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

req = Models::Operations::UpdateInstanceRestrictionsRequest.new(
  allowlist: false,
  blocklist: true,
  block_email_subaddresses: true,
  block_disposable_email_domains: true,
)

res = s.instance_settings.update_restrictions(request: req)

unless res.instance_restrictions.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                             | Type                                                                                                                  | Required                                                                                                              | Description                                                                                                           |
| --------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------- |
| `request`                                                                                                             | [Models::Operations::UpdateInstanceRestrictionsRequest](../../models/operations/updateinstancerestrictionsrequest.md) | :heavy_check_mark:                                                                                                    | The request object to use for the request.                                                                            |

### Response

**[Crystalline::Nilable.new(Models::Operations::UpdateInstanceRestrictionsResponse)](../../models/operations/updateinstancerestrictionsresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 402, 422                    | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## change_domain

Change the domain of a production instance.

Changing the domain requires updating the [DNS records](https://clerk.com/docs/deployments/overview#dns-records) accordingly, deploying new [SSL certificates](https://clerk.com/docs/deployments/overview#deploy-certificates), updating your Social Connection's redirect URLs and setting the new keys in your code.

WARNING: Changing your domain will invalidate all current user sessions (i.e. users will be logged out). Also, while your application is being deployed, a small downtime is expected to occur.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="ChangeProductionInstanceDomain" method="post" path="/instance/change_domain" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

req = Models::Operations::ChangeProductionInstanceDomainRequest.new(
  home_url: 'https://www.newdomain.com',
)

res = s.instance_settings.change_domain(request: req)

if res.status_code == 200
  # handle response
end

```

### Parameters

| Parameter                                                                                                                     | Type                                                                                                                          | Required                                                                                                                      | Description                                                                                                                   |
| ----------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------- |
| `request`                                                                                                                     | [Models::Operations::ChangeProductionInstanceDomainRequest](../../models/operations/changeproductioninstancedomainrequest.md) | :heavy_check_mark:                                                                                                            | The request object to use for the request.                                                                                    |

### Response

**[Crystalline::Nilable.new(Models::Operations::ChangeProductionInstanceDomainResponse)](../../models/operations/changeproductioninstancedomainresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 422                    | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## update_organization_settings

Updates the organization settings of the instance

### Example Usage

<!-- UsageSnippet language="ruby" operationID="UpdateInstanceOrganizationSettings" method="patch" path="/instance/organization_settings" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

req = Models::Operations::UpdateInstanceOrganizationSettingsRequest.new(
  enabled: true,
  max_allowed_memberships: 10,
  admin_delete_enabled: false,
  domains_enabled: true,
  domains_enrollment_modes: [
    'automatic_invitation',
    'automatic_suggestion',
  ],
  creator_role_id: 'creator_role',
  domains_default_role_id: 'member_role',
)

res = s.instance_settings.update_organization_settings(request: req)

unless res.organization_settings.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                                             | Type                                                                                                                                  | Required                                                                                                                              | Description                                                                                                                           |
| ------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------- |
| `request`                                                                                                                             | [Models::Operations::UpdateInstanceOrganizationSettingsRequest](../../models/operations/updateinstanceorganizationsettingsrequest.md) | :heavy_check_mark:                                                                                                                    | The request object to use for the request.                                                                                            |

### Response

**[Crystalline::Nilable.new(Models::Operations::UpdateInstanceOrganizationSettingsResponse)](../../models/operations/updateinstanceorganizationsettingsresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 402, 404, 422          | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |