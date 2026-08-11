# ScimDirectories

## Overview

### Available Operations

* [list](#list) - List all SCIM directories
* [create](#create) - Create a SCIM directory
* [get](#get) - Retrieve a SCIM directory
* [update](#update) - Update a SCIM directory
* [delete](#delete) - Delete a SCIM directory
* [rotate_api_key](#rotate_api_key) - Rotate a SCIM directory's API key
* [list_group_role_mappings](#list_group_role_mappings) - List SCIM group role mappings
* [create_group_role_mapping](#create_group_role_mapping) - Create a SCIM group role mapping
* [replace_group_role_mappings](#replace_group_role_mappings) - Replace SCIM group role mappings
* [delete_group_role_mapping](#delete_group_role_mapping) - Delete a SCIM group role mapping

## list

Returns a list of all SCIM directories for the instance.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="ListSCIMDirectories" method="get" path="/scim_directories" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.scim_directories.list(limit: 10, offset: 0)

unless res.scim_directory_list.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                                                 | Type                                                                                                                                      | Required                                                                                                                                  | Description                                                                                                                               |
| ----------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------- |
| `limit`                                                                                                                                   | *Crystalline::Nilable.new(::Integer)*                                                                                                     | :heavy_minus_sign:                                                                                                                        | Applies a limit to the number of results returned.<br/>Can be used for paginating the results together with `offset`.                     |
| `offset`                                                                                                                                  | *Crystalline::Nilable.new(::Integer)*                                                                                                     | :heavy_minus_sign:                                                                                                                        | Skip the first `offset` results when paginating.<br/>Needs to be an integer greater or equal to zero.<br/>To be used in conjunction with `limit`. |

### Response

**[Crystalline::Nilable.new(Models::Operations::ListSCIMDirectoriesResponse)](../../models/operations/listscimdirectoriesresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 401, 403                    | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## create

Create a new SCIM directory for the instance.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="CreateSCIMDirectory" method="post" path="/scim_directories" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)

req = nil
res = s.scim_directories.create(request: req)

unless res.scim_directory.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                               | Type                                                                                                    | Required                                                                                                | Description                                                                                             |
| ------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------- |
| `request`                                                                                               | [Models::Operations::CreateSCIMDirectoryRequest](../../models/operations/createscimdirectoryrequest.md) | :heavy_check_mark:                                                                                      | The request object to use for the request.                                                              |

### Response

**[Crystalline::Nilable.new(Models::Operations::CreateSCIMDirectoryResponse)](../../models/operations/createscimdirectoryresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 401, 403, 422          | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## get

Returns the details of a SCIM directory.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="GetSCIMDirectory" method="get" path="/scim_directories/{scim_directory_id}" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.scim_directories.get(scim_directory_id: '<id>')

unless res.scim_directory.nil?
  # handle response
end

```

### Parameters

| Parameter                                | Type                                     | Required                                 | Description                              |
| ---------------------------------------- | ---------------------------------------- | ---------------------------------------- | ---------------------------------------- |
| `scim_directory_id`                      | *::String*                               | :heavy_check_mark:                       | The ID of the SCIM directory to retrieve |

### Response

**[Crystalline::Nilable.new(Models::Operations::GetSCIMDirectoryResponse)](../../models/operations/getscimdirectoryresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 401, 403, 404               | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## update

Updates a SCIM directory.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="UpdateSCIMDirectory" method="patch" path="/scim_directories/{scim_directory_id}" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.scim_directories.update(scim_directory_id: '<id>')

unless res.scim_directory.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                                                 | Type                                                                                                                                      | Required                                                                                                                                  | Description                                                                                                                               |
| ----------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------- |
| `scim_directory_id`                                                                                                                       | *::String*                                                                                                                                | :heavy_check_mark:                                                                                                                        | The ID of the SCIM directory to update                                                                                                    |
| `body`                                                                                                                                    | [Crystalline::Nilable.new(Models::Operations::UpdateSCIMDirectoryRequestBody)](../../models/operations/updatescimdirectoryrequestbody.md) | :heavy_minus_sign:                                                                                                                        | N/A                                                                                                                                       |

### Response

**[Crystalline::Nilable.new(Models::Operations::UpdateSCIMDirectoryResponse)](../../models/operations/updatescimdirectoryresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 401, 403, 404, 422     | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## delete

Deletes a SCIM directory and stops provisioning for it. SCIM requests authenticated
with the directory's API key are rejected afterwards.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="DeleteSCIMDirectory" method="delete" path="/scim_directories/{scim_directory_id}" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.scim_directories.delete(scim_directory_id: '<id>')

unless res.deleted_object.nil?
  # handle response
end

```

### Parameters

| Parameter                              | Type                                   | Required                               | Description                            |
| -------------------------------------- | -------------------------------------- | -------------------------------------- | -------------------------------------- |
| `scim_directory_id`                    | *::String*                             | :heavy_check_mark:                     | The ID of the SCIM directory to delete |

### Response

**[Crystalline::Nilable.new(Models::Operations::DeleteSCIMDirectoryResponse)](../../models/operations/deletescimdirectoryresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 401, 403, 404               | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## rotate_api_key

Generates a new API key for the SCIM directory and returns it in the `api_key` field.
This is the only way to obtain the key after creation, so make sure to update it in
your identity provider. The previous key remains valid for a short grace period before
it expires.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="RotateSCIMDirectoryAPIKey" method="post" path="/scim_directories/{scim_directory_id}/rotate_api_key" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.scim_directories.rotate_api_key(scim_directory_id: '<id>')

unless res.scim_directory.nil?
  # handle response
end

```

### Parameters

| Parameter                                            | Type                                                 | Required                                             | Description                                          |
| ---------------------------------------------------- | ---------------------------------------------------- | ---------------------------------------------------- | ---------------------------------------------------- |
| `scim_directory_id`                                  | *::String*                                           | :heavy_check_mark:                                   | The ID of the SCIM directory whose API key to rotate |

### Response

**[Crystalline::Nilable.new(Models::Operations::RotateSCIMDirectoryAPIKeyResponse)](../../models/operations/rotatescimdirectoryapikeyresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 401, 403, 404               | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## list_group_role_mappings

Returns the list of SCIM group to organization role mappings for a SCIM directory, ordered by precedence.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="ListSCIMGroupRoleMappings" method="get" path="/scim_directories/{scim_directory_id}/group_role_mappings" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.scim_directories.list_group_role_mappings(scim_directory_id: '<id>')

unless res.scim_group_role_mapping_list.nil?
  # handle response
end

```

### Parameters

| Parameter                     | Type                          | Required                      | Description                   |
| ----------------------------- | ----------------------------- | ----------------------------- | ----------------------------- |
| `scim_directory_id`           | *::String*                    | :heavy_check_mark:            | The ID of the SCIM directory. |

### Response

**[Crystalline::Nilable.new(Models::Operations::ListSCIMGroupRoleMappingsResponse)](../../models/operations/listscimgrouprolemappingsresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 401, 403, 404               | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## create_group_role_mapping

Creates a new SCIM group to organization role mapping for a SCIM directory.
Group role mapping must be enabled on the directory.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="CreateSCIMGroupRoleMapping" method="post" path="/scim_directories/{scim_directory_id}/group_role_mappings" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.scim_directories.create_group_role_mapping(scim_directory_id: '<id>', body: Models::Operations::CreateSCIMGroupRoleMappingRequestBody.new(
  scim_group_id: '<id>',
  role_id: '<id>'
))

unless res.scim_group_role_mapping.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                                     | Type                                                                                                                          | Required                                                                                                                      | Description                                                                                                                   |
| ----------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------- |
| `scim_directory_id`                                                                                                           | *::String*                                                                                                                    | :heavy_check_mark:                                                                                                            | The ID of the SCIM directory.                                                                                                 |
| `body`                                                                                                                        | [Models::Operations::CreateSCIMGroupRoleMappingRequestBody](../../models/operations/createscimgrouprolemappingrequestbody.md) | :heavy_check_mark:                                                                                                            | N/A                                                                                                                           |

### Response

**[Crystalline::Nilable.new(Models::Operations::CreateSCIMGroupRoleMappingResponse)](../../models/operations/createscimgrouprolemappingresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 401, 403, 404, 422     | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## replace_group_role_mappings

Replaces the entire set of SCIM group role mappings for a directory. The position of
each item in the `mappings` array determines its precedence (the first item gets
precedence 1). Passing an empty array removes all mappings. Group role mapping must be
enabled on the directory.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="ReplaceSCIMGroupRoleMappings" method="put" path="/scim_directories/{scim_directory_id}/group_role_mappings" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.scim_directories.replace_group_role_mappings(scim_directory_id: '<id>', body: Models::Operations::ReplaceSCIMGroupRoleMappingsRequestBody.new(
  mappings: []
))

unless res.scim_group_role_mapping_list.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                                         | Type                                                                                                                              | Required                                                                                                                          | Description                                                                                                                       |
| --------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| `scim_directory_id`                                                                                                               | *::String*                                                                                                                        | :heavy_check_mark:                                                                                                                | The ID of the SCIM directory.                                                                                                     |
| `body`                                                                                                                            | [Models::Operations::ReplaceSCIMGroupRoleMappingsRequestBody](../../models/operations/replacescimgrouprolemappingsrequestbody.md) | :heavy_check_mark:                                                                                                                | N/A                                                                                                                               |

### Response

**[Crystalline::Nilable.new(Models::Operations::ReplaceSCIMGroupRoleMappingsResponse)](../../models/operations/replacescimgrouprolemappingsresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 401, 403, 404, 422     | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## delete_group_role_mapping

Deletes a single SCIM group role mapping. Group role mapping must be enabled on the
directory.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="DeleteSCIMGroupRoleMapping" method="delete" path="/scim_directories/{scim_directory_id}/group_role_mappings/{mapping_id}" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.scim_directories.delete_group_role_mapping(scim_directory_id: '<id>', mapping_id: '<id>')

unless res.scim_group_role_mapping_deleted.nil?
  # handle response
end

```

### Parameters

| Parameter                                        | Type                                             | Required                                         | Description                                      |
| ------------------------------------------------ | ------------------------------------------------ | ------------------------------------------------ | ------------------------------------------------ |
| `scim_directory_id`                              | *::String*                                       | :heavy_check_mark:                               | The ID of the SCIM directory.                    |
| `mapping_id`                                     | *::String*                                       | :heavy_check_mark:                               | The ID of the SCIM group role mapping to delete. |

### Response

**[Crystalline::Nilable.new(Models::Operations::DeleteSCIMGroupRoleMappingResponse)](../../models/operations/deletescimgrouprolemappingresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 401, 403, 404          | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |