# AdminPortalLinkTokens

## Overview

### Available Operations

* [create_admin_portal_link_token](#create_admin_portal_link_token) - Create an Admin Portal Link Token
* [revoke_admin_portal_link_token](#revoke_admin_portal_link_token) - Revoke an Admin Portal Link Token

## create_admin_portal_link_token

Create an Admin Portal Link Token

### Example Usage

<!-- UsageSnippet language="ruby" operationID="createAdminPortalLinkToken" method="post" path="/admin_portal_link_tokens" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)

req = Models::Operations::CreateAdminPortalLinkTokenRequest.new
res = s.admin_portal_link_tokens.create_admin_portal_link_token(request: req)

unless res.object.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                             | Type                                                                                                                  | Required                                                                                                              | Description                                                                                                           |
| --------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------- |
| `request`                                                                                                             | [Models::Operations::CreateAdminPortalLinkTokenRequest](../../models/operations/createadminportallinktokenrequest.md) | :heavy_check_mark:                                                                                                    | The request object to use for the request.                                                                            |

### Response

**[Crystalline::Nilable.new(Models::Operations::CreateAdminPortalLinkTokenResponse)](../../models/operations/createadminportallinktokenresponse.md)**

### Errors

| Error Type                                                  | Status Code                                                 | Content Type                                                |
| ----------------------------------------------------------- | ----------------------------------------------------------- | ----------------------------------------------------------- |
| Models::Errors::CreateAdminPortalLinkTokenBadRequestError   | 400                                                         | application/json                                            |
| Models::Errors::CreateAdminPortalLinkTokenUnauthorizedError | 401                                                         | application/json                                            |
| Models::Errors::CreateAdminPortalLinkTokenForbiddenError    | 403                                                         | application/json                                            |
| Models::Errors::CreateAdminPortalLinkTokenConflictError     | 409                                                         | application/json                                            |
| Errors::APIError                                            | 4XX, 5XX                                                    | \*/\*                                                       |

## revoke_admin_portal_link_token

Revoke an Admin Portal Link Token

### Example Usage

<!-- UsageSnippet language="ruby" operationID="revokeAdminPortalLinkToken" method="post" path="/admin_portal_link_tokens/{adminPortalLinkTokenID}/revoke" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.admin_portal_link_tokens.revoke_admin_portal_link_token(admin_portal_link_token_id: '<id>', body: Models::Operations::RevokeAdminPortalLinkTokenRequestBody.new)

unless res.object.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                                     | Type                                                                                                                          | Required                                                                                                                      | Description                                                                                                                   |
| ----------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------- |
| `admin_portal_link_token_id`                                                                                                  | *::String*                                                                                                                    | :heavy_check_mark:                                                                                                            | N/A                                                                                                                           |
| `body`                                                                                                                        | [Models::Operations::RevokeAdminPortalLinkTokenRequestBody](../../models/operations/revokeadminportallinktokenrequestbody.md) | :heavy_check_mark:                                                                                                            | N/A                                                                                                                           |

### Response

**[Crystalline::Nilable.new(Models::Operations::RevokeAdminPortalLinkTokenResponse)](../../models/operations/revokeadminportallinktokenresponse.md)**

### Errors

| Error Type                                                  | Status Code                                                 | Content Type                                                |
| ----------------------------------------------------------- | ----------------------------------------------------------- | ----------------------------------------------------------- |
| Models::Errors::RevokeAdminPortalLinkTokenBadRequestError   | 400                                                         | application/json                                            |
| Models::Errors::RevokeAdminPortalLinkTokenUnauthorizedError | 401                                                         | application/json                                            |
| Models::Errors::RevokeAdminPortalLinkTokenForbiddenError    | 403                                                         | application/json                                            |
| Models::Errors::RevokeAdminPortalLinkTokenNotFoundError     | 404                                                         | application/json                                            |
| Errors::APIError                                            | 4XX, 5XX                                                    | \*/\*                                                       |