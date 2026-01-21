# SignInTokens

## Overview

### Available Operations

* [create](#create) - Create sign-in token
* [revoke](#revoke) - Revoke the given sign-in token

## create

Creates a new sign-in token and associates it with the given user.
By default, sign-in tokens expire in 30 days.
You can optionally supply a different duration in seconds using the `expires_in_seconds` property.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="CreateSignInToken" method="post" path="/sign_in_tokens" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

req = Models::Operations::CreateSignInTokenRequest.new(
  user_id: 'user_12345',
)

res = s.sign_in_tokens.create(request: req)

unless res.sign_in_token.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                           | Type                                                                                                | Required                                                                                            | Description                                                                                         |
| --------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------- |
| `request`                                                                                           | [Models::Operations::CreateSignInTokenRequest](../../models/operations/createsignintokenrequest.md) | :heavy_check_mark:                                                                                  | The request object to use for the request.                                                          |

### Response

**[Crystalline::Nilable.new(Models::Operations::CreateSignInTokenResponse)](../../models/operations/createsignintokenresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 404, 422                    | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## revoke

Revokes a pending sign-in token

### Example Usage

<!-- UsageSnippet language="ruby" operationID="RevokeSignInToken" method="post" path="/sign_in_tokens/{sign_in_token_id}/revoke" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.sign_in_tokens.revoke(sign_in_token_id: 'tok_test_1234567890')

unless res.sign_in_token.nil?
  # handle response
end

```

### Parameters

| Parameter                                 | Type                                      | Required                                  | Description                               |
| ----------------------------------------- | ----------------------------------------- | ----------------------------------------- | ----------------------------------------- |
| `sign_in_token_id`                        | *::String*                                | :heavy_check_mark:                        | The ID of the sign-in token to be revoked |

### Response

**[Crystalline::Nilable.new(Models::Operations::RevokeSignInTokenResponse)](../../models/operations/revokesignintokenresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 404                    | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |