# RedirectUrls

## Overview

### Available Operations

* [list](#list) - List all redirect URLs
* [create](#create) - Create a redirect URL
* [get](#get) - Retrieve a redirect URL
* [delete](#delete) - Delete a redirect URL

## list

Lists all whitelisted redirect_urls for the instance

### Example Usage

<!-- UsageSnippet language="ruby" operationID="ListRedirectURLs" method="get" path="/redirect_urls" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.redirect_urls.list(limit: 10, offset: 0)

unless res.redirect_url_list.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                                                 | Type                                                                                                                                      | Required                                                                                                                                  | Description                                                                                                                               |
| ----------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------- |
| `paginated`                                                                                                                               | *Crystalline::Nilable.new(Crystalline::Boolean.new)*                                                                                      | :heavy_minus_sign:                                                                                                                        | Whether to paginate the results.<br/>If true, the results will be paginated.<br/>If false, the results will not be paginated.             |
| `limit`                                                                                                                                   | *Crystalline::Nilable.new(::Integer)*                                                                                                     | :heavy_minus_sign:                                                                                                                        | Applies a limit to the number of results returned.<br/>Can be used for paginating the results together with `offset`.                     |
| `offset`                                                                                                                                  | *Crystalline::Nilable.new(::Integer)*                                                                                                     | :heavy_minus_sign:                                                                                                                        | Skip the first `offset` results when paginating.<br/>Needs to be an integer greater or equal to zero.<br/>To be used in conjunction with `limit`. |

### Response

**[Crystalline::Nilable.new(Models::Operations::ListRedirectURLsResponse)](../../models/operations/listredirecturlsresponse.md)**

### Errors

| Error Type       | Status Code      | Content Type     |
| ---------------- | ---------------- | ---------------- |
| Errors::APIError | 4XX, 5XX         | \*/\*            |

## create

Create a redirect URL

### Example Usage

<!-- UsageSnippet language="ruby" operationID="CreateRedirectURL" method="post" path="/redirect_urls" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

req = Models::Operations::CreateRedirectURLRequest.new(
  url: 'https://my-app.com/oauth-callback',
)

res = s.redirect_urls.create(request: req)

unless res.redirect_url.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                           | Type                                                                                                | Required                                                                                            | Description                                                                                         |
| --------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------- |
| `request`                                                                                           | [Models::Operations::CreateRedirectURLRequest](../../models/operations/createredirecturlrequest.md) | :heavy_check_mark:                                                                                  | The request object to use for the request.                                                          |

### Response

**[Crystalline::Nilable.new(Models::Operations::CreateRedirectURLResponse)](../../models/operations/createredirecturlresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 422                    | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## get

Retrieve the details of the redirect URL with the given ID

### Example Usage

<!-- UsageSnippet language="ruby" operationID="GetRedirectURL" method="get" path="/redirect_urls/{id}" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.redirect_urls.get(id: 'redir_01FG4K9G5NWSQ4ZPT4TQE4Z7G3')

unless res.redirect_url.nil?
  # handle response
end

```

### Parameters

| Parameter                  | Type                       | Required                   | Description                |
| -------------------------- | -------------------------- | -------------------------- | -------------------------- |
| `id`                       | *::String*                 | :heavy_check_mark:         | The ID of the redirect URL |

### Response

**[Crystalline::Nilable.new(Models::Operations::GetRedirectURLResponse)](../../models/operations/getredirecturlresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 404                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## delete

Remove the selected redirect URL from the whitelist of the instance

### Example Usage

<!-- UsageSnippet language="ruby" operationID="DeleteRedirectURL" method="delete" path="/redirect_urls/{id}" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.redirect_urls.delete(id: 'redir_01FG4K9G5NWSQ4ZPT4TQE4Z7G3')

unless res.deleted_object.nil?
  # handle response
end

```

### Parameters

| Parameter                  | Type                       | Required                   | Description                |
| -------------------------- | -------------------------- | -------------------------- | -------------------------- |
| `id`                       | *::String*                 | :heavy_check_mark:         | The ID of the redirect URL |

### Response

**[Crystalline::Nilable.new(Models::Operations::DeleteRedirectURLResponse)](../../models/operations/deleteredirecturlresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 404                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |