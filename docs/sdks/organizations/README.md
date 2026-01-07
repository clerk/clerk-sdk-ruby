# Organizations

## Overview

### Available Operations

* [list](#list) - Get a list of organizations for an instance
* [create](#create) - Create an organization
* [get](#get) - Retrieve an organization by ID or slug
* [update](#update) - Update an organization
* [delete](#delete) - Delete an organization
* [merge_metadata](#merge_metadata) - Merge and update metadata for an organization
* [upload_logo](#upload_logo) - Upload a logo for the organization
* [delete_logo](#delete_logo) - Delete the organization's logo.
* [get_billing_subscription](#get_billing_subscription) - Retrieve an organization's billing subscription

## list

This request returns the list of organizations for an instance.
Results can be paginated using the optional `limit` and `offset` query parameters.
The organizations are ordered by descending creation date.
Most recent organizations will be returned first.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="ListOrganizations" method="get" path="/organizations" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

req = Models::Operations::ListOrganizationsRequest.new(
  query: 'false',
  user_id: [
    'clerk',
  ],
  organization_id: [
    '-name',
  ],
)

res = s.organizations.list(request: req)

unless res.organizations.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                           | Type                                                                                                | Required                                                                                            | Description                                                                                         |
| --------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------- |
| `request`                                                                                           | [Models::Operations::ListOrganizationsRequest](../../models/operations/listorganizationsrequest.md) | :heavy_check_mark:                                                                                  | The request object to use for the request.                                                          |

### Response

**[Crystalline::Nilable.new(Models::Operations::ListOrganizationsResponse)](../../models/operations/listorganizationsresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 403, 422               | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## create

Creates a new organization with the given name for an instance.
You can specify an optional slug for the new organization.
If provided, the organization slug can contain only lowercase alphanumeric characters (letters and digits) and the dash "-".
Organization slugs must be unique for the instance.
You can provide additional metadata for the organization and set any custom attribute you want.
Organizations support private and public metadata.
Private metadata can only be accessed from the Backend API.
Public metadata can be accessed from the Backend API, and are read-only from the Frontend API.
The `created_by` user will see this as their [active organization](https://clerk.com/docs/organizations/overview#active-organization)
the next time they create a session, presuming they don't explicitly set a different organization as active before then.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="CreateOrganization" method="post" path="/organizations" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

req = Models::Operations::CreateOrganizationRequest.new(
  name: 'NewOrg',
  created_by: 'user_123',
  private_metadata: {
    "internal_code": 'ABC123',
  },
  public_metadata: {
    "public_event": 'Annual Summit',
  },
  slug: 'neworg',
  max_allowed_memberships: 100,
)

res = s.organizations.create(request: req)

unless res.organization.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                             | Type                                                                                                  | Required                                                                                              | Description                                                                                           |
| ----------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------- |
| `request`                                                                                             | [Models::Operations::CreateOrganizationRequest](../../models/operations/createorganizationrequest.md) | :heavy_check_mark:                                                                                    | The request object to use for the request.                                                            |

### Response

**[Crystalline::Nilable.new(Models::Operations::CreateOrganizationResponse)](../../models/operations/createorganizationresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 403, 422               | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## get

Fetches the organization whose ID or slug matches the provided `id_or_slug` URL query parameter.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="GetOrganization" method="get" path="/organizations/{organization_id}" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.organizations.get(organization_id: 'org_123')

unless res.organization.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                                      | Type                                                                                                                           | Required                                                                                                                       | Description                                                                                                                    |
| ------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------ |
| `organization_id`                                                                                                              | *::String*                                                                                                                     | :heavy_check_mark:                                                                                                             | The ID or slug of the organization                                                                                             |
| `include_members_count`                                                                                                        | *Crystalline::Nilable.new(Crystalline::Boolean.new)*                                                                           | :heavy_minus_sign:                                                                                                             | Flag to denote whether or not the organization's members count should be included in the response.                             |
| `include_missing_member_with_elevated_permissions`                                                                             | *Crystalline::Nilable.new(Crystalline::Boolean.new)*                                                                           | :heavy_minus_sign:                                                                                                             | Flag to denote whether or not to include a member with elevated permissions who is not currently a member of the organization. |

### Response

**[Crystalline::Nilable.new(Models::Operations::GetOrganizationResponse)](../../models/operations/getorganizationresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 403, 404                    | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## update

Updates an existing organization

### Example Usage

<!-- UsageSnippet language="ruby" operationID="UpdateOrganization" method="patch" path="/organizations/{organization_id}" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.organizations.update(organization_id: 'org_123_update', body: Models::Operations::UpdateOrganizationRequestBody.new())

unless res.organization.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                     | Type                                                                                                          | Required                                                                                                      | Description                                                                                                   |
| ------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------- |
| `organization_id`                                                                                             | *::String*                                                                                                    | :heavy_check_mark:                                                                                            | The ID of the organization to update                                                                          |
| `body`                                                                                                        | [Models::Operations::UpdateOrganizationRequestBody](../../models/operations/updateorganizationrequestbody.md) | :heavy_check_mark:                                                                                            | N/A                                                                                                           |

### Response

**[Crystalline::Nilable.new(Models::Operations::UpdateOrganizationResponse)](../../models/operations/updateorganizationresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 402, 403, 404, 422          | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## delete

Deletes the given organization.
Please note that deleting an organization will also delete all memberships and invitations.
This is not reversible.

After the organization is deleted, any user's active sessions that contain the deleted
organization will be cleared.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="DeleteOrganization" method="delete" path="/organizations/{organization_id}" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.organizations.delete(organization_id: 'org_321_delete')

unless res.deleted_object.nil?
  # handle response
end

```

### Parameters

| Parameter                            | Type                                 | Required                             | Description                          |
| ------------------------------------ | ------------------------------------ | ------------------------------------ | ------------------------------------ |
| `organization_id`                    | *::String*                           | :heavy_check_mark:                   | The ID of the organization to delete |

### Response

**[Crystalline::Nilable.new(Models::Operations::DeleteOrganizationResponse)](../../models/operations/deleteorganizationresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 404                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## merge_metadata

Update organization metadata attributes by merging existing values with the provided parameters.
Metadata values will be updated via a deep merge.
Deep meaning that any nested JSON objects will be merged as well.
You can remove metadata keys at any level by setting their value to `null`.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="MergeOrganizationMetadata" method="patch" path="/organizations/{organization_id}/metadata" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.organizations.merge_metadata(organization_id: 'org_12345', body: Models::Operations::MergeOrganizationMetadataRequestBody.new())

unless res.organization.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                                   | Type                                                                                                                        | Required                                                                                                                    | Description                                                                                                                 |
| --------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------- |
| `organization_id`                                                                                                           | *::String*                                                                                                                  | :heavy_check_mark:                                                                                                          | The ID of the organization for which metadata will be merged or updated                                                     |
| `body`                                                                                                                      | [Models::Operations::MergeOrganizationMetadataRequestBody](../../models/operations/mergeorganizationmetadatarequestbody.md) | :heavy_check_mark:                                                                                                          | N/A                                                                                                                         |

### Response

**[Crystalline::Nilable.new(Models::Operations::MergeOrganizationMetadataResponse)](../../models/operations/mergeorganizationmetadataresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 401, 404, 422          | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## upload_logo

Set or replace an organization's logo, by uploading an image file.
This endpoint uses the `multipart/form-data` request content type and accepts a file of image type.
The file size cannot exceed 10MB.
Only the following file content types are supported: `image/jpeg`, `image/png`, `image/gif`, `image/webp`.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="UploadOrganizationLogo" method="put" path="/organizations/{organization_id}/logo" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.organizations.upload_logo(organization_id: 'org_12345', body: Models::Operations::UploadOrganizationLogoRequestBody.new(
  uploader_user_id: 'user_67890',
  file: Models::Operations::UploadOrganizationLogoFile.new(
    file_name: 'example.file',
    content: File.binread("example.file"),
  ),
))

unless res.organization_with_logo.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                                                       | Type                                                                                                                                            | Required                                                                                                                                        | Description                                                                                                                                     |
| ----------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------- |
| `organization_id`                                                                                                                               | *::String*                                                                                                                                      | :heavy_check_mark:                                                                                                                              | The ID of the organization for which to upload a logo                                                                                           |
| `body`                                                                                                                                          | [Crystalline::Nilable.new(Models::Operations::UploadOrganizationLogoRequestBody)](../../models/operations/uploadorganizationlogorequestbody.md) | :heavy_minus_sign:                                                                                                                              | N/A                                                                                                                                             |

### Response

**[Crystalline::Nilable.new(Models::Operations::UploadOrganizationLogoResponse)](../../models/operations/uploadorganizationlogoresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 403, 404, 413          | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## delete_logo

Delete the organization's logo.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="DeleteOrganizationLogo" method="delete" path="/organizations/{organization_id}/logo" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.organizations.delete_logo(organization_id: 'org_12345')

unless res.organization.nil?
  # handle response
end

```

### Parameters

| Parameter                                                      | Type                                                           | Required                                                       | Description                                                    |
| -------------------------------------------------------------- | -------------------------------------------------------------- | -------------------------------------------------------------- | -------------------------------------------------------------- |
| `organization_id`                                              | *::String*                                                     | :heavy_check_mark:                                             | The ID of the organization for which the logo will be deleted. |

### Response

**[Crystalline::Nilable.new(Models::Operations::DeleteOrganizationLogoResponse)](../../models/operations/deleteorganizationlogoresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 404                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## get_billing_subscription

Retrieves the billing subscription for the specified organization.
This includes subscription details, active plans, billing information, and payment status.
The subscription contains subscription items which represent the individual plans the organization is subscribed to.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="GetOrganizationBillingSubscription" method="get" path="/organizations/{organization_id}/billing/subscription" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.organizations.get_billing_subscription(organization_id: '<id>')

unless res.commerce_subscription.nil?
  # handle response
end

```

### Parameters

| Parameter                                                 | Type                                                      | Required                                                  | Description                                               |
| --------------------------------------------------------- | --------------------------------------------------------- | --------------------------------------------------------- | --------------------------------------------------------- |
| `organization_id`                                         | *::String*                                                | :heavy_check_mark:                                        | The ID of the organization whose subscription to retrieve |

### Response

**[Crystalline::Nilable.new(Models::Operations::GetOrganizationBillingSubscriptionResponse)](../../models/operations/getorganizationbillingsubscriptionresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 401, 403, 404, 422     | application/json            |
| Models::Errors::ClerkErrors | 500                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |