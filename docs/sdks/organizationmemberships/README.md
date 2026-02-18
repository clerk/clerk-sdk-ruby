# OrganizationMemberships

## Overview

### Available Operations

* [create](#create) - Create a new organization membership
* [list](#list) - Get a list of all members of an organization
* [update](#update) - Update an organization membership
* [delete](#delete) - Remove a member from an organization
* [update_metadata](#update_metadata) - Merge and update organization membership metadata

## create

Adds a user as a member to the given organization.
Only users in the same instance as the organization can be added as members.

This organization will be the user's [active organization] (https://clerk.com/docs/organizations/overview#active-organization)
the next time they create a session, presuming they don't explicitly set a
different organization as active before then.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="CreateOrganizationMembership" method="post" path="/organizations/{organization_id}/memberships" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.organization_memberships.create(organization_id: 'org_123', body: Models::Operations::CreateOrganizationMembershipRequestBody.new(
  user_id: 'user_456',
  role: 'admin'
))

unless res.organization_membership.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                                         | Type                                                                                                                              | Required                                                                                                                          | Description                                                                                                                       |
| --------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| `organization_id`                                                                                                                 | *::String*                                                                                                                        | :heavy_check_mark:                                                                                                                | The ID of the organization where the new membership will be created                                                               |
| `body`                                                                                                                            | [Models::Operations::CreateOrganizationMembershipRequestBody](../../models/operations/createorganizationmembershiprequestbody.md) | :heavy_check_mark:                                                                                                                | N/A                                                                                                                               |

### Response

**[Crystalline::Nilable.new(Models::Operations::CreateOrganizationMembershipResponse)](../../models/operations/createorganizationmembershipresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 403, 404, 422          | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## list

Retrieves all user memberships for the given organization

### Example Usage

<!-- UsageSnippet language="ruby" operationID="ListOrganizationMemberships" method="get" path="/organizations/{organization_id}/memberships" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)

req = Models::Operations::ListOrganizationMembershipsRequest.new(
  organization_id: 'org_789',
  email_address: [
    '+created_at',
  ],
  last_active_at_before: 1_700_690_400_000,
  last_active_at_after: 1_700_690_400_000,
  created_at_before: 1_730_160_000_000,
  created_at_after: 1_730_160_000_000
)
res = s.organization_memberships.list(request: req)

unless res.organization_memberships.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                               | Type                                                                                                                    | Required                                                                                                                | Description                                                                                                             |
| ----------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------- |
| `request`                                                                                                               | [Models::Operations::ListOrganizationMembershipsRequest](../../models/operations/listorganizationmembershipsrequest.md) | :heavy_check_mark:                                                                                                      | The request object to use for the request.                                                                              |

### Response

**[Crystalline::Nilable.new(Models::Operations::ListOrganizationMembershipsResponse)](../../models/operations/listorganizationmembershipsresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 401, 422                    | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## update

Updates the properties of an existing organization membership

### Example Usage

<!-- UsageSnippet language="ruby" operationID="UpdateOrganizationMembership" method="patch" path="/organizations/{organization_id}/memberships/{user_id}" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.organization_memberships.update(organization_id: 'org_12345', user_id: 'user_67890', body: Models::Operations::UpdateOrganizationMembershipRequestBody.new(
  role: 'admin'
))

unless res.organization_membership.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                                         | Type                                                                                                                              | Required                                                                                                                          | Description                                                                                                                       |
| --------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| `organization_id`                                                                                                                 | *::String*                                                                                                                        | :heavy_check_mark:                                                                                                                | The ID of the organization to which this membership belongs                                                                       |
| `user_id`                                                                                                                         | *::String*                                                                                                                        | :heavy_check_mark:                                                                                                                | The ID of the user to which this membership belongs                                                                               |
| `body`                                                                                                                            | [Models::Operations::UpdateOrganizationMembershipRequestBody](../../models/operations/updateorganizationmembershiprequestbody.md) | :heavy_check_mark:                                                                                                                | N/A                                                                                                                               |

### Response

**[Crystalline::Nilable.new(Models::Operations::UpdateOrganizationMembershipResponse)](../../models/operations/updateorganizationmembershipresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 404, 422                    | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## delete

Removes the given membership from the organization

### Example Usage

<!-- UsageSnippet language="ruby" operationID="DeleteOrganizationMembership" method="delete" path="/organizations/{organization_id}/memberships/{user_id}" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.organization_memberships.delete(organization_id: 'org_12345', user_id: 'user_67890')

unless res.organization_membership.nil?
  # handle response
end

```

### Parameters

| Parameter                                                   | Type                                                        | Required                                                    | Description                                                 |
| ----------------------------------------------------------- | ----------------------------------------------------------- | ----------------------------------------------------------- | ----------------------------------------------------------- |
| `organization_id`                                           | *::String*                                                  | :heavy_check_mark:                                          | The ID of the organization to which this membership belongs |
| `user_id`                                                   | *::String*                                                  | :heavy_check_mark:                                          | The ID of the user to which this membership belongs         |

### Response

**[Crystalline::Nilable.new(Models::Operations::DeleteOrganizationMembershipResponse)](../../models/operations/deleteorganizationmembershipresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 401, 404, 422               | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## update_metadata

Update an organization membership's metadata attributes by merging existing values with the provided parameters.
Metadata values will be updated via a deep merge. Deep means that any nested JSON objects will be merged as well.
You can remove metadata keys at any level by setting their value to `null`.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="UpdateOrganizationMembershipMetadata" method="patch" path="/organizations/{organization_id}/memberships/{user_id}/metadata" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.organization_memberships.update_metadata(organization_id: 'org_123456', user_id: 'user_654321', body: Models::Operations::UpdateOrganizationMembershipMetadataRequestBody.new(
  public_metadata: {

  },
  private_metadata: {

  }
))

unless res.organization_membership.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                                                                                   | Type                                                                                                                                                                        | Required                                                                                                                                                                    | Description                                                                                                                                                                 |
| --------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `organization_id`                                                                                                                                                           | *::String*                                                                                                                                                                  | :heavy_check_mark:                                                                                                                                                          | The ID of the organization to which this membership belongs                                                                                                                 |
| `user_id`                                                                                                                                                                   | *::String*                                                                                                                                                                  | :heavy_check_mark:                                                                                                                                                          | The ID of the user to which this membership belongs                                                                                                                         |
| `body`                                                                                                                                                                      | [Crystalline::Nilable.new(Models::Operations::UpdateOrganizationMembershipMetadataRequestBody)](../../models/operations/updateorganizationmembershipmetadatarequestbody.md) | :heavy_minus_sign:                                                                                                                                                          | N/A                                                                                                                                                                         |

### Response

**[Crystalline::Nilable.new(Models::Operations::UpdateOrganizationMembershipMetadataResponse)](../../models/operations/updateorganizationmembershipmetadataresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 404, 422               | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |