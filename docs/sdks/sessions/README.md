# Sessions

## Overview

### Available Operations

* [list](#list) - List all sessions
* [create](#create) - Create a new active session
* [get](#get) - Retrieve a session
* [refresh](#refresh) - Refresh a session
* [revoke](#revoke) - Revoke a session
* [create_token](#create_token) - Create a session token
* [create_token_from_template](#create_token_from_template) - Create a session token from a JWT template

## list

Returns a list of all sessions.
The sessions are returned sorted by creation date, with the newest sessions appearing first.
**Deprecation Notice (2024-01-01):** All parameters were initially considered optional, however
moving forward at least one of `client_id` or `user_id` parameters should be provided.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="GetSessionList" method="get" path="/sessions" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)

req = Models::Operations::GetSessionListRequest.new(
  client_id: 'client_123',
  user_id: 'user_456',
  status: Models::Operations::GetSessionListStatus::ACTIVE
)
res = s.sessions.list(request: req)

unless res.session_list.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                     | Type                                                                                          | Required                                                                                      | Description                                                                                   |
| --------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------- |
| `request`                                                                                     | [Models::Operations::GetSessionListRequest](../../models/operations/getsessionlistrequest.md) | :heavy_check_mark:                                                                            | The request object to use for the request.                                                    |

### Response

**[Crystalline::Nilable.new(Models::Operations::GetSessionListResponse)](../../models/operations/getsessionlistresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 401, 422               | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## create

Create a new active session for the provided user ID.

**This operation is intended only for use in testing, and is not available for production instances.** If you are looking to generate a user session from the backend,
we recommend using the [Sign-in Tokens](https://clerk.com/docs/reference/backend-api/tag/Sign-in-Tokens#operation/CreateSignInToken) resource instead.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="createSession" method="post" path="/sessions" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)

req = nil
res = s.sessions.create(request: req)

unless res.session.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                   | Type                                                                                        | Required                                                                                    | Description                                                                                 |
| ------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------- |
| `request`                                                                                   | [Models::Operations::CreateSessionRequest](../../models/operations/createsessionrequest.md) | :heavy_check_mark:                                                                          | The request object to use for the request.                                                  |

### Response

**[Crystalline::Nilable.new(Models::Operations::CreateSessionResponse)](../../models/operations/createsessionresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 401, 404, 422          | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## get

Retrieve the details of a session

### Example Usage

<!-- UsageSnippet language="ruby" operationID="GetSession" method="get" path="/sessions/{session_id}" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.sessions.get(session_id: 'sess_1234567890abcdef')

unless res.session.nil?
  # handle response
end

```

### Parameters

| Parameter             | Type                  | Required              | Description           |
| --------------------- | --------------------- | --------------------- | --------------------- |
| `session_id`          | *::String*            | :heavy_check_mark:    | The ID of the session |

### Response

**[Crystalline::Nilable.new(Models::Operations::GetSessionResponse)](../../models/operations/getsessionresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 401, 404               | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## refresh

Refreshes a session by creating a new session token. A 401 is returned when there
are validation errors, which signals the SDKs to fall back to the handshake flow.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="RefreshSession" method="post" path="/sessions/{session_id}/refresh" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.sessions.refresh(session_id: '<id>')

unless res.session_refresh.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                                       | Type                                                                                                                            | Required                                                                                                                        | Description                                                                                                                     |
| ------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------- |
| `session_id`                                                                                                                    | *::String*                                                                                                                      | :heavy_check_mark:                                                                                                              | The ID of the session                                                                                                           |
| `body`                                                                                                                          | [Crystalline::Nilable.new(Models::Operations::RefreshSessionRequestBody)](../../models/operations/refreshsessionrequestbody.md) | :heavy_minus_sign:                                                                                                              | Refresh session parameters                                                                                                      |

### Response

**[Crystalline::Nilable.new(Models::Operations::RefreshSessionResponse)](../../models/operations/refreshsessionresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 401                    | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## revoke

Sets the status of a session as "revoked", which is an unauthenticated state.
In multi-session mode, a revoked session will still be returned along with its client object, however the user will need to sign in again.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="RevokeSession" method="post" path="/sessions/{session_id}/revoke" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.sessions.revoke(session_id: 'sess_1234567890abcdef')

unless res.session.nil?
  # handle response
end

```

### Parameters

| Parameter             | Type                  | Required              | Description           |
| --------------------- | --------------------- | --------------------- | --------------------- |
| `session_id`          | *::String*            | :heavy_check_mark:    | The ID of the session |

### Response

**[Crystalline::Nilable.new(Models::Operations::RevokeSessionResponse)](../../models/operations/revokesessionresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 401, 404               | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## create_token

Creates a session JSON Web Token (JWT) based on a session.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="CreateSessionToken" method="post" path="/sessions/{session_id}/tokens" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.sessions.create_token(session_id: '<id>')

unless res.object.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                                               | Type                                                                                                                                    | Required                                                                                                                                | Description                                                                                                                             |
| --------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------- |
| `session_id`                                                                                                                            | *::String*                                                                                                                              | :heavy_check_mark:                                                                                                                      | The ID of the session                                                                                                                   |
| `body`                                                                                                                                  | [Crystalline::Nilable.new(Models::Operations::CreateSessionTokenRequestBody)](../../models/operations/createsessiontokenrequestbody.md) | :heavy_minus_sign:                                                                                                                      | N/A                                                                                                                                     |

### Response

**[Crystalline::Nilable.new(Models::Operations::CreateSessionTokenResponse)](../../models/operations/createsessiontokenresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 401, 404                    | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## create_token_from_template

Creates a JSON Web Token (JWT) based on a session and a JWT Template name defined for your instance

### Example Usage

<!-- UsageSnippet language="ruby" operationID="CreateSessionTokenFromTemplate" method="post" path="/sessions/{session_id}/tokens/{template_name}" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.sessions.create_token_from_template(session_id: 'ses_123abcd4567', template_name: 'custom_hasura')

unless res.object.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                                                                       | Type                                                                                                                                                            | Required                                                                                                                                                        | Description                                                                                                                                                     |
| --------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `session_id`                                                                                                                                                    | *::String*                                                                                                                                                      | :heavy_check_mark:                                                                                                                                              | The ID of the session                                                                                                                                           |
| `template_name`                                                                                                                                                 | *::String*                                                                                                                                                      | :heavy_check_mark:                                                                                                                                              | The name of the JWT template defined in your instance (e.g. `custom_hasura`).                                                                                   |
| `body`                                                                                                                                                          | [Crystalline::Nilable.new(Models::Operations::CreateSessionTokenFromTemplateRequestBody)](../../models/operations/createsessiontokenfromtemplaterequestbody.md) | :heavy_minus_sign:                                                                                                                                              | N/A                                                                                                                                                             |

### Response

**[Crystalline::Nilable.new(Models::Operations::CreateSessionTokenFromTemplateResponse)](../../models/operations/createsessiontokenfromtemplateresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 401, 404                    | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |