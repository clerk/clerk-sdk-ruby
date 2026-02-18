# BetaFeatures

## Overview

### Available Operations

* [update_instance_settings](#update_instance_settings) - Update instance settings
* [~~update_production_instance_domain~~](#update_production_instance_domain) - Update production instance domain :warning: **Deprecated**

## update_instance_settings

Updates the settings of an instance

### Example Usage

<!-- UsageSnippet language="ruby" operationID="UpdateInstanceAuthConfig" method="patch" path="/beta_features/instance_settings" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)

req = Models::Operations::UpdateInstanceAuthConfigRequest.new(
  from_email_address: 'noreply',
  progressive_sign_up: true,
  test_mode: true
)
res = s.beta_features.update_instance_settings(request: req)

unless res.instance_settings.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                         | Type                                                                                                              | Required                                                                                                          | Description                                                                                                       |
| ----------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------- |
| `request`                                                                                                         | [Models::Operations::UpdateInstanceAuthConfigRequest](../../models/operations/updateinstanceauthconfigrequest.md) | :heavy_check_mark:                                                                                                | The request object to use for the request.                                                                        |

### Response

**[Crystalline::Nilable.new(Models::Operations::UpdateInstanceAuthConfigResponse)](../../models/operations/updateinstanceauthconfigresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 402, 422                    | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## ~~update_production_instance_domain~~

Change the domain of a production instance.

Changing the domain requires updating the [DNS records](https://clerk.com/docs/deployments/overview#dns-records) accordingly, deploying new [SSL certificates](https://clerk.com/docs/deployments/overview#deploy-certificates), updating your Social Connection's redirect URLs and setting the new keys in your code.

WARNING: Changing your domain will invalidate all current user sessions (i.e. users will be logged out). Also, while your application is being deployed, a small downtime is expected to occur.

> :warning: **DEPRECATED**: This will be removed in a future release, please migrate away from it as soon as possible.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="UpdateProductionInstanceDomain" method="put" path="/beta_features/domain" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)

req = Models::Operations::UpdateProductionInstanceDomainRequest.new(
  home_url: 'https://www.example.com'
)
res = s.beta_features.update_production_instance_domain(request: req)

if res.status_code == 200
  # handle response
end

```

### Parameters

| Parameter                                                                                                                     | Type                                                                                                                          | Required                                                                                                                      | Description                                                                                                                   |
| ----------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------- |
| `request`                                                                                                                     | [Models::Operations::UpdateProductionInstanceDomainRequest](../../models/operations/updateproductioninstancedomainrequest.md) | :heavy_check_mark:                                                                                                            | The request object to use for the request.                                                                                    |

### Response

**[Crystalline::Nilable.new(Models::Operations::UpdateProductionInstanceDomainResponse)](../../models/operations/updateproductioninstancedomainresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 422                    | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |