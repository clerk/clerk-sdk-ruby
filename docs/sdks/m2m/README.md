# M2m

## Overview

### Available Operations

* [create_token](#create_token) - Create a M2M Token
* [list_tokens](#list_tokens) - Get M2M Tokens
* [revoke_token](#revoke_token) - Revoke a M2M Token
* [verify_token](#verify_token) - Verify a M2M Token

## create_token

Creates a new M2M Token. Must be authenticated via a Machine Secret Key.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="createM2MToken" method="post" path="/m2m_tokens" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

req = Models::Operations::CreateM2MTokenRequest.new()

res = s.m2m.create_token(request: req)

unless res.object.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                     | Type                                                                                          | Required                                                                                      | Description                                                                                   |
| --------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------- |
| `request`                                                                                     | [Models::Operations::CreateM2MTokenRequest](../../models/operations/createm2mtokenrequest.md) | :heavy_check_mark:                                                                            | The request object to use for the request.                                                    |

### Response

**[Crystalline::Nilable.new(Models::Operations::CreateM2MTokenResponse)](../../models/operations/createm2mtokenresponse.md)**

### Errors

| Error Type                                    | Status Code                                   | Content Type                                  |
| --------------------------------------------- | --------------------------------------------- | --------------------------------------------- |
| Models::Errors::CreateM2MTokenBadRequestError | 400                                           | application/json                              |
| Models::Errors::CreateM2MTokenConflictError   | 409                                           | application/json                              |
| Errors::APIError                              | 4XX, 5XX                                      | \*/\*                                         |

## list_tokens

Fetches M2M tokens for a specific machine.

This endpoint can be authenticated by either a Machine Secret Key or by a Clerk Secret Key.

- When fetching M2M tokens with a Machine Secret Key, only tokens associated with the authenticated machine can be retrieved.
- When fetching M2M tokens with a Clerk Secret Key, tokens for any machine in the instance can be retrieved.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="getM2MTokens" method="get" path="/m2m_tokens" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

req = Models::Operations::GetM2MTokensRequest.new(
  subject: '<value>',
)

res = s.m2m.list_tokens(request: req)

unless res.object.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                 | Type                                                                                      | Required                                                                                  | Description                                                                               |
| ----------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------- |
| `request`                                                                                 | [Models::Operations::GetM2MTokensRequest](../../models/operations/getm2mtokensrequest.md) | :heavy_check_mark:                                                                        | The request object to use for the request.                                                |

### Response

**[Crystalline::Nilable.new(Models::Operations::GetM2MTokensResponse)](../../models/operations/getm2mtokensresponse.md)**

### Errors

| Error Type                                  | Status Code                                 | Content Type                                |
| ------------------------------------------- | ------------------------------------------- | ------------------------------------------- |
| Models::Errors::GetM2MTokensBadRequestError | 400                                         | application/json                            |
| Models::Errors::ForbiddenError              | 403                                         | application/json                            |
| Models::Errors::GetM2MTokensNotFoundError   | 404                                         | application/json                            |
| Errors::APIError                            | 4XX, 5XX                                    | \*/\*                                       |

## revoke_token

Revokes a M2M Token.

This endpoint can be authenticated by either a Machine Secret Key or by a Clerk Secret Key.

- When revoking a M2M Token with a Machine Secret Key, the token must managed by the Machine associated with the Machine Secret Key.
- When revoking a M2M Token with a Clerk Secret Key, any token on the Instance can be revoked.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="revokeM2MToken" method="post" path="/m2m_tokens/{m2m_token_id}/revoke" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.m2m.revoke_token(m2m_token_id: '<id>', body: Models::Operations::RevokeM2MTokenRequestBody.new())

unless res.object.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                             | Type                                                                                                  | Required                                                                                              | Description                                                                                           |
| ----------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------- |
| `m2m_token_id`                                                                                        | *::String*                                                                                            | :heavy_check_mark:                                                                                    | N/A                                                                                                   |
| `body`                                                                                                | [Models::Operations::RevokeM2MTokenRequestBody](../../models/operations/revokem2mtokenrequestbody.md) | :heavy_check_mark:                                                                                    | N/A                                                                                                   |

### Response

**[Crystalline::Nilable.new(Models::Operations::RevokeM2MTokenResponse)](../../models/operations/revokem2mtokenresponse.md)**

### Errors

| Error Type                                    | Status Code                                   | Content Type                                  |
| --------------------------------------------- | --------------------------------------------- | --------------------------------------------- |
| Models::Errors::RevokeM2MTokenBadRequestError | 400                                           | application/json                              |
| Models::Errors::RevokeM2MTokenNotFoundError   | 404                                           | application/json                              |
| Errors::APIError                              | 4XX, 5XX                                      | \*/\*                                         |

## verify_token

Verifies a M2M Token.

This endpoint can be authenticated by either a Machine Secret Key or by a Clerk Secret Key.

- When verifying a M2M Token with a Machine Secret Key, the token must be granted access to the Machine associated with the Machine Secret Key.
- When verifying a M2M Token with a Clerk Secret Key, any token on the Instance can be verified.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="verifyM2MToken" method="post" path="/m2m_tokens/verify" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

req = Models::Operations::VerifyM2MTokenRequest.new(
  token: '<value>',
)

res = s.m2m.verify_token(request: req)

unless res.object.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                     | Type                                                                                          | Required                                                                                      | Description                                                                                   |
| --------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------- |
| `request`                                                                                     | [Models::Operations::VerifyM2MTokenRequest](../../models/operations/verifym2mtokenrequest.md) | :heavy_check_mark:                                                                            | The request object to use for the request.                                                    |

### Response

**[Crystalline::Nilable.new(Models::Operations::VerifyM2MTokenResponse)](../../models/operations/verifym2mtokenresponse.md)**

### Errors

| Error Type                                    | Status Code                                   | Content Type                                  |
| --------------------------------------------- | --------------------------------------------- | --------------------------------------------- |
| Models::Errors::VerifyM2MTokenBadRequestError | 400                                           | application/json                              |
| Models::Errors::VerifyM2MTokenNotFoundError   | 404                                           | application/json                              |
| Errors::APIError                              | 4XX, 5XX                                      | \*/\*                                         |