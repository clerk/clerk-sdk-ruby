# SsoBypassAllowlistUsers

## Overview

### Available Operations

* [list](#list) - List the SSO bypass allowlist
* [create](#create) - Add a user to the SSO bypass allowlist
* [delete](#delete) - Remove a user from the SSO bypass allowlist

## list

Returns the users who may verify an email code instead of reaching their identity provider when
enterprise SSO is unreachable.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="ListSSOBypassAllowlistUsers" method="get" path="/sso_bypass_allowlist_users" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.sso_bypass_allowlist_users.list

unless res.sso_bypass_allowlist_users.nil?
  # handle response
end

```

### Parameters

| Parameter                                                         | Type                                                              | Required                                                          | Description                                                       |
| ----------------------------------------------------------------- | ----------------------------------------------------------------- | ----------------------------------------------------------------- | ----------------------------------------------------------------- |
| `enterprise_connection_id`                                        | *Crystalline::Nilable.new(::String)*                              | :heavy_minus_sign:                                                | Restrict the list to the users this enterprise connection serves. |

### Response

**[Crystalline::Nilable.new(Models::Operations::ListSSOBypassAllowlistUsersResponse)](../../models/operations/listssobypassallowlistusersresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 403, 404                    | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## create

Puts a user on the allowlist. The request is rejected unless the user holds a verified email
address on a domain one of the instance's enterprise connections serves.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="CreateSSOBypassAllowlistUser" method="post" path="/sso_bypass_allowlist_users" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)

req = Models::Operations::CreateSSOBypassAllowlistUserRequest.new(
  user_id: '<id>'
)
res = s.sso_bypass_allowlist_users.create(request: req)

unless res.sso_bypass_allowlist_user.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                                 | Type                                                                                                                      | Required                                                                                                                  | Description                                                                                                               |
| ------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------- |
| `request`                                                                                                                 | [Models::Operations::CreateSSOBypassAllowlistUserRequest](../../models/operations/createssobypassallowlistuserrequest.md) | :heavy_check_mark:                                                                                                        | The request object to use for the request.                                                                                |

### Response

**[Crystalline::Nilable.new(Models::Operations::CreateSSOBypassAllowlistUserResponse)](../../models/operations/createssobypassallowlistuserresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 402, 403, 404, 422          | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## delete

Removes the user from the allowlist, across every enterprise connection that serves them.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="DeleteSSOBypassAllowlistUser" method="delete" path="/sso_bypass_allowlist_users/{userID}" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.sso_bypass_allowlist_users.delete(user_id: '<id>')

unless res.deleted_object.nil?
  # handle response
end

```

### Parameters

| Parameter                      | Type                           | Required                       | Description                    |
| ------------------------------ | ------------------------------ | ------------------------------ | ------------------------------ |
| `user_id`                      | *::String*                     | :heavy_check_mark:             | The ID of the allowlisted user |

### Response

**[Crystalline::Nilable.new(Models::Operations::DeleteSSOBypassAllowlistUserResponse)](../../models/operations/deletessobypassallowlistuserresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 403, 404                    | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |