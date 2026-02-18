# SamlConnections

## Overview

### Available Operations

* [list](#list) - Get a list of SAML Connections for an instance
* [create](#create) - Create a SAML Connection
* [get](#get) - Retrieve a SAML Connection by ID
* [update](#update) - Update a SAML Connection
* [delete](#delete) - Delete a SAML Connection

## list

Returns the list of SAML Connections for an instance.
Results can be paginated using the optional `limit` and `offset` query parameters.
The SAML Connections are ordered by descending creation date and the most recent will be returned first.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="ListSAMLConnections" method="get" path="/saml_connections" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)

req = Models::Operations::ListSAMLConnectionsRequest.new
res = s.saml_connections.list(request: req)

unless res.saml_connections.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                               | Type                                                                                                    | Required                                                                                                | Description                                                                                             |
| ------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------- |
| `request`                                                                                               | [Models::Operations::ListSAMLConnectionsRequest](../../models/operations/listsamlconnectionsrequest.md) | :heavy_check_mark:                                                                                      | The request object to use for the request.                                                              |

### Response

**[Crystalline::Nilable.new(Models::Operations::ListSAMLConnectionsResponse)](../../models/operations/listsamlconnectionsresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 402, 403, 422               | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## create

Create a new SAML Connection.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="CreateSAMLConnection" method="post" path="/saml_connections" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)

req = Models::Operations::CreateSAMLConnectionRequestBody2.new(
  name: 'My SAML Connection',
  domains: [
    '<value 1>',
    '<value 2>',
  ],
  provider: Models::Operations::Provider2::SAML_CUSTOM,
  idp_entity_id: 'http://idp.example.org/',
  idp_sso_url: 'http://idp.example.org/sso',
  idp_certificate: 'MIIDdzCCAl+gAwIBAgIJAKcyBaiiz+DT...',
  idp_metadata_url: 'http://idp.example.org/metadata.xml',
  idp_metadata: '<EntityDescriptor ...',
  attribute_mapping: Models::Operations::CreateSAMLConnectionAttributeMapping2.new(
    user_id: 'nameid',
    email_address: 'mail',
    first_name: 'givenName',
    last_name: 'surname'
  )
)
res = s.saml_connections.create(request: req)

unless res.schemas_saml_connection.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                                                                                                    | Type                                                                                                                                                                                         | Required                                                                                                                                                                                     | Description                                                                                                                                                                                  |
| -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `request`                                                                                                                                                                                    | [Crystalline::Union.new(Models::Operations::CreateSAMLConnectionRequestBody1, Models::Operations::CreateSAMLConnectionRequestBody2)](../../models/operations/createsamlconnectionrequest.md) | :heavy_check_mark:                                                                                                                                                                           | The request object to use for the request.                                                                                                                                                   |

### Response

**[Crystalline::Nilable.new(Models::Operations::CreateSAMLConnectionResponse)](../../models/operations/createsamlconnectionresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 402, 403, 404, 422          | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## get

Fetches the SAML Connection whose ID matches the provided `saml_connection_id` in the path.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="GetSAMLConnection" method="get" path="/saml_connections/{saml_connection_id}" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.saml_connections.get(saml_connection_id: 'saml_conn_123')

unless res.schemas_saml_connection.nil?
  # handle response
end

```

### Parameters

| Parameter                     | Type                          | Required                      | Description                   |
| ----------------------------- | ----------------------------- | ----------------------------- | ----------------------------- |
| `saml_connection_id`          | *::String*                    | :heavy_check_mark:            | The ID of the SAML Connection |

### Response

**[Crystalline::Nilable.new(Models::Operations::GetSAMLConnectionResponse)](../../models/operations/getsamlconnectionresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 402, 403, 404               | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## update

Updates the SAML Connection whose ID matches the provided `id` in the path.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="UpdateSAMLConnection" method="patch" path="/saml_connections/{saml_connection_id}" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.saml_connections.update(saml_connection_id: 'saml_conn_123_update', body: Models::Operations::UpdateSAMLConnectionRequestBody.new)

unless res.schemas_saml_connection.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                         | Type                                                                                                              | Required                                                                                                          | Description                                                                                                       |
| ----------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------- |
| `saml_connection_id`                                                                                              | *::String*                                                                                                        | :heavy_check_mark:                                                                                                | The ID of the SAML Connection to update                                                                           |
| `body`                                                                                                            | [Models::Operations::UpdateSAMLConnectionRequestBody](../../models/operations/updatesamlconnectionrequestbody.md) | :heavy_check_mark:                                                                                                | N/A                                                                                                               |

### Response

**[Crystalline::Nilable.new(Models::Operations::UpdateSAMLConnectionResponse)](../../models/operations/updatesamlconnectionresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 402, 403, 404, 422          | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## delete

Deletes the SAML Connection whose ID matches the provided `id` in the path.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="DeleteSAMLConnection" method="delete" path="/saml_connections/{saml_connection_id}" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.saml_connections.delete(saml_connection_id: 'saml_conn_123_delete')

unless res.deleted_object.nil?
  # handle response
end

```

### Parameters

| Parameter                               | Type                                    | Required                                | Description                             |
| --------------------------------------- | --------------------------------------- | --------------------------------------- | --------------------------------------- |
| `saml_connection_id`                    | *::String*                              | :heavy_check_mark:                      | The ID of the SAML Connection to delete |

### Response

**[Crystalline::Nilable.new(Models::Operations::DeleteSAMLConnectionResponse)](../../models/operations/deletesamlconnectionresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 402, 403, 404               | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |