# RoleSets

## Overview

### Available Operations

* [list](#list) - Get a list of role sets
* [create](#create) - Create a role set
* [get](#get) - Retrieve a role set
* [update](#update) - Update a role set
* [replace](#replace) - Replace a role set
* [add_roles](#add_roles) - Add roles to a role set
* [replace_role](#replace_role) - Replace a role in a role set

## list

Returns a list of role sets for the instance.
Results can be paginated using the optional `limit` and `offset` query parameters.
The role sets are ordered by descending creation date by default.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="ListRoleSets" method="get" path="/role_sets" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.role_sets.list(order_by: '-created_at', limit: 10, offset: 0)

unless res.role_sets.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                                                                                                                                                                                                                                                                                                                                                                                      | Type                                                                                                                                                                                                                                                                                                                                                                                                                                                                           | Required                                                                                                                                                                                                                                                                                                                                                                                                                                                                       | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `query`                                                                                                                                                                                                                                                                                                                                                                                                                                                                        | *Crystalline::Nilable.new(::String)*                                                                                                                                                                                                                                                                                                                                                                                                                                           | :heavy_minus_sign:                                                                                                                                                                                                                                                                                                                                                                                                                                                             | Returns role sets with ID, name, or key that match the given query.<br/>Uses exact match for role set ID and partial match for name and key.                                                                                                                                                                                                                                                                                                                                   |
| `order_by`                                                                                                                                                                                                                                                                                                                                                                                                                                                                     | *Crystalline::Nilable.new(::String)*                                                                                                                                                                                                                                                                                                                                                                                                                                           | :heavy_minus_sign:                                                                                                                                                                                                                                                                                                                                                                                                                                                             | Allows to return role sets in a particular order.<br/>At the moment, you can order the returned role sets by their `created_at`, `name`, or `key`.<br/>In order to specify the direction, you can use the `+/-` symbols prepended in the property to order by.<br/>For example, if you want role sets to be returned in descending order according to their `created_at` property, you can use `-created_at`.<br/>If you don't use `+` or `-`, then `+` is implied.<br/>Defaults to `-created_at`. |
| `limit`                                                                                                                                                                                                                                                                                                                                                                                                                                                                        | *Crystalline::Nilable.new(::Integer)*                                                                                                                                                                                                                                                                                                                                                                                                                                          | :heavy_minus_sign:                                                                                                                                                                                                                                                                                                                                                                                                                                                             | Applies a limit to the number of results returned.<br/>Can be used for paginating the results together with `offset`.                                                                                                                                                                                                                                                                                                                                                          |
| `offset`                                                                                                                                                                                                                                                                                                                                                                                                                                                                       | *Crystalline::Nilable.new(::Integer)*                                                                                                                                                                                                                                                                                                                                                                                                                                          | :heavy_minus_sign:                                                                                                                                                                                                                                                                                                                                                                                                                                                             | Skip the first `offset` results when paginating.<br/>Needs to be an integer greater or equal to zero.<br/>To be used in conjunction with `limit`.                                                                                                                                                                                                                                                                                                                              |

### Response

**[Crystalline::Nilable.new(Models::Operations::ListRoleSetsResponse)](../../models/operations/listrolesetsresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 401, 403, 422          | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## create

Creates a new role set with the given name and roles.
The key must be unique for the instance and start with the 'role_set:' prefix, followed by lowercase alphanumeric characters and underscores only.
You must provide at least one role and specify a default role key and creator role key.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="CreateRoleSet" method="post" path="/role_sets" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)

req = Models::Operations::CreateRoleSetRequest.new(
  name: '<value>',
  default_role_key: '<value>',
  creator_role_key: '<value>',
  roles: [
    '<value 1>',
    '<value 2>',
  ]
)
res = s.role_sets.create(request: req)

unless res.role_set.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                   | Type                                                                                        | Required                                                                                    | Description                                                                                 |
| ------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------- |
| `request`                                                                                   | [Models::Operations::CreateRoleSetRequest](../../models/operations/createrolesetrequest.md) | :heavy_check_mark:                                                                          | The request object to use for the request.                                                  |

### Response

**[Crystalline::Nilable.new(Models::Operations::CreateRoleSetResponse)](../../models/operations/createrolesetresponse.md)**

### Errors

| Error Type                   | Status Code                  | Content Type                 |
| ---------------------------- | ---------------------------- | ---------------------------- |
| Models::Errors::ClerkErrors  | 400, 401, 402, 403, 404, 422 | application/json             |
| Errors::APIError             | 4XX, 5XX                     | \*/\*                        |

## get

Retrieves an existing role set by its key or ID.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="GetRoleSet" method="get" path="/role_sets/{role_set_key_or_id}" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.role_sets.get(role_set_key_or_id: '<id>')

unless res.role_set.nil?
  # handle response
end

```

### Parameters

| Parameter                     | Type                          | Required                      | Description                   |
| ----------------------------- | ----------------------------- | ----------------------------- | ----------------------------- |
| `role_set_key_or_id`          | *::String*                    | :heavy_check_mark:            | The key or ID of the role set |

### Response

**[Crystalline::Nilable.new(Models::Operations::GetRoleSetResponse)](../../models/operations/getrolesetresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 401, 403, 404               | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## update

Updates an existing role set.
You can update the name, key, description, type, default role, or creator role.
All parameters are optional - you can update only the fields you want to change.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="UpdateRoleSet" method="patch" path="/role_sets/{role_set_key_or_id}" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.role_sets.update(role_set_key_or_id: '<id>', body: Models::Operations::UpdateRoleSetRequestBody.new)

unless res.role_set.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                           | Type                                                                                                | Required                                                                                            | Description                                                                                         |
| --------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------- |
| `role_set_key_or_id`                                                                                | *::String*                                                                                          | :heavy_check_mark:                                                                                  | The key or ID of the role set to update                                                             |
| `body`                                                                                              | [Models::Operations::UpdateRoleSetRequestBody](../../models/operations/updaterolesetrequestbody.md) | :heavy_check_mark:                                                                                  | N/A                                                                                                 |

### Response

**[Crystalline::Nilable.new(Models::Operations::UpdateRoleSetResponse)](../../models/operations/updaterolesetresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 401, 403, 404, 422     | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## replace

Replaces a role set with another role set. This is functionally equivalent to deleting
the role set but allows for atomic replacement with migration support.
Organizations using this role set will be migrated to the destination role set.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="ReplaceRoleSet" method="post" path="/role_sets/{role_set_key_or_id}/replace" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.role_sets.replace(role_set_key_or_id: '<id>', body: Models::Operations::ReplaceRoleSetRequestBody.new(
  dest_role_set_key: '<value>'
))

unless res.deleted_object.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                             | Type                                                                                                  | Required                                                                                              | Description                                                                                           |
| ----------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------- |
| `role_set_key_or_id`                                                                                  | *::String*                                                                                            | :heavy_check_mark:                                                                                    | The key or ID of the role set to replace                                                              |
| `body`                                                                                                | [Models::Operations::ReplaceRoleSetRequestBody](../../models/operations/replacerolesetrequestbody.md) | :heavy_check_mark:                                                                                    | N/A                                                                                                   |

### Response

**[Crystalline::Nilable.new(Models::Operations::ReplaceRoleSetResponse)](../../models/operations/replacerolesetresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 401, 403, 404, 422     | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## add_roles

Adds one or more roles to an existing role set.
You can optionally update the default role or creator role when adding new roles.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="AddRolesToRoleSet" method="post" path="/role_sets/{role_set_key_or_id}/roles" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.role_sets.add_roles(role_set_key_or_id: '<id>', body: Models::Operations::AddRolesToRoleSetRequestBody.new(
  role_keys: [
    '<value 1>',
    '<value 2>',
  ]
))

unless res.role_set.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                   | Type                                                                                                        | Required                                                                                                    | Description                                                                                                 |
| ----------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------- |
| `role_set_key_or_id`                                                                                        | *::String*                                                                                                  | :heavy_check_mark:                                                                                          | The key or ID of the role set                                                                               |
| `body`                                                                                                      | [Models::Operations::AddRolesToRoleSetRequestBody](../../models/operations/addrolestorolesetrequestbody.md) | :heavy_check_mark:                                                                                          | N/A                                                                                                         |

### Response

**[Crystalline::Nilable.new(Models::Operations::AddRolesToRoleSetResponse)](../../models/operations/addrolestorolesetresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 401, 403, 404, 422     | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## replace_role

Replaces a role in a role set with another role. This atomically removes
the source role and reassigns any members to the destination role.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="ReplaceRoleInRoleSet" method="post" path="/role_sets/{role_set_key_or_id}/roles/replace" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.role_sets.replace_role(role_set_key_or_id: '<id>', body: Models::Operations::ReplaceRoleInRoleSetRequestBody.new(
  role_key: '<value>',
  to_role_key: '<value>'
))

unless res.role_set.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                         | Type                                                                                                              | Required                                                                                                          | Description                                                                                                       |
| ----------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------- |
| `role_set_key_or_id`                                                                                              | *::String*                                                                                                        | :heavy_check_mark:                                                                                                | The key or ID of the role set                                                                                     |
| `body`                                                                                                            | [Models::Operations::ReplaceRoleInRoleSetRequestBody](../../models/operations/replaceroleinrolesetrequestbody.md) | :heavy_check_mark:                                                                                                | N/A                                                                                                               |

### Response

**[Crystalline::Nilable.new(Models::Operations::ReplaceRoleInRoleSetResponse)](../../models/operations/replaceroleinrolesetresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 401, 403, 404, 422     | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |