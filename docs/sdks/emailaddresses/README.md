# EmailAddresses

## Overview

### Available Operations

* [create](#create) - Create an email address
* [get](#get) - Retrieve an email address
* [delete](#delete) - Delete an email address
* [update](#update) - Update an email address
* [prepare_verification](#prepare_verification) - Send a verification code to an email address
* [attempt_verification](#attempt_verification) - Verify a code sent to an email address
* [replace_for_user](#replace_for_user) - Replace a user's email address

## create

Create a new email address

### Example Usage

<!-- UsageSnippet language="ruby" operationID="CreateEmailAddress" method="post" path="/email_addresses" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)

req = Models::Operations::CreateEmailAddressRequest.new(
  user_id: 'user_12345',
  email_address: 'example@clerk.com',
  verified: false,
  primary: true
)
res = s.email_addresses.create(request: req)

unless res.email_address.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                             | Type                                                                                                  | Required                                                                                              | Description                                                                                           |
| ----------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------- |
| `request`                                                                                             | [Models::Operations::CreateEmailAddressRequest](../../models/operations/createemailaddressrequest.md) | :heavy_check_mark:                                                                                    | The request object to use for the request.                                                            |

### Response

**[Crystalline::Nilable.new(Models::Operations::CreateEmailAddressResponse)](../../models/operations/createemailaddressresponse.md)**

### Errors

| Error Type                   | Status Code                  | Content Type                 |
| ---------------------------- | ---------------------------- | ---------------------------- |
| Models::Errors::ClerkErrors  | 400, 401, 403, 404, 409, 422 | application/json             |
| Errors::APIError             | 4XX, 5XX                     | \*/\*                        |

## get

Returns the details of an email address.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="GetEmailAddress" method="get" path="/email_addresses/{email_address_id}" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.email_addresses.get(email_address_id: 'email_address_id_example')

unless res.email_address.nil?
  # handle response
end

```

### Parameters

| Parameter                               | Type                                    | Required                                | Description                             |
| --------------------------------------- | --------------------------------------- | --------------------------------------- | --------------------------------------- |
| `email_address_id`                      | *::String*                              | :heavy_check_mark:                      | The ID of the email address to retrieve |

### Response

**[Crystalline::Nilable.new(Models::Operations::GetEmailAddressResponse)](../../models/operations/getemailaddressresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 401, 403, 404          | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## delete

Delete the email address with the given ID

### Example Usage

<!-- UsageSnippet language="ruby" operationID="DeleteEmailAddress" method="delete" path="/email_addresses/{email_address_id}" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.email_addresses.delete(email_address_id: 'email_address_id_example')

unless res.deleted_object.nil?
  # handle response
end

```

### Parameters

| Parameter                             | Type                                  | Required                              | Description                           |
| ------------------------------------- | ------------------------------------- | ------------------------------------- | ------------------------------------- |
| `email_address_id`                    | *::String*                            | :heavy_check_mark:                    | The ID of the email address to delete |

### Response

**[Crystalline::Nilable.new(Models::Operations::DeleteEmailAddressResponse)](../../models/operations/deleteemailaddressresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 401, 403, 404, 409     | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## update

Updates an email address.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="UpdateEmailAddress" method="patch" path="/email_addresses/{email_address_id}" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.email_addresses.update(email_address_id: 'email_address_id_example', body: Models::Operations::UpdateEmailAddressRequestBody.new(
  verified: false,
  primary: true
))

unless res.email_address.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                                               | Type                                                                                                                                    | Required                                                                                                                                | Description                                                                                                                             |
| --------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------- |
| `email_address_id`                                                                                                                      | *::String*                                                                                                                              | :heavy_check_mark:                                                                                                                      | The ID of the email address to update                                                                                                   |
| `body`                                                                                                                                  | [Crystalline::Nilable.new(Models::Operations::UpdateEmailAddressRequestBody)](../../models/operations/updateemailaddressrequestbody.md) | :heavy_minus_sign:                                                                                                                      | N/A                                                                                                                                     |

### Response

**[Crystalline::Nilable.new(Models::Operations::UpdateEmailAddressResponse)](../../models/operations/updateemailaddressresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 401, 403, 404, 409     | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## prepare_verification

Sends a one-time code to the given email address so that a backend can
verify the user controls it (for example, in a custom, backend-driven
sign-in flow). The code is tracked on its own verification; confirm it
with attempt_verification.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="PrepareEmailAddressVerification" method="post" path="/email_addresses/{email_address_id}/prepare_verification" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.email_addresses.prepare_verification(email_address_id: '<id>')

unless res.verification_response.nil?
  # handle response
end

```

### Parameters

| Parameter                                                    | Type                                                         | Required                                                     | Description                                                  |
| ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| `email_address_id`                                           | *::String*                                                   | :heavy_check_mark:                                           | The ID of the email address to send the verification code to |

### Response

**[Crystalline::Nilable.new(Models::Operations::PrepareEmailAddressVerificationResponse)](../../models/operations/prepareemailaddressverificationresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 401, 403, 404          | application/json            |
| Models::Errors::ClerkErrors | 500                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## attempt_verification

Checks a one-time code against the verification identified by
verification_id, and returns the verification with its updated status
(`verified`, `unverified`, `expired`, or `failed`) and attempt count, so a
backend driving its own frontend can react on every attempt — an incorrect
or expired code is reported through the status, not as an error. Resubmitting
a verification whose code was already accepted is rejected with a
`verification_already_verified` error. If the code
is correct and the email address is not already verified, it is also marked
as verified as a side effect (just as it would be in a frontend verification
flow); an already verified email address is left unchanged. It never creates
a session; to sign the user in afterwards, mint a sign-in token.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="AttemptEmailAddressVerification" method="post" path="/email_addresses/{email_address_id}/attempt_verification" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.email_addresses.attempt_verification(email_address_id: '<id>', body: Models::Operations::AttemptEmailAddressVerificationRequestBody.new(
  verification_id: '<id>',
  code: '<value>'
))

unless res.verification_response.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                                               | Type                                                                                                                                    | Required                                                                                                                                | Description                                                                                                                             |
| --------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------- |
| `email_address_id`                                                                                                                      | *::String*                                                                                                                              | :heavy_check_mark:                                                                                                                      | The ID of the email address whose code is being verified                                                                                |
| `body`                                                                                                                                  | [Models::Operations::AttemptEmailAddressVerificationRequestBody](../../models/operations/attemptemailaddressverificationrequestbody.md) | :heavy_check_mark:                                                                                                                      | N/A                                                                                                                                     |

### Response

**[Crystalline::Nilable.new(Models::Operations::AttemptEmailAddressVerificationResponse)](../../models/operations/attemptemailaddressverificationresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 401, 403, 404          | application/json            |
| Models::Errors::ClerkErrors | 500                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## replace_for_user

Replaces all of the user's email addresses with a single primary email address.
By default the new email address is created verified, with the admin verification strategy.
When `identification_status` is `reserved` it is created reserved instead: unverified but usable
for sign-in and locked so no other user can claim it. Any existing email addresses are deleted.
If an existing email address is linked to a connected account, the request is rejected; remove
the connected account first.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="ReplaceUserEmailAddress" method="put" path="/users/{user_id}/email_address" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.email_addresses.replace_for_user(user_id: '<id>', body: Models::Operations::ReplaceUserEmailAddressRequestBody.new(
  email_address: 'Ines83@gmail.com'
))

unless res.email_address.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                               | Type                                                                                                                    | Required                                                                                                                | Description                                                                                                             |
| ----------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------- |
| `user_id`                                                                                                               | *::String*                                                                                                              | :heavy_check_mark:                                                                                                      | The ID of the user whose email address to replace                                                                       |
| `body`                                                                                                                  | [Models::Operations::ReplaceUserEmailAddressRequestBody](../../models/operations/replaceuseremailaddressrequestbody.md) | :heavy_check_mark:                                                                                                      | N/A                                                                                                                     |

### Response

**[Crystalline::Nilable.new(Models::Operations::ReplaceUserEmailAddressResponse)](../../models/operations/replaceuseremailaddressresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 401, 403, 404, 422     | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |