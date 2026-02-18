# AllowlistIdentifiers

## Overview

### Available Operations

* [list](#list) - List all identifiers on the allow-list
* [create](#create) - Add identifier to the allow-list
* [delete](#delete) - Delete identifier from allow-list

## list

Get a list of all identifiers allowed to sign up to an instance

### Example Usage

<!-- UsageSnippet language="ruby" operationID="ListAllowlistIdentifiers" method="get" path="/allowlist_identifiers" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.allowlist_identifiers.list(limit: 10, offset: 0)

unless res.allowlist_identifier_list.nil?
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

**[Crystalline::Nilable.new(Models::Operations::ListAllowlistIdentifiersResponse)](../../models/operations/listallowlistidentifiersresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 401, 402                    | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## create

Create an identifier allowed to sign up to an instance

### Example Usage

<!-- UsageSnippet language="ruby" operationID="CreateAllowlistIdentifier" method="post" path="/allowlist_identifiers" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)

req = Models::Operations::CreateAllowlistIdentifierRequest.new(
  identifier: 'user@example.com',
  notify: true
)
res = s.allowlist_identifiers.create(request: req)

unless res.allowlist_identifier.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                           | Type                                                                                                                | Required                                                                                                            | Description                                                                                                         |
| ------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------- |
| `request`                                                                                                           | [Models::Operations::CreateAllowlistIdentifierRequest](../../models/operations/createallowlistidentifierrequest.md) | :heavy_check_mark:                                                                                                  | The request object to use for the request.                                                                          |

### Response

**[Crystalline::Nilable.new(Models::Operations::CreateAllowlistIdentifierResponse)](../../models/operations/createallowlistidentifierresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 402, 422               | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## delete

Delete an identifier from the instance allow-list

### Example Usage

<!-- UsageSnippet language="ruby" operationID="DeleteAllowlistIdentifier" method="delete" path="/allowlist_identifiers/{identifier_id}" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.allowlist_identifiers.delete(identifier_id: 'example_identifier_id')

unless res.deleted_object.nil?
  # handle response
end

```

### Parameters

| Parameter                                              | Type                                                   | Required                                               | Description                                            |
| ------------------------------------------------------ | ------------------------------------------------------ | ------------------------------------------------------ | ------------------------------------------------------ |
| `identifier_id`                                        | *::String*                                             | :heavy_check_mark:                                     | The ID of the identifier to delete from the allow-list |

### Response

**[Crystalline::Nilable.new(Models::Operations::DeleteAllowlistIdentifierResponse)](../../models/operations/deleteallowlistidentifierresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 402, 404                    | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |