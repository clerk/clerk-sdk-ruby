# OauthApplications

## Overview

### Available Operations

* [list](#list) - Get a list of OAuth applications for an instance
* [create](#create) - Create an OAuth application
* [get](#get) - Retrieve an OAuth application by ID
* [update](#update) - Update an OAuth application
* [delete](#delete) - Delete an OAuth application
* [rotate_secret](#rotate_secret) - Rotate the client secret of the given OAuth application

## list

This request returns the list of OAuth applications for an instance.
Results can be paginated using the optional `limit` and `offset` query parameters.
The OAuth applications are ordered by descending creation date.
Most recent OAuth applications will be returned first.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="ListOAuthApplications" method="get" path="/oauth_applications" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.oauth_applications.list(limit: 10, offset: 0, order_by: '+created_at')

unless res.o_auth_applications.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            | Type                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 | Required                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `limit`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              | *Crystalline::Nilable.new(::Integer)*                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                | :heavy_minus_sign:                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   | Applies a limit to the number of results returned.<br/>Can be used for paginating the results together with `offset`.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| `offset`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             | *Crystalline::Nilable.new(::Integer)*                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                | :heavy_minus_sign:                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   | Skip the first `offset` results when paginating.<br/>Needs to be an integer greater or equal to zero.<br/>To be used in conjunction with `limit`.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| `order_by`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           | *Crystalline::Nilable.new(::String)*                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 | :heavy_minus_sign:                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   | Allows to return OAuth applications in a particular order.<br/>At the moment, you can order the returned OAuth applications by their `created_at` and `name`.<br/>In order to specify the direction, you can use the `+/-` symbols prepended in the property to order by.<br/>For example, if you want OAuth applications to be returned in descending order according to their `created_at` property, you can use `-created_at`.<br/>If you don't use `+` or `-`, then `+` is implied. We only support one `order_by` parameter, and if multiple `order_by` parameters are provided, we will only keep the first one. For example,<br/>if you pass `order_by=name&order_by=created_at`, we will consider only the first `order_by` parameter, which is `name`. The `created_at` parameter will be ignored in this case. |
| `name_query`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         | *Crystalline::Nilable.new(::String)*                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 | :heavy_minus_sign:                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   | Returns OAuth applications with names that match the given query, via case-insensitive partial match.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |

### Response

**[Crystalline::Nilable.new(Models::Operations::ListOAuthApplicationsResponse)](../../models/operations/listoauthapplicationsresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 403, 422               | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## create

Creates a new OAuth application with the given name and callback URL for an instance.
The callback URL must be a valid URL.
All URL schemes are allowed such as `http://`, `https://`, `myapp://`, etc...

### Example Usage

<!-- UsageSnippet language="ruby" operationID="CreateOAuthApplication" method="post" path="/oauth_applications" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

req = Models::Operations::CreateOAuthApplicationRequest.new(
  name: 'Example App',
  scopes: 'profile email public_metadata',
)

res = s.oauth_applications.create(request: req)

unless res.o_auth_application_with_secret.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                     | Type                                                                                                          | Required                                                                                                      | Description                                                                                                   |
| ------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------- |
| `request`                                                                                                     | [Models::Operations::CreateOAuthApplicationRequest](../../models/operations/createoauthapplicationrequest.md) | :heavy_check_mark:                                                                                            | The request object to use for the request.                                                                    |

### Response

**[Crystalline::Nilable.new(Models::Operations::CreateOAuthApplicationResponse)](../../models/operations/createoauthapplicationresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 403, 422               | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## get

Fetches the OAuth application whose ID matches the provided `id` in the path.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="GetOAuthApplication" method="get" path="/oauth_applications/{oauth_application_id}" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.oauth_applications.get(oauth_application_id: 'oauth_app_12345')

unless res.o_auth_application.nil?
  # handle response
end

```

### Parameters

| Parameter                       | Type                            | Required                        | Description                     |
| ------------------------------- | ------------------------------- | ------------------------------- | ------------------------------- |
| `oauth_application_id`          | *::String*                      | :heavy_check_mark:              | The ID of the OAuth application |

### Response

**[Crystalline::Nilable.new(Models::Operations::GetOAuthApplicationResponse)](../../models/operations/getoauthapplicationresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 403, 404                    | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## update

Updates an existing OAuth application

### Example Usage

<!-- UsageSnippet language="ruby" operationID="UpdateOAuthApplication" method="patch" path="/oauth_applications/{oauth_application_id}" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.oauth_applications.update(oauth_application_id: 'oauth_app_67890', body: Models::Operations::UpdateOAuthApplicationRequestBody.new(
  scopes: 'profile email public_metadata private_metadata',
))

unless res.o_auth_application.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                             | Type                                                                                                                  | Required                                                                                                              | Description                                                                                                           |
| --------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------- |
| `oauth_application_id`                                                                                                | *::String*                                                                                                            | :heavy_check_mark:                                                                                                    | The ID of the OAuth application to update                                                                             |
| `body`                                                                                                                | [Models::Operations::UpdateOAuthApplicationRequestBody](../../models/operations/updateoauthapplicationrequestbody.md) | :heavy_check_mark:                                                                                                    | N/A                                                                                                                   |

### Response

**[Crystalline::Nilable.new(Models::Operations::UpdateOAuthApplicationResponse)](../../models/operations/updateoauthapplicationresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 403, 404, 422          | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## delete

Deletes the given OAuth application.
This is not reversible.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="DeleteOAuthApplication" method="delete" path="/oauth_applications/{oauth_application_id}" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.oauth_applications.delete(oauth_application_id: 'oauth_app_09876')

unless res.deleted_object.nil?
  # handle response
end

```

### Parameters

| Parameter                                 | Type                                      | Required                                  | Description                               |
| ----------------------------------------- | ----------------------------------------- | ----------------------------------------- | ----------------------------------------- |
| `oauth_application_id`                    | *::String*                                | :heavy_check_mark:                        | The ID of the OAuth application to delete |

### Response

**[Crystalline::Nilable.new(Models::Operations::DeleteOAuthApplicationResponse)](../../models/operations/deleteoauthapplicationresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 403, 404                    | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## rotate_secret

Rotates the OAuth application's client secret.
When the client secret is rotated, make sure to update it in authorized OAuth clients.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="RotateOAuthApplicationSecret" method="post" path="/oauth_applications/{oauth_application_id}/rotate_secret" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.oauth_applications.rotate_secret(oauth_application_id: 'oauth_application_12345')

unless res.o_auth_application_with_secret.nil?
  # handle response
end

```

### Parameters

| Parameter                                                             | Type                                                                  | Required                                                              | Description                                                           |
| --------------------------------------------------------------------- | --------------------------------------------------------------------- | --------------------------------------------------------------------- | --------------------------------------------------------------------- |
| `oauth_application_id`                                                | *::String*                                                            | :heavy_check_mark:                                                    | The ID of the OAuth application for which to rotate the client secret |

### Response

**[Crystalline::Nilable.new(Models::Operations::RotateOAuthApplicationSecretResponse)](../../models/operations/rotateoauthapplicationsecretresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 403, 404                    | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |