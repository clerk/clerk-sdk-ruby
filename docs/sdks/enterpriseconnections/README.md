# EnterpriseConnections

## Overview

### Available Operations

* [list](#list) - List enterprise connections
* [create](#create) - Create an enterprise connection
* [get](#get) - Retrieve an enterprise connection
* [update](#update) - Update an enterprise connection
* [delete](#delete) - Delete an enterprise connection

## list

Returns the list of enterprise connections for the instance.
Results can be paginated using the optional `limit` and `offset` query parameters.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="ListEnterpriseConnections" method="get" path="/enterprise_connections" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.enterprise_connections.list(limit: 10, offset: 0)

unless res.enterprise_connections.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                                                                           | Type                                                                                                                                                                | Required                                                                                                                                                            | Description                                                                                                                                                         |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `limit`                                                                                                                                                             | *Crystalline::Nilable.new(::Integer)*                                                                                                                               | :heavy_minus_sign:                                                                                                                                                  | Applies a limit to the number of results returned.<br/>Can be used for paginating the results together with `offset`.                                               |
| `offset`                                                                                                                                                            | *Crystalline::Nilable.new(::Integer)*                                                                                                                               | :heavy_minus_sign:                                                                                                                                                  | Skip the first `offset` results when paginating.<br/>Needs to be an integer greater or equal to zero.<br/>To be used in conjunction with `limit`.                   |
| `organization_id`                                                                                                                                                   | *Crystalline::Nilable.new(::String)*                                                                                                                                | :heavy_minus_sign:                                                                                                                                                  | Filter enterprise connections by organization ID                                                                                                                    |
| `active`                                                                                                                                                            | *Crystalline::Nilable.new(Crystalline::Boolean.new)*                                                                                                                | :heavy_minus_sign:                                                                                                                                                  | Filter by active status. If true, only active connections are returned. If false, only inactive connections are returned. If omitted, all connections are returned. |

### Response

**[Crystalline::Nilable.new(Models::Operations::ListEnterpriseConnectionsResponse)](../../models/operations/listenterpriseconnectionsresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 402, 403, 422               | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## create

Create a new enterprise connection.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="CreateEnterpriseConnection" method="post" path="/enterprise_connections" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)

req = nil
res = s.enterprise_connections.create(request: req)

unless res.enterprise_connection.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                             | Type                                                                                                                  | Required                                                                                                              | Description                                                                                                           |
| --------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------- |
| `request`                                                                                                             | [Models::Operations::CreateEnterpriseConnectionRequest](../../models/operations/createenterpriseconnectionrequest.md) | :heavy_check_mark:                                                                                                    | The request object to use for the request.                                                                            |

### Response

**[Crystalline::Nilable.new(Models::Operations::CreateEnterpriseConnectionResponse)](../../models/operations/createenterpriseconnectionresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 402, 403, 404, 409, 422     | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## get

Fetches the enterprise connection whose ID matches the provided `enterprise_connection_id` in the path.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="GetEnterpriseConnection" method="get" path="/enterprise_connections/{enterprise_connection_id}" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.enterprise_connections.get(enterprise_connection_id: '<id>')

unless res.enterprise_connection.nil?
  # handle response
end

```

### Parameters

| Parameter                           | Type                                | Required                            | Description                         |
| ----------------------------------- | ----------------------------------- | ----------------------------------- | ----------------------------------- |
| `enterprise_connection_id`          | *::String*                          | :heavy_check_mark:                  | The ID of the enterprise connection |

### Response

**[Crystalline::Nilable.new(Models::Operations::GetEnterpriseConnectionResponse)](../../models/operations/getenterpriseconnectionresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 402, 403, 404               | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## update

Updates the enterprise connection whose ID matches the provided `enterprise_connection_id` in the path.
When enabling the connection (setting `active` to true), any existing verified organization domains that match the connection's domains (e.g. used for enrollment modes like automatic invitation) may be deleted so the connection can be enabled.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="UpdateEnterpriseConnection" method="patch" path="/enterprise_connections/{enterprise_connection_id}" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.enterprise_connections.update(enterprise_connection_id: '<id>', body: Models::Operations::UpdateEnterpriseConnectionRequestBody.new)

unless res.enterprise_connection.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                                     | Type                                                                                                                          | Required                                                                                                                      | Description                                                                                                                   |
| ----------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------- |
| `enterprise_connection_id`                                                                                                    | *::String*                                                                                                                    | :heavy_check_mark:                                                                                                            | The ID of the enterprise connection to update                                                                                 |
| `body`                                                                                                                        | [Models::Operations::UpdateEnterpriseConnectionRequestBody](../../models/operations/updateenterpriseconnectionrequestbody.md) | :heavy_check_mark:                                                                                                            | N/A                                                                                                                           |

### Response

**[Crystalline::Nilable.new(Models::Operations::UpdateEnterpriseConnectionResponse)](../../models/operations/updateenterpriseconnectionresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 402, 403, 404, 422     | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## delete

Deletes the enterprise connection whose ID matches the provided `enterprise_connection_id` in the path.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="DeleteEnterpriseConnection" method="delete" path="/enterprise_connections/{enterprise_connection_id}" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.enterprise_connections.delete(enterprise_connection_id: '<id>')

unless res.deleted_object.nil?
  # handle response
end

```

### Parameters

| Parameter                                     | Type                                          | Required                                      | Description                                   |
| --------------------------------------------- | --------------------------------------------- | --------------------------------------------- | --------------------------------------------- |
| `enterprise_connection_id`                    | *::String*                                    | :heavy_check_mark:                            | The ID of the enterprise connection to delete |

### Response

**[Crystalline::Nilable.new(Models::Operations::DeleteEnterpriseConnectionResponse)](../../models/operations/deleteenterpriseconnectionresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 402, 403, 404               | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |