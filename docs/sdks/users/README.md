# Users

## Overview

### Available Operations

* [list](#list) - List all users
* [create](#create) - Create a new user
* [count](#count) - Count users
* [get](#get) - Retrieve a user
* [update](#update) - Update a user
* [delete](#delete) - Delete a user
* [ban](#ban) - Ban a user
* [unban](#unban) - Unban a user
* [bulk_ban](#bulk_ban) - Ban multiple users
* [bulk_unban](#bulk_unban) - Unban multiple users
* [lock](#lock) - Lock a user
* [unlock](#unlock) - Unlock a user
* [set_profile_image](#set_profile_image) - Set user profile image
* [delete_profile_image](#delete_profile_image) - Delete user profile image
* [update_metadata](#update_metadata) - Merge and update a user's metadata
* [get_billing_subscription](#get_billing_subscription) - Retrieve a user's billing subscription
* [get_o_auth_access_token](#get_o_auth_access_token) - Retrieve the OAuth access token of a user
* [get_organization_memberships](#get_organization_memberships) - Retrieve all memberships for a user
* [get_organization_invitations](#get_organization_invitations) - Retrieve all invitations for a user
* [verify_password](#verify_password) - Verify the password of a user
* [verify_totp](#verify_totp) - Verify a TOTP or backup code for a user
* [disable_mfa](#disable_mfa) - Disable a user's MFA methods
* [delete_backup_codes](#delete_backup_codes) - Disable all user's Backup codes
* [delete_passkey](#delete_passkey) - Delete a user passkey
* [delete_web3_wallet](#delete_web3_wallet) - Delete a user web3 wallet
* [delete_totp](#delete_totp) - Delete all the user's TOTPs
* [delete_external_account](#delete_external_account) - Delete External Account
* [set_password_compromised](#set_password_compromised) - Set a user's password as compromised
* [unset_password_compromised](#unset_password_compromised) - Unset a user's password as compromised
* [get_instance_organization_memberships](#get_instance_organization_memberships) - Get a list of all organization memberships within an instance.

## list

Returns a list of all users.
The users are returned sorted by creation date, with the newest users appearing first.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="GetUserList" method="get" path="/users" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

req = Models::Operations::GetUserListRequest.new(
  email_address: [
    'test@example.com',
  ],
  phone_number: [
    '+12345678901',
  ],
  external_id: [
    'external-id-123',
  ],
  username: [
    'user123',
  ],
  web3_wallet: [
    '0x123456789abcdef0x123456789abcdef',
  ],
  user_id: [
    'user-id-123',
  ],
  organization_id: [
    'org-id-123',
  ],
  query: 'John',
  last_active_at_before: 1_700_690_400_000,
  last_active_at_after: 1_700_690_400_000,
  last_active_at_since: 1_700_690_400_000,
  created_at_before: 1_730_160_000_000,
  created_at_after: 1_730_160_000_000,
  last_sign_in_at_before: 1_700_690_400_000,
  last_sign_in_at_after: 1_700_690_400_000,
)

res = s.users.list(request: req)

unless res.user_list.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                               | Type                                                                                    | Required                                                                                | Description                                                                             |
| --------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------- |
| `request`                                                                               | [Models::Operations::GetUserListRequest](../../models/operations/getuserlistrequest.md) | :heavy_check_mark:                                                                      | The request object to use for the request.                                              |

### Response

**[Crystalline::Nilable.new(Models::Operations::GetUserListResponse)](../../models/operations/getuserlistresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 401, 422               | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## create

Creates a new user. Your user management settings determine how you should setup your user model.

Any email address and phone number created using this method will be marked as verified.

Note: If you are performing a migration, check out our guide on [zero downtime migrations](https://clerk.com/docs/deployments/migrate-overview).

The following rate limit rules apply to this endpoint: 1000 requests per 10 seconds for production instances and 100 requests per 10 seconds for development instances

### Example Usage

<!-- UsageSnippet language="ruby" operationID="CreateUser" method="post" path="/users" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

req = Models::Operations::CreateUserRequest.new()

res = s.users.create(request: req)

unless res.user.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                             | Type                                                                                  | Required                                                                              | Description                                                                           |
| ------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------- |
| `request`                                                                             | [Models::Operations::CreateUserRequest](../../models/operations/createuserrequest.md) | :heavy_check_mark:                                                                    | The request object to use for the request.                                            |

### Response

**[Crystalline::Nilable.new(Models::Operations::CreateUserResponse)](../../models/operations/createuserresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 401, 403, 422          | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## count

Returns a total count of all users that match the given filtering criteria.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="GetUsersCount" method="get" path="/users/count" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

req = Models::Operations::GetUsersCountRequest.new(
  email_address: [
    'user@example.com',
  ],
  phone_number: [
    '+1234567890',
  ],
  external_id: [
    'external-id-123',
  ],
  username: [
    'username123',
  ],
  web3_wallet: [
    '0x123456789abcdef',
  ],
  user_id: [
    'user-id-123',
  ],
  organization_id: [
    'John Doe',
  ],
  last_active_at_before: 1_700_690_400_000,
  last_active_at_after: 1_700_690_400_000,
  last_active_at_since: 1_700_690_400_000,
  created_at_before: 1_730_160_000_000,
  created_at_after: 1_730_160_000_000,
  last_sign_in_at_before: 1_700_690_400_000,
  last_sign_in_at_after: 1_700_690_400_000,
)

res = s.users.count(request: req)

unless res.total_count.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                   | Type                                                                                        | Required                                                                                    | Description                                                                                 |
| ------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------- |
| `request`                                                                                   | [Models::Operations::GetUsersCountRequest](../../models/operations/getuserscountrequest.md) | :heavy_check_mark:                                                                          | The request object to use for the request.                                                  |

### Response

**[Crystalline::Nilable.new(Models::Operations::GetUsersCountResponse)](../../models/operations/getuserscountresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 422                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## get

Retrieve the details of a user

### Example Usage

<!-- UsageSnippet language="ruby" operationID="GetUser" method="get" path="/users/{user_id}" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.users.get(user_id: 'usr_1')

unless res.user.nil?
  # handle response
end

```

### Parameters

| Parameter                      | Type                           | Required                       | Description                    |
| ------------------------------ | ------------------------------ | ------------------------------ | ------------------------------ |
| `user_id`                      | *::String*                     | :heavy_check_mark:             | The ID of the user to retrieve |

### Response

**[Crystalline::Nilable.new(Models::Operations::GetUserResponse)](../../models/operations/getuserresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 401, 404               | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## update

Update a user's attributes.

You can set the user's primary contact identifiers (email address and phone numbers) by updating the `primary_email_address_id` and `primary_phone_number_id` attributes respectively.
Both IDs should correspond to verified identifications that belong to the user.

You can remove a user's username by setting the username attribute to null or the blank string "".
This is a destructive action; the identification will be deleted forever.
Usernames can be removed only if they are optional in your instance settings and there's at least one other identifier which can be used for authentication.

This endpoint allows changing a user's password. When passing the `password` parameter directly you have two further options.
You can ignore the password policy checks for your instance by setting the `skip_password_checks` parameter to `true`.
You can also choose to sign the user out of all their active sessions on any device once the password is updated. Just set `sign_out_of_other_sessions` to `true`.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="UpdateUser" method="patch" path="/users/{user_id}" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.users.update(user_id: 'usr_1', body: Models::Operations::UpdateUserRequestBody.new())

unless res.user.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                     | Type                                                                                          | Required                                                                                      | Description                                                                                   |
| --------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------- |
| `user_id`                                                                                     | *::String*                                                                                    | :heavy_check_mark:                                                                            | The ID of the user to update                                                                  |
| `body`                                                                                        | [Models::Operations::UpdateUserRequestBody](../../models/operations/updateuserrequestbody.md) | :heavy_check_mark:                                                                            | N/A                                                                                           |

### Response

**[Crystalline::Nilable.new(Models::Operations::UpdateUserResponse)](../../models/operations/updateuserresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 401, 404, 422          | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## delete

Delete the specified user

### Example Usage

<!-- UsageSnippet language="ruby" operationID="DeleteUser" method="delete" path="/users/{user_id}" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.users.delete(user_id: 'usr_1')

unless res.deleted_object.nil?
  # handle response
end

```

### Parameters

| Parameter                    | Type                         | Required                     | Description                  |
| ---------------------------- | ---------------------------- | ---------------------------- | ---------------------------- |
| `user_id`                    | *::String*                   | :heavy_check_mark:           | The ID of the user to delete |

### Response

**[Crystalline::Nilable.new(Models::Operations::DeleteUserResponse)](../../models/operations/deleteuserresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 401, 404               | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## ban

Marks the given user as banned, which means that all their sessions are revoked and they are not allowed to sign in again.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="BanUser" method="post" path="/users/{user_id}/ban" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.users.ban(user_id: 'user_12345')

unless res.user.nil?
  # handle response
end

```

### Parameters

| Parameter                 | Type                      | Required                  | Description               |
| ------------------------- | ------------------------- | ------------------------- | ------------------------- |
| `user_id`                 | *::String*                | :heavy_check_mark:        | The ID of the user to ban |

### Response

**[Crystalline::Nilable.new(Models::Operations::BanUserResponse)](../../models/operations/banuserresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 402                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## unban

Removes the ban mark from the given user.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="UnbanUser" method="post" path="/users/{user_id}/unban" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.users.unban(user_id: 'user_12345')

unless res.user.nil?
  # handle response
end

```

### Parameters

| Parameter                   | Type                        | Required                    | Description                 |
| --------------------------- | --------------------------- | --------------------------- | --------------------------- |
| `user_id`                   | *::String*                  | :heavy_check_mark:          | The ID of the user to unban |

### Response

**[Crystalline::Nilable.new(Models::Operations::UnbanUserResponse)](../../models/operations/unbanuserresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 402                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## bulk_ban

Marks multiple users as banned, which means that all their sessions are revoked and they are not allowed to sign in again.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="UsersBan" method="post" path="/users/ban" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

req = Models::Operations::UsersBanRequest.new(
  user_ids: [
    '<value 1>',
    '<value 2>',
    '<value 3>',
  ],
)

res = s.users.bulk_ban(request: req)

unless res.user_list.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                         | Type                                                                              | Required                                                                          | Description                                                                       |
| --------------------------------------------------------------------------------- | --------------------------------------------------------------------------------- | --------------------------------------------------------------------------------- | --------------------------------------------------------------------------------- |
| `request`                                                                         | [Models::Operations::UsersBanRequest](../../models/operations/usersbanrequest.md) | :heavy_check_mark:                                                                | The request object to use for the request.                                        |

### Response

**[Crystalline::Nilable.new(Models::Operations::UsersBanResponse)](../../models/operations/usersbanresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 402                    | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## bulk_unban

Removes the ban mark from multiple users.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="UsersUnban" method="post" path="/users/unban" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

req = Models::Operations::UsersUnbanRequest.new(
  user_ids: [
    '<value 1>',
    '<value 2>',
    '<value 3>',
  ],
)

res = s.users.bulk_unban(request: req)

unless res.user_list.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                             | Type                                                                                  | Required                                                                              | Description                                                                           |
| ------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------- |
| `request`                                                                             | [Models::Operations::UsersUnbanRequest](../../models/operations/usersunbanrequest.md) | :heavy_check_mark:                                                                    | The request object to use for the request.                                            |

### Response

**[Crystalline::Nilable.new(Models::Operations::UsersUnbanResponse)](../../models/operations/usersunbanresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 402                    | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## lock

Marks the given user as locked, which means they are not allowed to sign in again until the lock expires.
Lock duration can be configured in the instance's restrictions settings.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="LockUser" method="post" path="/users/{user_id}/lock" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.users.lock(user_id: 'user_123456789')

unless res.user.nil?
  # handle response
end

```

### Parameters

| Parameter                  | Type                       | Required                   | Description                |
| -------------------------- | -------------------------- | -------------------------- | -------------------------- |
| `user_id`                  | *::String*                 | :heavy_check_mark:         | The ID of the user to lock |

### Response

**[Crystalline::Nilable.new(Models::Operations::LockUserResponse)](../../models/operations/lockuserresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 403                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## unlock

Removes the lock from the given user.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="UnlockUser" method="post" path="/users/{user_id}/unlock" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.users.unlock(user_id: 'user_12345')

unless res.user.nil?
  # handle response
end

```

### Parameters

| Parameter                    | Type                         | Required                     | Description                  |
| ---------------------------- | ---------------------------- | ---------------------------- | ---------------------------- |
| `user_id`                    | *::String*                   | :heavy_check_mark:           | The ID of the user to unlock |

### Response

**[Crystalline::Nilable.new(Models::Operations::UnlockUserResponse)](../../models/operations/unlockuserresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 403                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## set_profile_image

Update a user's profile image

### Example Usage

<!-- UsageSnippet language="ruby" operationID="SetUserProfileImage" method="post" path="/users/{user_id}/profile_image" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.users.set_profile_image(user_id: 'usr_test123', body: Models::Operations::SetUserProfileImageRequestBody.new())

unless res.user.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                       | Type                                                                                                            | Required                                                                                                        | Description                                                                                                     |
| --------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------- |
| `user_id`                                                                                                       | *::String*                                                                                                      | :heavy_check_mark:                                                                                              | The ID of the user to update the profile image for                                                              |
| `body`                                                                                                          | [Models::Operations::SetUserProfileImageRequestBody](../../models/operations/setuserprofileimagerequestbody.md) | :heavy_check_mark:                                                                                              | N/A                                                                                                             |

### Response

**[Crystalline::Nilable.new(Models::Operations::SetUserProfileImageResponse)](../../models/operations/setuserprofileimageresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 401, 404               | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## delete_profile_image

Delete a user's profile image

### Example Usage

<!-- UsageSnippet language="ruby" operationID="DeleteUserProfileImage" method="delete" path="/users/{user_id}/profile_image" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.users.delete_profile_image(user_id: 'usr_test123')

unless res.user.nil?
  # handle response
end

```

### Parameters

| Parameter                                          | Type                                               | Required                                           | Description                                        |
| -------------------------------------------------- | -------------------------------------------------- | -------------------------------------------------- | -------------------------------------------------- |
| `user_id`                                          | *::String*                                         | :heavy_check_mark:                                 | The ID of the user to delete the profile image for |

### Response

**[Crystalline::Nilable.new(Models::Operations::DeleteUserProfileImageResponse)](../../models/operations/deleteuserprofileimageresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 404                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## update_metadata

Update a user's metadata attributes by merging existing values with the provided parameters.

This endpoint behaves differently than the *Update a user* endpoint.
Metadata values will not be replaced entirely.
Instead, a deep merge will be performed.
Deep means that any nested JSON objects will be merged as well.

You can remove metadata keys at any level by setting their value to `null`.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="UpdateUserMetadata" method="patch" path="/users/{user_id}/metadata" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.users.update_metadata(user_id: 'user_123456789')

unless res.user.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                                               | Type                                                                                                                                    | Required                                                                                                                                | Description                                                                                                                             |
| --------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------- |
| `user_id`                                                                                                                               | *::String*                                                                                                                              | :heavy_check_mark:                                                                                                                      | The ID of the user whose metadata will be updated and merged                                                                            |
| `body`                                                                                                                                  | [Crystalline::Nilable.new(Models::Operations::UpdateUserMetadataRequestBody)](../../models/operations/updateusermetadatarequestbody.md) | :heavy_minus_sign:                                                                                                                      | N/A                                                                                                                                     |

### Response

**[Crystalline::Nilable.new(Models::Operations::UpdateUserMetadataResponse)](../../models/operations/updateusermetadataresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 401, 404, 422          | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## get_billing_subscription

Retrieves the billing subscription for the specified user.
This includes subscription details, active plans, billing information, and payment status.
The subscription contains subscription items which represent the individual plans the user is subscribed to.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="GetUserBillingSubscription" method="get" path="/users/{user_id}/billing/subscription" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.users.get_billing_subscription(user_id: '<id>')

unless res.commerce_subscription.nil?
  # handle response
end

```

### Parameters

| Parameter                                         | Type                                              | Required                                          | Description                                       |
| ------------------------------------------------- | ------------------------------------------------- | ------------------------------------------------- | ------------------------------------------------- |
| `user_id`                                         | *::String*                                        | :heavy_check_mark:                                | The ID of the user whose subscription to retrieve |

### Response

**[Crystalline::Nilable.new(Models::Operations::GetUserBillingSubscriptionResponse)](../../models/operations/getuserbillingsubscriptionresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 401, 403, 404, 422     | application/json            |
| Models::Errors::ClerkErrors | 500                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## get_o_auth_access_token

Fetch the corresponding OAuth access token for a user that has previously authenticated with a particular OAuth provider.
For OAuth 2.0, if the access token has expired and we have a corresponding refresh token, the access token will be refreshed transparently the new one will be returned.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="GetOAuthAccessToken" method="get" path="/users/{user_id}/oauth_access_tokens/{provider}" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

req = Models::Operations::GetOAuthAccessTokenRequest.new(
  user_id: 'user_123',
  provider: 'oauth_google',
)

res = s.users.get_o_auth_access_token(request: req)

unless res.o_auth_access_token.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                               | Type                                                                                                    | Required                                                                                                | Description                                                                                             |
| ------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------- |
| `request`                                                                                               | [Models::Operations::GetOAuthAccessTokenRequest](../../models/operations/getoauthaccesstokenrequest.md) | :heavy_check_mark:                                                                                      | The request object to use for the request.                                                              |

### Response

**[Crystalline::Nilable.new(Models::Operations::GetOAuthAccessTokenResponse)](../../models/operations/getoauthaccesstokenresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 404, 422               | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## get_organization_memberships

Retrieve a paginated list of the user's organization memberships

### Example Usage

<!-- UsageSnippet language="ruby" operationID="UsersGetOrganizationMemberships" method="get" path="/users/{user_id}/organization_memberships" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.users.get_organization_memberships(user_id: 'usr_1234567890', limit: 10, offset: 0)

unless res.organization_memberships.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                                                 | Type                                                                                                                                      | Required                                                                                                                                  | Description                                                                                                                               |
| ----------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------- |
| `user_id`                                                                                                                                 | *::String*                                                                                                                                | :heavy_check_mark:                                                                                                                        | The ID of the user whose organization memberships we want to retrieve                                                                     |
| `limit`                                                                                                                                   | *Crystalline::Nilable.new(::Integer)*                                                                                                     | :heavy_minus_sign:                                                                                                                        | Applies a limit to the number of results returned.<br/>Can be used for paginating the results together with `offset`.                     |
| `offset`                                                                                                                                  | *Crystalline::Nilable.new(::Integer)*                                                                                                     | :heavy_minus_sign:                                                                                                                        | Skip the first `offset` results when paginating.<br/>Needs to be an integer greater or equal to zero.<br/>To be used in conjunction with `limit`. |

### Response

**[Crystalline::Nilable.new(Models::Operations::UsersGetOrganizationMembershipsResponse)](../../models/operations/usersgetorganizationmembershipsresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 403                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## get_organization_invitations

Retrieve a paginated list of the user's organization invitations

### Example Usage

<!-- UsageSnippet language="ruby" operationID="UsersGetOrganizationInvitations" method="get" path="/users/{user_id}/organization_invitations" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.users.get_organization_invitations(user_id: '<id>', limit: 10, offset: 0)

unless res.organization_invitations_with_public_organization_data.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                                                               | Type                                                                                                                                                    | Required                                                                                                                                                | Description                                                                                                                                             |
| ------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `user_id`                                                                                                                                               | *::String*                                                                                                                                              | :heavy_check_mark:                                                                                                                                      | The ID of the user whose organization invitations we want to retrieve                                                                                   |
| `limit`                                                                                                                                                 | *Crystalline::Nilable.new(::Integer)*                                                                                                                   | :heavy_minus_sign:                                                                                                                                      | Applies a limit to the number of results returned.<br/>Can be used for paginating the results together with `offset`.                                   |
| `offset`                                                                                                                                                | *Crystalline::Nilable.new(::Integer)*                                                                                                                   | :heavy_minus_sign:                                                                                                                                      | Skip the first `offset` results when paginating.<br/>Needs to be an integer greater or equal to zero.<br/>To be used in conjunction with `limit`.       |
| `status`                                                                                                                                                | [Crystalline::Nilable.new(Models::Operations::UsersGetOrganizationInvitationsStatus)](../../models/operations/usersgetorganizationinvitationsstatus.md) | :heavy_minus_sign:                                                                                                                                      | Filter organization invitations based on their status                                                                                                   |

### Response

**[Crystalline::Nilable.new(Models::Operations::UsersGetOrganizationInvitationsResponse)](../../models/operations/usersgetorganizationinvitationsresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 403, 404               | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## verify_password

Check that the user's password matches the supplied input.
Useful for custom auth flows and re-verification.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="VerifyPassword" method="post" path="/users/{user_id}/verify_password" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.users.verify_password(user_id: 'user_123', body: Models::Operations::VerifyPasswordRequestBody.new(
  password: 'securepassword123',
))

unless res.object.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                                       | Type                                                                                                                            | Required                                                                                                                        | Description                                                                                                                     |
| ------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------- |
| `user_id`                                                                                                                       | *::String*                                                                                                                      | :heavy_check_mark:                                                                                                              | The ID of the user for whom to verify the password                                                                              |
| `body`                                                                                                                          | [Crystalline::Nilable.new(Models::Operations::VerifyPasswordRequestBody)](../../models/operations/verifypasswordrequestbody.md) | :heavy_minus_sign:                                                                                                              | N/A                                                                                                                             |

### Response

**[Crystalline::Nilable.new(Models::Operations::VerifyPasswordResponse)](../../models/operations/verifypasswordresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 500                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## verify_totp

Verify that the provided TOTP or backup code is valid for the user.
Verifying a backup code will result it in being consumed (i.e. it will
become invalid).
Useful for custom auth flows and re-verification.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="VerifyTOTP" method="post" path="/users/{user_id}/verify_totp" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.users.verify_totp(user_id: 'usr_1a2b3c', body: Models::Operations::VerifyTOTPRequestBody.new(
  code: '123456',
))

unless res.object.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                               | Type                                                                                                                    | Required                                                                                                                | Description                                                                                                             |
| ----------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------- |
| `user_id`                                                                                                               | *::String*                                                                                                              | :heavy_check_mark:                                                                                                      | The ID of the user for whom to verify the TOTP                                                                          |
| `body`                                                                                                                  | [Crystalline::Nilable.new(Models::Operations::VerifyTOTPRequestBody)](../../models/operations/verifytotprequestbody.md) | :heavy_minus_sign:                                                                                                      | N/A                                                                                                                     |

### Response

**[Crystalline::Nilable.new(Models::Operations::VerifyTOTPResponse)](../../models/operations/verifytotpresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 500                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## disable_mfa

Disable all of a user's MFA methods (e.g. OTP sent via SMS, TOTP on their authenticator app) at once.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="DisableMFA" method="delete" path="/users/{user_id}/mfa" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.users.disable_mfa(user_id: 'user_123456')

unless res.object.nil?
  # handle response
end

```

### Parameters

| Parameter                                               | Type                                                    | Required                                                | Description                                             |
| ------------------------------------------------------- | ------------------------------------------------------- | ------------------------------------------------------- | ------------------------------------------------------- |
| `user_id`                                               | *::String*                                              | :heavy_check_mark:                                      | The ID of the user whose MFA methods are to be disabled |

### Response

**[Crystalline::Nilable.new(Models::Operations::DisableMFAResponse)](../../models/operations/disablemfaresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 404                         | application/json            |
| Models::Errors::ClerkErrors | 500                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## delete_backup_codes

Disable all of a user's backup codes.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="DeleteBackupCode" method="delete" path="/users/{user_id}/backup_code" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.users.delete_backup_codes(user_id: '<id>')

unless res.object.nil?
  # handle response
end

```

### Parameters

| Parameter                                                | Type                                                     | Required                                                 | Description                                              |
| -------------------------------------------------------- | -------------------------------------------------------- | -------------------------------------------------------- | -------------------------------------------------------- |
| `user_id`                                                | *::String*                                               | :heavy_check_mark:                                       | The ID of the user whose backup codes are to be deleted. |

### Response

**[Crystalline::Nilable.new(Models::Operations::DeleteBackupCodeResponse)](../../models/operations/deletebackupcoderesponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 404                         | application/json            |
| Models::Errors::ClerkErrors | 500                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## delete_passkey

Delete the passkey identification for a given user and notify them through email.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="UserPasskeyDelete" method="delete" path="/users/{user_id}/passkeys/{passkey_identification_id}" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.users.delete_passkey(user_id: '<id>', passkey_identification_id: '<id>')

unless res.deleted_object.nil?
  # handle response
end

```

### Parameters

| Parameter                                         | Type                                              | Required                                          | Description                                       |
| ------------------------------------------------- | ------------------------------------------------- | ------------------------------------------------- | ------------------------------------------------- |
| `user_id`                                         | *::String*                                        | :heavy_check_mark:                                | The ID of the user that owns the passkey identity |
| `passkey_identification_id`                       | *::String*                                        | :heavy_check_mark:                                | The ID of the passkey identity to be deleted      |

### Response

**[Crystalline::Nilable.new(Models::Operations::UserPasskeyDeleteResponse)](../../models/operations/userpasskeydeleteresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 403, 404                    | application/json            |
| Models::Errors::ClerkErrors | 500                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## delete_web3_wallet

Delete the web3 wallet identification for a given user.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="UserWeb3WalletDelete" method="delete" path="/users/{user_id}/web3_wallets/{web3_wallet_identification_id}" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.users.delete_web3_wallet(user_id: '<id>', web3_wallet_identification_id: '<id>')

unless res.deleted_object.nil?
  # handle response
end

```

### Parameters

| Parameter                                        | Type                                             | Required                                         | Description                                      |
| ------------------------------------------------ | ------------------------------------------------ | ------------------------------------------------ | ------------------------------------------------ |
| `user_id`                                        | *::String*                                       | :heavy_check_mark:                               | The ID of the user that owns the web3 wallet     |
| `web3_wallet_identification_id`                  | *::String*                                       | :heavy_check_mark:                               | The ID of the web3 wallet identity to be deleted |

### Response

**[Crystalline::Nilable.new(Models::Operations::UserWeb3WalletDeleteResponse)](../../models/operations/userweb3walletdeleteresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 403, 404               | application/json            |
| Models::Errors::ClerkErrors | 500                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## delete_totp

Deletes all of the user's TOTPs.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="DeleteTOTP" method="delete" path="/users/{user_id}/totp" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.users.delete_totp(user_id: '<id>')

unless res.object.nil?
  # handle response
end

```

### Parameters

| Parameter                                        | Type                                             | Required                                         | Description                                      |
| ------------------------------------------------ | ------------------------------------------------ | ------------------------------------------------ | ------------------------------------------------ |
| `user_id`                                        | *::String*                                       | :heavy_check_mark:                               | The ID of the user whose TOTPs are to be deleted |

### Response

**[Crystalline::Nilable.new(Models::Operations::DeleteTOTPResponse)](../../models/operations/deletetotpresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 404                         | application/json            |
| Models::Errors::ClerkErrors | 500                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## delete_external_account

Delete an external account by ID.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="DeleteExternalAccount" method="delete" path="/users/{user_id}/external_accounts/{external_account_id}" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.users.delete_external_account(user_id: '<id>', external_account_id: '<id>')

unless res.deleted_object.nil?
  # handle response
end

```

### Parameters

| Parameter                                | Type                                     | Required                                 | Description                              |
| ---------------------------------------- | ---------------------------------------- | ---------------------------------------- | ---------------------------------------- |
| `user_id`                                | *::String*                               | :heavy_check_mark:                       | The ID of the user's external account    |
| `external_account_id`                    | *::String*                               | :heavy_check_mark:                       | The ID of the external account to delete |

### Response

**[Crystalline::Nilable.new(Models::Operations::DeleteExternalAccountResponse)](../../models/operations/deleteexternalaccountresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 403, 404               | application/json            |
| Models::Errors::ClerkErrors | 500                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## set_password_compromised

Sets the given user's password as compromised. The user will be prompted to reset their password on their next sign-in.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="SetUserPasswordCompromised" method="post" path="/users/{user_id}/password/set_compromised" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.users.set_password_compromised(user_id: '<id>')

unless res.user.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                                                               | Type                                                                                                                                                    | Required                                                                                                                                                | Description                                                                                                                                             |
| ------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `user_id`                                                                                                                                               | *::String*                                                                                                                                              | :heavy_check_mark:                                                                                                                                      | The ID of the user to set the password as compromised                                                                                                   |
| `body`                                                                                                                                                  | [Crystalline::Nilable.new(Models::Operations::SetUserPasswordCompromisedRequestBody)](../../models/operations/setuserpasswordcompromisedrequestbody.md) | :heavy_minus_sign:                                                                                                                                      | N/A                                                                                                                                                     |

### Response

**[Crystalline::Nilable.new(Models::Operations::SetUserPasswordCompromisedResponse)](../../models/operations/setuserpasswordcompromisedresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 401, 403, 404, 422     | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## unset_password_compromised

Sets the given user's password as no longer compromised. The user will no longer be prompted to reset their password on their next sign-in.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="UnsetUserPasswordCompromised" method="post" path="/users/{user_id}/password/unset_compromised" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.users.unset_password_compromised(user_id: '<id>')

unless res.user.nil?
  # handle response
end

```

### Parameters

| Parameter                                              | Type                                                   | Required                                               | Description                                            |
| ------------------------------------------------------ | ------------------------------------------------------ | ------------------------------------------------------ | ------------------------------------------------------ |
| `user_id`                                              | *::String*                                             | :heavy_check_mark:                                     | The ID of the user to unset the compromised status for |

### Response

**[Crystalline::Nilable.new(Models::Operations::UnsetUserPasswordCompromisedResponse)](../../models/operations/unsetuserpasswordcompromisedresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 401, 403, 404, 422     | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## get_instance_organization_memberships

Retrieves all organization user memberships for the given instance.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="InstanceGetOrganizationMemberships" method="get" path="/organization_memberships" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.users.get_instance_organization_memberships(limit: 10, offset: 0)

unless res.organization_memberships.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                                                                                                                                          | Type                                                                                                                                                                                                                               | Required                                                                                                                                                                                                                           | Description                                                                                                                                                                                                                        |
| ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `order_by`                                                                                                                                                                                                                         | *Crystalline::Nilable.new(::String)*                                                                                                                                                                                               | :heavy_minus_sign:                                                                                                                                                                                                                 | Sorts organizations memberships by phone_number, email_address, created_at, first_name, last_name or username.<br/>By prepending one of those values with + or -,<br/>we can choose to sort in ascending (ASC) or descending (DESC) order. |
| `limit`                                                                                                                                                                                                                            | *Crystalline::Nilable.new(::Integer)*                                                                                                                                                                                              | :heavy_minus_sign:                                                                                                                                                                                                                 | Applies a limit to the number of results returned.<br/>Can be used for paginating the results together with `offset`.                                                                                                              |
| `offset`                                                                                                                                                                                                                           | *Crystalline::Nilable.new(::Integer)*                                                                                                                                                                                              | :heavy_minus_sign:                                                                                                                                                                                                                 | Skip the first `offset` results when paginating.<br/>Needs to be an integer greater or equal to zero.<br/>To be used in conjunction with `limit`.                                                                                  |

### Response

**[Crystalline::Nilable.new(Models::Operations::InstanceGetOrganizationMembershipsResponse)](../../models/operations/instancegetorganizationmembershipsresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 401, 422               | application/json            |
| Models::Errors::ClerkErrors | 500                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |