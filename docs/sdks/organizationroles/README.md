# OrganizationRoles

## Overview

### Available Operations

* [list](#list) - Get a list of organization roles
* [create](#create) - Create an organization role
* [get](#get) - Retrieve an organization role
* [update](#update) - Update an organization role
* [delete](#delete) - Delete an organization role
* [assign_permission](#assign_permission) - Assign a permission to an organization role
* [remove_permission](#remove_permission) - Remove a permission from an organization role

## list

This request returns the list of organization roles for the instance.
Results can be paginated using the optional `limit` and `offset` query parameters.
The organization roles are ordered by descending creation date.
Most recent roles will be returned first.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="ListOrganizationRoles" method="get" path="/organization_roles" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.organization_roles.list(order_by: '-created_at', limit: 10, offset: 0)

unless res.roles.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 | Type                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      | Required                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `query`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   | *Crystalline::Nilable.new(::String)*                                                                                                                                                                                                                                                                                                                                                                                                                                                                      | :heavy_minus_sign:                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        | Returns organization roles with ID, name, or key that match the given query.<br/>Uses exact match for organization role ID and partial match for name and key.                                                                                                                                                                                                                                                                                                                                            |
| `order_by`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                | *Crystalline::Nilable.new(::String)*                                                                                                                                                                                                                                                                                                                                                                                                                                                                      | :heavy_minus_sign:                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        | Allows to return organization roles in a particular order.<br/>At the moment, you can order the returned organization roles by their `created_at`, `name`, or `key`.<br/>In order to specify the direction, you can use the `+/-` symbols prepended in the property to order by.<br/>For example, if you want organization roles to be returned in descending order according to their `created_at` property, you can use `-created_at`.<br/>If you don't use `+` or `-`, then `+` is implied.<br/>Defaults to `-created_at`. |
| `limit`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   | *Crystalline::Nilable.new(::Integer)*                                                                                                                                                                                                                                                                                                                                                                                                                                                                     | :heavy_minus_sign:                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        | Applies a limit to the number of results returned.<br/>Can be used for paginating the results together with `offset`.                                                                                                                                                                                                                                                                                                                                                                                     |
| `offset`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  | *Crystalline::Nilable.new(::Integer)*                                                                                                                                                                                                                                                                                                                                                                                                                                                                     | :heavy_minus_sign:                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        | Skip the first `offset` results when paginating.<br/>Needs to be an integer greater or equal to zero.<br/>To be used in conjunction with `limit`.                                                                                                                                                                                                                                                                                                                                                         |

### Response

**[Crystalline::Nilable.new(Models::Operations::ListOrganizationRolesResponse)](../../models/operations/listorganizationrolesresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 401, 403, 422          | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## create

Creates a new organization role with the given name and permissions for an instance.
The key must be unique for the instance and start with the 'org:' prefix, followed by lowercase alphanumeric characters and underscores only.
You can optionally provide a description for the role and specify whether it should be included in the initial role set.
Organization roles support permissions that can be assigned to control access within the organization.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="CreateOrganizationRole" method="post" path="/organization_roles" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)

req = Models::Operations::CreateOrganizationRoleRequest.new(
  name: '<value>',
  key: '<key>'
)
res = s.organization_roles.create(request: req)

unless res.role.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                     | Type                                                                                                          | Required                                                                                                      | Description                                                                                                   |
| ------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------- |
| `request`                                                                                                     | [Models::Operations::CreateOrganizationRoleRequest](../../models/operations/createorganizationrolerequest.md) | :heavy_check_mark:                                                                                            | The request object to use for the request.                                                                    |

### Response

**[Crystalline::Nilable.new(Models::Operations::CreateOrganizationRoleResponse)](../../models/operations/createorganizationroleresponse.md)**

### Errors

| Error Type                   | Status Code                  | Content Type                 |
| ---------------------------- | ---------------------------- | ---------------------------- |
| Models::Errors::ClerkErrors  | 400, 401, 402, 403, 404, 422 | application/json             |
| Errors::APIError             | 4XX, 5XX                     | \*/\*                        |

## get

Use this request to retrieve an existing organization role by its ID.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="GetOrganizationRole" method="get" path="/organization_roles/{organization_role_id}" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.organization_roles.get(organization_role_id: '<id>')

unless res.role.nil?
  # handle response
end

```

### Parameters

| Parameter                       | Type                            | Required                        | Description                     |
| ------------------------------- | ------------------------------- | ------------------------------- | ------------------------------- |
| `organization_role_id`          | *::String*                      | :heavy_check_mark:              | The ID of the organization role |

### Response

**[Crystalline::Nilable.new(Models::Operations::GetOrganizationRoleResponse)](../../models/operations/getorganizationroleresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 401, 403, 404               | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## update

Updates an existing organization role.
You can update the name, key, description, and permissions of the role.
All parameters are optional - you can update only the fields you want to change.
If the role is used as a creator role or domain default role, updating the key will cascade the update to the organization settings.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="UpdateOrganizationRole" method="patch" path="/organization_roles/{organization_role_id}" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.organization_roles.update(organization_role_id: '<id>', body: Models::Operations::UpdateOrganizationRoleRequestBody.new)

unless res.role.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                             | Type                                                                                                                  | Required                                                                                                              | Description                                                                                                           |
| --------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------- |
| `organization_role_id`                                                                                                | *::String*                                                                                                            | :heavy_check_mark:                                                                                                    | The ID of the organization role to update                                                                             |
| `body`                                                                                                                | [Models::Operations::UpdateOrganizationRoleRequestBody](../../models/operations/updateorganizationrolerequestbody.md) | :heavy_check_mark:                                                                                                    | N/A                                                                                                                   |

### Response

**[Crystalline::Nilable.new(Models::Operations::UpdateOrganizationRoleResponse)](../../models/operations/updateorganizationroleresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 401, 403, 404, 422     | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## delete

Deletes the organization role.
The role cannot be deleted if it is currently used as the default creator role, domain default role, assigned to any members, or exists in any invitations.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="DeleteOrganizationRole" method="delete" path="/organization_roles/{organization_role_id}" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.organization_roles.delete(organization_role_id: '<id>')

unless res.deleted_object.nil?
  # handle response
end

```

### Parameters

| Parameter                                 | Type                                      | Required                                  | Description                               |
| ----------------------------------------- | ----------------------------------------- | ----------------------------------------- | ----------------------------------------- |
| `organization_role_id`                    | *::String*                                | :heavy_check_mark:                        | The ID of the organization role to delete |

### Response

**[Crystalline::Nilable.new(Models::Operations::DeleteOrganizationRoleResponse)](../../models/operations/deleteorganizationroleresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 401, 403, 404, 422          | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## assign_permission

Assigns a permission to an organization role

### Example Usage

<!-- UsageSnippet language="ruby" operationID="AssignPermissionToOrganizationRole" method="post" path="/organization_roles/{organization_role_id}/permissions/{permission_id}" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.organization_roles.assign_permission(organization_role_id: '<id>', permission_id: '<id>')

unless res.role.nil?
  # handle response
end

```

### Parameters

| Parameter                          | Type                               | Required                           | Description                        |
| ---------------------------------- | ---------------------------------- | ---------------------------------- | ---------------------------------- |
| `organization_role_id`             | *::String*                         | :heavy_check_mark:                 | The ID of the organization role    |
| `permission_id`                    | *::String*                         | :heavy_check_mark:                 | The ID of the permission to assign |

### Response

**[Crystalline::Nilable.new(Models::Operations::AssignPermissionToOrganizationRoleResponse)](../../models/operations/assignpermissiontoorganizationroleresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 401, 403, 404, 409          | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## remove_permission

Removes a permission from an organization role

### Example Usage

<!-- UsageSnippet language="ruby" operationID="RemovePermissionFromOrganizationRole" method="delete" path="/organization_roles/{organization_role_id}/permissions/{permission_id}" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.organization_roles.remove_permission(organization_role_id: '<id>', permission_id: '<id>')

unless res.role.nil?
  # handle response
end

```

### Parameters

| Parameter                          | Type                               | Required                           | Description                        |
| ---------------------------------- | ---------------------------------- | ---------------------------------- | ---------------------------------- |
| `organization_role_id`             | *::String*                         | :heavy_check_mark:                 | The ID of the organization role    |
| `permission_id`                    | *::String*                         | :heavy_check_mark:                 | The ID of the permission to remove |

### Response

**[Crystalline::Nilable.new(Models::Operations::RemovePermissionFromOrganizationRoleResponse)](../../models/operations/removepermissionfromorganizationroleresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 401, 403, 404, 422          | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |