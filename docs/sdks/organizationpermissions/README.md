# OrganizationPermissions

## Overview

### Available Operations

* [list](#list) - Get a list of all organization permissions
* [create](#create) - Create a new organization permission
* [get](#get) - Get an organization permission
* [update](#update) - Update an organization permission
* [delete](#delete) - Delete an organization permission

## list

Retrieves all organization permissions for the given instance.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="ListOrganizationPermissions" method="get" path="/organization_permissions" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.organization_permissions.list(limit: 10, offset: 0)

unless res.permissions.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                                                                                                                                                                                                                                                                                                                            | Type                                                                                                                                                                                                                                                                                                                                                                                                                 | Required                                                                                                                                                                                                                                                                                                                                                                                                             | Description                                                                                                                                                                                                                                                                                                                                                                                                          |
| -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `query`                                                                                                                                                                                                                                                                                                                                                                                                              | *Crystalline::Nilable.new(::String)*                                                                                                                                                                                                                                                                                                                                                                                 | :heavy_minus_sign:                                                                                                                                                                                                                                                                                                                                                                                                   | Returns organization permissions with ID, name, or key that match the given query.<br/>Uses exact match for permission ID and partial match for name and key.                                                                                                                                                                                                                                                        |
| `order_by`                                                                                                                                                                                                                                                                                                                                                                                                           | *Crystalline::Nilable.new(::String)*                                                                                                                                                                                                                                                                                                                                                                                 | :heavy_minus_sign:                                                                                                                                                                                                                                                                                                                                                                                                   | Allows to return organization permissions in a particular order.<br/>At the moment, you can order the returned permissions by their `created_at`, `name`, or `key`.<br/>In order to specify the direction, you can use the `+/-` symbols prepended in the property to order by.<br/>For example, if you want permissions to be returned in descending order according to their `created_at` property, you can use `-created_at`. |
| `limit`                                                                                                                                                                                                                                                                                                                                                                                                              | *Crystalline::Nilable.new(::Integer)*                                                                                                                                                                                                                                                                                                                                                                                | :heavy_minus_sign:                                                                                                                                                                                                                                                                                                                                                                                                   | Applies a limit to the number of results returned.<br/>Can be used for paginating the results together with `offset`.                                                                                                                                                                                                                                                                                                |
| `offset`                                                                                                                                                                                                                                                                                                                                                                                                             | *Crystalline::Nilable.new(::Integer)*                                                                                                                                                                                                                                                                                                                                                                                | :heavy_minus_sign:                                                                                                                                                                                                                                                                                                                                                                                                   | Skip the first `offset` results when paginating.<br/>Needs to be an integer greater or equal to zero.<br/>To be used in conjunction with `limit`.                                                                                                                                                                                                                                                                    |

### Response

**[Crystalline::Nilable.new(Models::Operations::ListOrganizationPermissionsResponse)](../../models/operations/listorganizationpermissionsresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 401, 422                    | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## create

Creates a new organization permission for the given instance.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="CreateOrganizationPermission" method="post" path="/organization_permissions" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

req = Models::Operations::CreateOrganizationPermissionRequest.new(
  name: '<value>',
  key: '<key>',
)

res = s.organization_permissions.create(request: req)

unless res.permission.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                                 | Type                                                                                                                      | Required                                                                                                                  | Description                                                                                                               |
| ------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------- |
| `request`                                                                                                                 | [Models::Operations::CreateOrganizationPermissionRequest](../../models/operations/createorganizationpermissionrequest.md) | :heavy_check_mark:                                                                                                        | The request object to use for the request.                                                                                |

### Response

**[Crystalline::Nilable.new(Models::Operations::CreateOrganizationPermissionResponse)](../../models/operations/createorganizationpermissionresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 401, 402, 404, 422     | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## get

Retrieves the details of an organization permission.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="GetOrganizationPermission" method="get" path="/organization_permissions/{permission_id}" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.organization_permissions.get(permission_id: '<id>')

unless res.permission.nil?
  # handle response
end

```

### Parameters

| Parameter                            | Type                                 | Required                             | Description                          |
| ------------------------------------ | ------------------------------------ | ------------------------------------ | ------------------------------------ |
| `permission_id`                      | *::String*                           | :heavy_check_mark:                   | The ID of the permission to retrieve |

### Response

**[Crystalline::Nilable.new(Models::Operations::GetOrganizationPermissionResponse)](../../models/operations/getorganizationpermissionresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 401, 404                    | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## update

Updates the properties of an existing organization permission.
System permissions cannot be updated.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="UpdateOrganizationPermission" method="patch" path="/organization_permissions/{permission_id}" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.organization_permissions.update(permission_id: '<id>', body: Models::Operations::UpdateOrganizationPermissionRequestBody.new())

unless res.permission.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                                         | Type                                                                                                                              | Required                                                                                                                          | Description                                                                                                                       |
| --------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| `permission_id`                                                                                                                   | *::String*                                                                                                                        | :heavy_check_mark:                                                                                                                | The ID of the permission to update                                                                                                |
| `body`                                                                                                                            | [Models::Operations::UpdateOrganizationPermissionRequestBody](../../models/operations/updateorganizationpermissionrequestbody.md) | :heavy_check_mark:                                                                                                                | N/A                                                                                                                               |

### Response

**[Crystalline::Nilable.new(Models::Operations::UpdateOrganizationPermissionResponse)](../../models/operations/updateorganizationpermissionresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 401, 403, 404, 422     | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## delete

Deletes an organization permission.
System permissions cannot be deleted.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="DeleteOrganizationPermission" method="delete" path="/organization_permissions/{permission_id}" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.organization_permissions.delete(permission_id: '<id>')

unless res.deleted_object.nil?
  # handle response
end

```

### Parameters

| Parameter                          | Type                               | Required                           | Description                        |
| ---------------------------------- | ---------------------------------- | ---------------------------------- | ---------------------------------- |
| `permission_id`                    | *::String*                         | :heavy_check_mark:                 | The ID of the permission to delete |

### Response

**[Crystalline::Nilable.new(Models::Operations::DeleteOrganizationPermissionResponse)](../../models/operations/deleteorganizationpermissionresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 401, 403, 404               | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |