# BlocklistIdentifiers

## Overview

### Available Operations

* [list](#list) - List all identifiers on the block-list
* [create](#create) - Add identifier to the block-list
* [delete](#delete) - Delete identifier from block-list

## list

Get a list of all identifiers which are not allowed to access an instance

### Example Usage

<!-- UsageSnippet language="ruby" operationID="ListBlocklistIdentifiers" method="get" path="/blocklist_identifiers" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.blocklist_identifiers.list()

unless res.blocklist_identifiers.nil?
  # handle response
end

```

### Response

**[Crystalline::Nilable.new(Models::Operations::ListBlocklistIdentifiersResponse)](../../models/operations/listblocklistidentifiersresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 401, 402                    | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## create

Create an identifier that is blocked from accessing an instance

### Example Usage

<!-- UsageSnippet language="ruby" operationID="CreateBlocklistIdentifier" method="post" path="/blocklist_identifiers" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

req = Models::Operations::CreateBlocklistIdentifierRequest.new(
  identifier: 'example@example.com',
)

res = s.blocklist_identifiers.create(request: req)

unless res.blocklist_identifier.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                           | Type                                                                                                                | Required                                                                                                            | Description                                                                                                         |
| ------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------- |
| `request`                                                                                                           | [Models::Operations::CreateBlocklistIdentifierRequest](../../models/operations/createblocklistidentifierrequest.md) | :heavy_check_mark:                                                                                                  | The request object to use for the request.                                                                          |

### Response

**[Crystalline::Nilable.new(Models::Operations::CreateBlocklistIdentifierResponse)](../../models/operations/createblocklistidentifierresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 402, 422               | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## delete

Delete an identifier from the instance block-list

### Example Usage

<!-- UsageSnippet language="ruby" operationID="DeleteBlocklistIdentifier" method="delete" path="/blocklist_identifiers/{identifier_id}" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.blocklist_identifiers.delete(identifier_id: 'identifier123')

unless res.deleted_object.nil?
  # handle response
end

```

### Parameters

| Parameter                                              | Type                                                   | Required                                               | Description                                            |
| ------------------------------------------------------ | ------------------------------------------------------ | ------------------------------------------------------ | ------------------------------------------------------ |
| `identifier_id`                                        | *::String*                                             | :heavy_check_mark:                                     | The ID of the identifier to delete from the block-list |

### Response

**[Crystalline::Nilable.new(Models::Operations::DeleteBlocklistIdentifierResponse)](../../models/operations/deleteblocklistidentifierresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 402, 404                    | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |