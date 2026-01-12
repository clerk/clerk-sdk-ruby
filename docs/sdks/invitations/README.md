# Invitations

## Overview

### Available Operations

* [create](#create) - Create an invitation
* [list](#list) - List all invitations
* [bulk_create](#bulk_create) - Create multiple invitations
* [revoke](#revoke) - Revokes an invitation

## create

Creates a new invitation for the given email address and sends the invitation email.
Keep in mind that you cannot create an invitation if there is already one for the given email address.
Also, trying to create an invitation for an email address that already exists in your application will result to an error.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="CreateInvitation" method="post" path="/invitations" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

req = Models::Operations::CreateInvitationRequest.new(
  email_address: 'user@example.com',
  public_metadata: {

  },
  redirect_url: 'https://example.com/welcome',
)

res = s.invitations.create(request: req)

unless res.invitation.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                         | Type                                                                                              | Required                                                                                          | Description                                                                                       |
| ------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------- |
| `request`                                                                                         | [Models::Operations::CreateInvitationRequest](../../models/operations/createinvitationrequest.md) | :heavy_check_mark:                                                                                | The request object to use for the request.                                                        |

### Response

**[Crystalline::Nilable.new(Models::Operations::CreateInvitationResponse)](../../models/operations/createinvitationresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 422                    | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## list

Returns all non-revoked invitations for your application, sorted by creation date

### Example Usage

<!-- UsageSnippet language="ruby" operationID="ListInvitations" method="get" path="/invitations" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

req = Models::Operations::ListInvitationsRequest.new()

res = s.invitations.list(request: req)

unless res.invitation_list.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                       | Type                                                                                            | Required                                                                                        | Description                                                                                     |
| ----------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------- |
| `request`                                                                                       | [Models::Operations::ListInvitationsRequest](../../models/operations/listinvitationsrequest.md) | :heavy_check_mark:                                                                              | The request object to use for the request.                                                      |

### Response

**[Crystalline::Nilable.new(Models::Operations::ListInvitationsResponse)](../../models/operations/listinvitationsresponse.md)**

### Errors

| Error Type       | Status Code      | Content Type     |
| ---------------- | ---------------- | ---------------- |
| Errors::APIError | 4XX, 5XX         | \*/\*            |

## bulk_create

Use this API operation to create multiple invitations for the provided email addresses. You can choose to send the
invitations as emails by setting the `notify` parameter to `true`. There cannot be an existing invitation for any
of the email addresses you provide unless you set `ignore_existing` to `true` for specific email addresses. Please
note that there must be no existing user for any of the email addresses you provide, and this rule cannot be bypassed.

This endpoint is limited to a maximum of 10 invitations per API call. If you need to send more invitations, please make multiple requests.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="CreateBulkInvitations" method="post" path="/invitations/bulk" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

req = 

res = s.invitations.bulk_create(request: req)

unless res.invitation_list.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                         | Type                                                                                              | Required                                                                                          | Description                                                                                       |
| ------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------- |
| `request`                                                                                         | [Crystalline::Array.new(Models::Operations::CreateBulkInvitationsRequestBody)](../../models//.md) | :heavy_check_mark:                                                                                | The request object to use for the request.                                                        |

### Response

**[Crystalline::Nilable.new(Models::Operations::CreateBulkInvitationsResponse)](../../models/operations/createbulkinvitationsresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 422                    | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## revoke

Revokes the given invitation.
Revoking an invitation will prevent the user from using the invitation link that was sent to them.
However, it doesn't prevent the user from signing up if they follow the sign up flow.
Only active (i.e. non-revoked) invitations can be revoked.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="RevokeInvitation" method="post" path="/invitations/{invitation_id}/revoke" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.invitations.revoke(invitation_id: 'inv_123')

unless res.invitation_revoked.nil?
  # handle response
end

```

### Parameters

| Parameter                              | Type                                   | Required                               | Description                            |
| -------------------------------------- | -------------------------------------- | -------------------------------------- | -------------------------------------- |
| `invitation_id`                        | *::String*                             | :heavy_check_mark:                     | The ID of the invitation to be revoked |

### Response

**[Crystalline::Nilable.new(Models::Operations::RevokeInvitationResponse)](../../models/operations/revokeinvitationresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 404                    | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |