# Webhooks

## Overview

### Available Operations

* [create_svix_app](#create_svix_app) - Create a Svix app
* [delete_svix_app](#delete_svix_app) - Delete a Svix app
* [generate_svix_auth_url](#generate_svix_auth_url) - Create a Svix Dashboard URL

## create_svix_app

Create a Svix app and associate it with the current instance

### Example Usage

<!-- UsageSnippet language="ruby" operationID="CreateSvixApp" method="post" path="/webhooks/svix" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.webhooks.create_svix_app()

unless res.svix_url.nil?
  # handle response
end

```

### Response

**[Crystalline::Nilable.new(Models::Operations::CreateSvixAppResponse)](../../models/operations/createsvixappresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## delete_svix_app

Delete a Svix app and disassociate it from the current instance

### Example Usage

<!-- UsageSnippet language="ruby" operationID="DeleteSvixApp" method="delete" path="/webhooks/svix" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.webhooks.delete_svix_app()

if res.status_code == 200
  # handle response
end

```

### Response

**[Crystalline::Nilable.new(Models::Operations::DeleteSvixAppResponse)](../../models/operations/deletesvixappresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## generate_svix_auth_url

Generate a new URL for accessing the Svix's management dashboard for that particular instance

### Example Usage

<!-- UsageSnippet language="ruby" operationID="GenerateSvixAuthURL" method="post" path="/webhooks/svix_url" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.webhooks.generate_svix_auth_url()

unless res.svix_url.nil?
  # handle response
end

```

### Response

**[Crystalline::Nilable.new(Models::Operations::GenerateSvixAuthURLResponse)](../../models/operations/generatesvixauthurlresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |