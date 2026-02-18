# ActorTokens

## Overview

### Available Operations

* [create](#create) - Create actor token
* [revoke](#revoke) - Revoke actor token

## create

Create an actor token that can be used to impersonate the given user.
The `actor` parameter needs to include at least a "sub" key whose value is the ID of the actor (impersonating) user.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="CreateActorToken" method="post" path="/actor_tokens" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)

req = Models::Operations::CreateActorTokenRequest.new(
  user_id: 'user_1a2b3c',
  actor: Models::Operations::Actor.new(
    sub: 'user_2OEpKhcCN1Lat9NQ0G6puh7q5Rb'
  )
)
res = s.actor_tokens.create(request: req)

unless res.actor_token.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                         | Type                                                                                              | Required                                                                                          | Description                                                                                       |
| ------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------- |
| `request`                                                                                         | [Models::Operations::CreateActorTokenRequest](../../models/operations/createactortokenrequest.md) | :heavy_check_mark:                                                                                | The request object to use for the request.                                                        |

### Response

**[Crystalline::Nilable.new(Models::Operations::CreateActorTokenResponse)](../../models/operations/createactortokenresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 402, 422               | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## revoke

Revokes a pending actor token.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="RevokeActorToken" method="post" path="/actor_tokens/{actor_token_id}/revoke" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.actor_tokens.revoke(actor_token_id: 'act_tok_abcdefghijk')

unless res.actor_token.nil?
  # handle response
end

```

### Parameters

| Parameter                                | Type                                     | Required                                 | Description                              |
| ---------------------------------------- | ---------------------------------------- | ---------------------------------------- | ---------------------------------------- |
| `actor_token_id`                         | *::String*                               | :heavy_check_mark:                       | The ID of the actor token to be revoked. |

### Response

**[Crystalline::Nilable.new(Models::Operations::RevokeActorTokenResponse)](../../models/operations/revokeactortokenresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 404                    | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |