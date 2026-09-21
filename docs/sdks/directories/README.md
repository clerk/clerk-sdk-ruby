# Directories

## Overview

### Available Operations

* [list](#list) - List all directories
* [create](#create) - Create a directory
* [get](#get) - Retrieve a directory
* [update](#update) - Update a directory
* [delete](#delete) - Delete a directory
* [rotate_api_key](#rotate_api_key) - Rotate a directory's API key
* [list_group_role_mappings](#list_group_role_mappings) - List directory group role mappings
* [create_group_role_mapping](#create_group_role_mapping) - Create a directory group role mapping
* [replace_group_role_mappings](#replace_group_role_mappings) - Replace directory group role mappings
* [delete_group_role_mapping](#delete_group_role_mapping) - Delete a directory group role mapping

## list

Returns a list of all directories for the instance.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="ListDirectories" method="get" path="/directories" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.directories.list(limit: 10, offset: 0)

unless res.directory_list.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                                                 | Type                                                                                                                                      | Required                                                                                                                                  | Description                                                                                                                               |
| ----------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------- |
| `limit`                                                                                                                                   | *Crystalline::Nilable.new(::Integer)*                                                                                                     | :heavy_minus_sign:                                                                                                                        | Applies a limit to the number of results returned.<br/>Can be used for paginating the results together with `offset`.                     |
| `offset`                                                                                                                                  | *Crystalline::Nilable.new(::Integer)*                                                                                                     | :heavy_minus_sign:                                                                                                                        | Skip the first `offset` results when paginating.<br/>Needs to be an integer greater or equal to zero.<br/>To be used in conjunction with `limit`. |

### Response

**[Crystalline::Nilable.new(Models::Operations::ListDirectoriesResponse)](../../models/operations/listdirectoriesresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 401, 403                    | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## create

Create a new directory for the instance.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="CreateDirectory" method="post" path="/directories" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)

req = nil
res = s.directories.create(request: req)

unless res.directory.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                       | Type                                                                                            | Required                                                                                        | Description                                                                                     |
| ----------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------- |
| `request`                                                                                       | [Models::Operations::CreateDirectoryRequest](../../models/operations/createdirectoryrequest.md) | :heavy_check_mark:                                                                              | The request object to use for the request.                                                      |

### Response

**[Crystalline::Nilable.new(Models::Operations::CreateDirectoryResponse)](../../models/operations/createdirectoryresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 401, 403, 422          | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## get

Returns the details of a directory.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="GetDirectory" method="get" path="/directories/{directory_id}" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.directories.get(directory_id: '<id>')

unless res.directory.nil?
  # handle response
end

```

### Parameters

| Parameter                           | Type                                | Required                            | Description                         |
| ----------------------------------- | ----------------------------------- | ----------------------------------- | ----------------------------------- |
| `directory_id`                      | *::String*                          | :heavy_check_mark:                  | The ID of the directory to retrieve |

### Response

**[Crystalline::Nilable.new(Models::Operations::GetDirectoryResponse)](../../models/operations/getdirectoryresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 401, 403, 404               | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## update

Updates a directory.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="UpdateDirectory" method="patch" path="/directories/{directory_id}" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.directories.update(directory_id: '<id>')

unless res.directory.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                                         | Type                                                                                                                              | Required                                                                                                                          | Description                                                                                                                       |
| --------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| `directory_id`                                                                                                                    | *::String*                                                                                                                        | :heavy_check_mark:                                                                                                                | The ID of the directory to update                                                                                                 |
| `body`                                                                                                                            | [Crystalline::Nilable.new(Models::Operations::UpdateDirectoryRequestBody)](../../models/operations/updatedirectoryrequestbody.md) | :heavy_minus_sign:                                                                                                                | N/A                                                                                                                               |

### Response

**[Crystalline::Nilable.new(Models::Operations::UpdateDirectoryResponse)](../../models/operations/updatedirectoryresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 401, 403, 404, 422     | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## delete

Deletes a directory and stops provisioning for it. Provisioning requests authenticated
with the directory's API key are rejected afterwards.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="DeleteDirectory" method="delete" path="/directories/{directory_id}" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.directories.delete(directory_id: '<id>')

unless res.deleted_object.nil?
  # handle response
end

```

### Parameters

| Parameter                         | Type                              | Required                          | Description                       |
| --------------------------------- | --------------------------------- | --------------------------------- | --------------------------------- |
| `directory_id`                    | *::String*                        | :heavy_check_mark:                | The ID of the directory to delete |

### Response

**[Crystalline::Nilable.new(Models::Operations::DeleteDirectoryResponse)](../../models/operations/deletedirectoryresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 401, 403, 404               | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## rotate_api_key

Generates a new API key for the directory and returns it in the `api_key` field.
This is the only way to obtain the key after creation, so make sure to update it in
your identity provider. The previous key remains valid for a short grace period before
it expires.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="RotateDirectoryAPIKey" method="post" path="/directories/{directory_id}/rotate_api_key" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.directories.rotate_api_key(directory_id: '<id>')

unless res.directory.nil?
  # handle response
end

```

### Parameters

| Parameter                                       | Type                                            | Required                                        | Description                                     |
| ----------------------------------------------- | ----------------------------------------------- | ----------------------------------------------- | ----------------------------------------------- |
| `directory_id`                                  | *::String*                                      | :heavy_check_mark:                              | The ID of the directory whose API key to rotate |

### Response

**[Crystalline::Nilable.new(Models::Operations::RotateDirectoryAPIKeyResponse)](../../models/operations/rotatedirectoryapikeyresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 401, 403, 404, 422          | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## list_group_role_mappings

Returns the list of directory group to organization role mappings for a directory, ordered by precedence.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="ListDirectoryGroupRoleMappings" method="get" path="/directories/{directory_id}/group_role_mappings" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.directories.list_group_role_mappings(directory_id: '<id>')

unless res.directory_group_role_mapping_list.nil?
  # handle response
end

```

### Parameters

| Parameter                | Type                     | Required                 | Description              |
| ------------------------ | ------------------------ | ------------------------ | ------------------------ |
| `directory_id`           | *::String*               | :heavy_check_mark:       | The ID of the directory. |

### Response

**[Crystalline::Nilable.new(Models::Operations::ListDirectoryGroupRoleMappingsResponse)](../../models/operations/listdirectorygrouprolemappingsresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 401, 403, 404               | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## create_group_role_mapping

Creates a new directory group to organization role mapping for a directory.
Mappings can be created while group role mapping is disabled on the
directory, but they only take effect once it is enabled.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="CreateDirectoryGroupRoleMapping" method="post" path="/directories/{directory_id}/group_role_mappings" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.directories.create_group_role_mapping(directory_id: '<id>', body: Models::Operations::CreateDirectoryGroupRoleMappingRequestBody.new(
  role_id: '<id>'
))

unless res.directory_group_role_mapping.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                                               | Type                                                                                                                                    | Required                                                                                                                                | Description                                                                                                                             |
| --------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------- |
| `directory_id`                                                                                                                          | *::String*                                                                                                                              | :heavy_check_mark:                                                                                                                      | The ID of the directory.                                                                                                                |
| `body`                                                                                                                                  | [Models::Operations::CreateDirectoryGroupRoleMappingRequestBody](../../models/operations/createdirectorygrouprolemappingrequestbody.md) | :heavy_check_mark:                                                                                                                      | N/A                                                                                                                                     |

### Response

**[Crystalline::Nilable.new(Models::Operations::CreateDirectoryGroupRoleMappingResponse)](../../models/operations/createdirectorygrouprolemappingresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 401, 403, 404, 422     | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## replace_group_role_mappings

Replaces the entire set of directory group role mappings for a directory. The position of
each item in the `mappings` array determines its precedence (the first item gets
precedence 1). Passing an empty array removes all mappings. Mappings can be replaced
while group role mapping is disabled on the directory, but they only take effect once
it is enabled.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="ReplaceDirectoryGroupRoleMappings" method="put" path="/directories/{directory_id}/group_role_mappings" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.directories.replace_group_role_mappings(directory_id: '<id>', body: Models::Operations::ReplaceDirectoryGroupRoleMappingsRequestBody.new(
  mappings: [
    Models::Operations::ReplaceDirectoryGroupRoleMappingsMapping.new(
      role_id: '<id>'
    ),
  ]
))

unless res.directory_group_role_mapping_list.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                                                   | Type                                                                                                                                        | Required                                                                                                                                    | Description                                                                                                                                 |
| ------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------- |
| `directory_id`                                                                                                                              | *::String*                                                                                                                                  | :heavy_check_mark:                                                                                                                          | The ID of the directory.                                                                                                                    |
| `body`                                                                                                                                      | [Models::Operations::ReplaceDirectoryGroupRoleMappingsRequestBody](../../models/operations/replacedirectorygrouprolemappingsrequestbody.md) | :heavy_check_mark:                                                                                                                          | N/A                                                                                                                                         |

### Response

**[Crystalline::Nilable.new(Models::Operations::ReplaceDirectoryGroupRoleMappingsResponse)](../../models/operations/replacedirectorygrouprolemappingsresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 401, 403, 404, 422     | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## delete_group_role_mapping

Deletes a single directory group role mapping. Mappings can be deleted while group role
mapping is disabled on the directory, but the change only takes effect once it is
enabled.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="DeleteDirectoryGroupRoleMapping" method="delete" path="/directories/{directory_id}/group_role_mappings/{mapping_id}" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.directories.delete_group_role_mapping(directory_id: '<id>', mapping_id: '<id>')

unless res.directory_group_role_mapping_deleted.nil?
  # handle response
end

```

### Parameters

| Parameter                                             | Type                                                  | Required                                              | Description                                           |
| ----------------------------------------------------- | ----------------------------------------------------- | ----------------------------------------------------- | ----------------------------------------------------- |
| `directory_id`                                        | *::String*                                            | :heavy_check_mark:                                    | The ID of the directory.                              |
| `mapping_id`                                          | *::String*                                            | :heavy_check_mark:                                    | The ID of the directory group role mapping to delete. |

### Response

**[Crystalline::Nilable.new(Models::Operations::DeleteDirectoryGroupRoleMappingResponse)](../../models/operations/deletedirectorygrouprolemappingresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 401, 403, 404          | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |