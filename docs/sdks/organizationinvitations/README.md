# OrganizationInvitations

## Overview

### Available Operations

* [get_all](#get_all) - Get a list of organization invitations for the current instance
* [create](#create) - Create and send an organization invitation
* [list](#list) - Get a list of organization invitations
* [bulk_create](#bulk_create) - Bulk create and send organization invitations
* [~~list_pending~~](#list_pending) - Get a list of pending organization invitations :warning: **Deprecated**
* [get](#get) - Retrieve an organization invitation by ID
* [revoke](#revoke) - Revoke a pending organization invitation

## get_all

This request returns the list of organization invitations for the instance.
Results can be paginated using the optional `limit` and `offset` query parameters.
You can filter them by providing the 'status' query parameter, that accepts multiple values.
You can change the order by providing the 'order' query parameter, that accepts multiple values.
You can filter by the invited user email address providing the `query` query parameter.
The organization invitations are ordered by descending creation date by default.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="ListInstanceOrganizationInvitations" method="get" path="/organization_invitations" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)

req = Models::Operations::ListInstanceOrganizationInvitationsRequest.new
res = s.organization_invitations.get_all(request: req)

unless res.organization_invitations_with_public_organization_data.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                                               | Type                                                                                                                                    | Required                                                                                                                                | Description                                                                                                                             |
| --------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------- |
| `request`                                                                                                                               | [Models::Operations::ListInstanceOrganizationInvitationsRequest](../../models/operations/listinstanceorganizationinvitationsrequest.md) | :heavy_check_mark:                                                                                                                      | The request object to use for the request.                                                                                              |

### Response

**[Crystalline::Nilable.new(Models::Operations::ListInstanceOrganizationInvitationsResponse)](../../models/operations/listinstanceorganizationinvitationsresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 404, 422               | application/json            |
| Models::Errors::ClerkErrors | 500                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## create

Creates a new organization invitation and sends an email to the provided `email_address` with a link to accept the invitation and join the organization.
You can specify the `role` for the invited organization member.

New organization invitations get a "pending" status until they are revoked by an organization administrator or accepted by the invitee.

The request body supports passing an optional `redirect_url` parameter.
When the invited user clicks the link to accept the invitation, they will be redirected to the URL provided.
Use this parameter to implement a custom invitation acceptance flow.

You can specify the ID of the user that will send the invitation with the `inviter_user_id` parameter.
That user must be a member with administrator privileges in the organization.
Only "admin" members can create organization invitations.

You can optionally provide public and private metadata for the organization invitation.
The public metadata are visible by both the Frontend and the Backend whereas the private ones only by the Backend.
When the organization invitation is accepted, the metadata will be transferred to the newly created organization membership.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="CreateOrganizationInvitation" method="post" path="/organizations/{organization_id}/invitations" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.organization_invitations.create(organization_id: 'org_12345', body: Models::Operations::CreateOrganizationInvitationRequestBody.new(
  email_address: 'user@example.com',
  inviter_user_id: 'user_67890',
  role: 'admin',
  public_metadata: {
    'key' => 'value',
  },
  private_metadata: {
    'private_key' => 'secret_value',
  },
  redirect_url: 'https://example.com/welcome'
))

unless res.organization_invitation.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                                                                   | Type                                                                                                                                                        | Required                                                                                                                                                    | Description                                                                                                                                                 |
| ----------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `organization_id`                                                                                                                                           | *::String*                                                                                                                                                  | :heavy_check_mark:                                                                                                                                          | The ID of the organization for which to send the invitation                                                                                                 |
| `body`                                                                                                                                                      | [Crystalline::Nilable.new(Models::Operations::CreateOrganizationInvitationRequestBody)](../../models/operations/createorganizationinvitationrequestbody.md) | :heavy_minus_sign:                                                                                                                                          | N/A                                                                                                                                                         |

### Response

**[Crystalline::Nilable.new(Models::Operations::CreateOrganizationInvitationResponse)](../../models/operations/createorganizationinvitationresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 403, 404, 422          | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## list

This request returns the list of organization invitations.
Results can be paginated using the optional `limit` and `offset` query parameters.
You can filter them by providing the 'status' query parameter, that accepts multiple values.
The organization invitations are ordered by descending creation date.
Most recent invitations will be returned first.
Any invitations created as a result of an Organization Domain are not included in the results.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="ListOrganizationInvitations" method="get" path="/organizations/{organization_id}/invitations" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)

req = Models::Operations::ListOrganizationInvitationsRequest.new(
  organization_id: 'org_12345'
)
res = s.organization_invitations.list(request: req)

unless res.organization_invitations.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                               | Type                                                                                                                    | Required                                                                                                                | Description                                                                                                             |
| ----------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------- |
| `request`                                                                                                               | [Models::Operations::ListOrganizationInvitationsRequest](../../models/operations/listorganizationinvitationsrequest.md) | :heavy_check_mark:                                                                                                      | The request object to use for the request.                                                                              |

### Response

**[Crystalline::Nilable.new(Models::Operations::ListOrganizationInvitationsResponse)](../../models/operations/listorganizationinvitationsresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 404, 422               | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## bulk_create

Creates new organization invitations in bulk and sends out emails to the provided email addresses with a link to accept the invitation and join the organization.

This endpoint is limited to a maximum of 10 invitations per API call. If you need to send more invitations, please make multiple requests.

You can specify a different `role` for each invited organization member.
New organization invitations get a "pending" status until they are revoked by an organization administrator or accepted by the invitee.
The request body supports passing an optional `redirect_url` parameter for each invitation.
When the invited user clicks the link to accept the invitation, they will be redirected to the provided URL.
Use this parameter to implement a custom invitation acceptance flow.
You can specify the ID of the user that will send the invitation with the `inviter_user_id` parameter. Each invitation
can have a different inviter user.
Inviter users must be members with administrator privileges in the organization.
Only "admin" members can create organization invitations.
You can optionally provide public and private metadata for each organization invitation. The public metadata are visible
by both the Frontend and the Backend, whereas the private metadata are only visible by the Backend.
When the organization invitation is accepted, the metadata will be transferred to the newly created organization membership.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="CreateOrganizationInvitationBulk" method="post" path="/organizations/{organization_id}/invitations/bulk" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.organization_invitations.bulk_create(organization_id: 'org_12345', body: [
  Models::Operations::CreateOrganizationInvitationBulkRequestBody.new(
    email_address: 'newmember@example.com',
    inviter_user_id: 'user_67890',
    role: 'admin',
    public_metadata: {

    },
    private_metadata: {

    },
    redirect_url: 'https://example.com/welcome'
  ),
])

unless res.organization_invitations.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                                                                     | Type                                                                                                                                                          | Required                                                                                                                                                      | Description                                                                                                                                                   |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `organization_id`                                                                                                                                             | *::String*                                                                                                                                                    | :heavy_check_mark:                                                                                                                                            | The organization ID.                                                                                                                                          |
| `body`                                                                                                                                                        | Crystalline::Array<[Models::Operations::CreateOrganizationInvitationBulkRequestBody](../../models/operations/createorganizationinvitationbulkrequestbody.md)> | :heavy_check_mark:                                                                                                                                            | N/A                                                                                                                                                           |

### Response

**[Crystalline::Nilable.new(Models::Operations::CreateOrganizationInvitationBulkResponse)](../../models/operations/createorganizationinvitationbulkresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 403, 404, 422          | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## ~~list_pending~~

This request returns the list of organization invitations with "pending" status.
These are the organization invitations that can still be used to join the organization, but have not been accepted by the invited user yet.
Results can be paginated using the optional `limit` and `offset` query parameters.
The organization invitations are ordered by descending creation date.
Most recent invitations will be returned first.
Any invitations created as a result of an Organization Domain are not included in the results.

> :warning: **DEPRECATED**: This will be removed in a future release, please migrate away from it as soon as possible.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="ListPendingOrganizationInvitations" method="get" path="/organizations/{organization_id}/invitations/pending" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.organization_invitations.list_pending(organization_id: 'org_12345', limit: 10, offset: 0)

unless res.organization_invitations.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                                                 | Type                                                                                                                                      | Required                                                                                                                                  | Description                                                                                                                               |
| ----------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------- |
| `organization_id`                                                                                                                         | *::String*                                                                                                                                | :heavy_check_mark:                                                                                                                        | The organization ID.                                                                                                                      |
| `limit`                                                                                                                                   | *Crystalline::Nilable.new(::Integer)*                                                                                                     | :heavy_minus_sign:                                                                                                                        | Applies a limit to the number of results returned.<br/>Can be used for paginating the results together with `offset`.                     |
| `offset`                                                                                                                                  | *Crystalline::Nilable.new(::Integer)*                                                                                                     | :heavy_minus_sign:                                                                                                                        | Skip the first `offset` results when paginating.<br/>Needs to be an integer greater or equal to zero.<br/>To be used in conjunction with `limit`. |

### Response

**[Crystalline::Nilable.new(Models::Operations::ListPendingOrganizationInvitationsResponse)](../../models/operations/listpendingorganizationinvitationsresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 404                    | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## get

Use this request to get an existing organization invitation by ID.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="GetOrganizationInvitation" method="get" path="/organizations/{organization_id}/invitations/{invitation_id}" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.organization_invitations.get(organization_id: 'org_123456789', invitation_id: 'inv_987654321')

unless res.organization_invitation.nil?
  # handle response
end

```

### Parameters

| Parameter                       | Type                            | Required                        | Description                     |
| ------------------------------- | ------------------------------- | ------------------------------- | ------------------------------- |
| `organization_id`               | *::String*                      | :heavy_check_mark:              | The organization ID.            |
| `invitation_id`                 | *::String*                      | :heavy_check_mark:              | The organization invitation ID. |

### Response

**[Crystalline::Nilable.new(Models::Operations::GetOrganizationInvitationResponse)](../../models/operations/getorganizationinvitationresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 403, 404               | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## revoke

Use this request to revoke a previously issued organization invitation.
Revoking an organization invitation makes it invalid; the invited user will no longer be able to join the organization with the revoked invitation.
Only organization invitations with "pending" status can be revoked.
The request accepts the `requesting_user_id` parameter to specify the user which revokes the invitation.
Only users with "admin" role can revoke invitations.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="RevokeOrganizationInvitation" method="post" path="/organizations/{organization_id}/invitations/{invitation_id}/revoke" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.organization_invitations.revoke(organization_id: 'org_123456', invitation_id: 'inv_123456', body: Models::Operations::RevokeOrganizationInvitationRequestBody.new(
  requesting_user_id: 'usr_12345'
))

unless res.organization_invitation.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                                                                   | Type                                                                                                                                                        | Required                                                                                                                                                    | Description                                                                                                                                                 |
| ----------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `organization_id`                                                                                                                                           | *::String*                                                                                                                                                  | :heavy_check_mark:                                                                                                                                          | The organization ID.                                                                                                                                        |
| `invitation_id`                                                                                                                                             | *::String*                                                                                                                                                  | :heavy_check_mark:                                                                                                                                          | The organization invitation ID.                                                                                                                             |
| `body`                                                                                                                                                      | [Crystalline::Nilable.new(Models::Operations::RevokeOrganizationInvitationRequestBody)](../../models/operations/revokeorganizationinvitationrequestbody.md) | :heavy_minus_sign:                                                                                                                                          | N/A                                                                                                                                                         |

### Response

**[Crystalline::Nilable.new(Models::Operations::RevokeOrganizationInvitationResponse)](../../models/operations/revokeorganizationinvitationresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 403, 404               | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |