# PhoneNumbers

## Overview

### Available Operations

* [create](#create) - Create a phone number
* [get](#get) - Retrieve a phone number
* [delete](#delete) - Delete a phone number
* [update](#update) - Update a phone number
* [prepare_verification](#prepare_verification) - Send a verification code to a phone number
* [attempt_verification](#attempt_verification) - Verify a code sent to a phone number
* [replace_for_user](#replace_for_user) - Replace a user's phone number

## create

Create a new phone number

### Example Usage

<!-- UsageSnippet language="ruby" operationID="CreatePhoneNumber" method="post" path="/phone_numbers" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)

req = Models::Operations::CreatePhoneNumberRequest.new(
  user_id: 'usr_12345',
  phone_number: '+11234567890',
  verified: true,
  primary: false,
  reserved_for_second_factor: false
)
res = s.phone_numbers.create(request: req)

unless res.phone_number.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                           | Type                                                                                                | Required                                                                                            | Description                                                                                         |
| --------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------- |
| `request`                                                                                           | [Models::Operations::CreatePhoneNumberRequest](../../models/operations/createphonenumberrequest.md) | :heavy_check_mark:                                                                                  | The request object to use for the request.                                                          |

### Response

**[Crystalline::Nilable.new(Models::Operations::CreatePhoneNumberResponse)](../../models/operations/createphonenumberresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 401, 403, 404, 422     | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## get

Returns the details of a phone number

### Example Usage

<!-- UsageSnippet language="ruby" operationID="GetPhoneNumber" method="get" path="/phone_numbers/{phone_number_id}" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.phone_numbers.get(phone_number_id: 'phone_12345')

unless res.phone_number.nil?
  # handle response
end

```

### Parameters

| Parameter                              | Type                                   | Required                               | Description                            |
| -------------------------------------- | -------------------------------------- | -------------------------------------- | -------------------------------------- |
| `phone_number_id`                      | *::String*                             | :heavy_check_mark:                     | The ID of the phone number to retrieve |

### Response

**[Crystalline::Nilable.new(Models::Operations::GetPhoneNumberResponse)](../../models/operations/getphonenumberresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 401, 403, 404          | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## delete

Delete the phone number with the given ID

### Example Usage

<!-- UsageSnippet language="ruby" operationID="DeletePhoneNumber" method="delete" path="/phone_numbers/{phone_number_id}" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.phone_numbers.delete(phone_number_id: 'phone_12345')

unless res.deleted_object.nil?
  # handle response
end

```

### Parameters

| Parameter                            | Type                                 | Required                             | Description                          |
| ------------------------------------ | ------------------------------------ | ------------------------------------ | ------------------------------------ |
| `phone_number_id`                    | *::String*                           | :heavy_check_mark:                   | The ID of the phone number to delete |

### Response

**[Crystalline::Nilable.new(Models::Operations::DeletePhoneNumberResponse)](../../models/operations/deletephonenumberresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 401, 403, 404          | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## update

Updates a phone number

### Example Usage

<!-- UsageSnippet language="ruby" operationID="UpdatePhoneNumber" method="patch" path="/phone_numbers/{phone_number_id}" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.phone_numbers.update(phone_number_id: 'phone_12345', body: Models::Operations::UpdatePhoneNumberRequestBody.new(
  verified: false,
  primary: true,
  reserved_for_second_factor: true
))

unless res.phone_number.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                                             | Type                                                                                                                                  | Required                                                                                                                              | Description                                                                                                                           |
| ------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------- |
| `phone_number_id`                                                                                                                     | *::String*                                                                                                                            | :heavy_check_mark:                                                                                                                    | The ID of the phone number to update                                                                                                  |
| `body`                                                                                                                                | [Crystalline::Nilable.new(Models::Operations::UpdatePhoneNumberRequestBody)](../../models/operations/updatephonenumberrequestbody.md) | :heavy_minus_sign:                                                                                                                    | N/A                                                                                                                                   |

### Response

**[Crystalline::Nilable.new(Models::Operations::UpdatePhoneNumberResponse)](../../models/operations/updatephonenumberresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 401, 403, 404          | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## prepare_verification

Sends a one-time code to the given phone number so that a backend can
verify the user controls it (for example, in a custom, backend-driven
sign-in flow). The code is tracked on its own verification; confirm it
with attempt_verification.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="PreparePhoneNumberVerification" method="post" path="/phone_numbers/{phone_number_id}/prepare_verification" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.phone_numbers.prepare_verification(phone_number_id: '<id>')

unless res.verification_response.nil?
  # handle response
end

```

### Parameters

| Parameter                                                   | Type                                                        | Required                                                    | Description                                                 |
| ----------------------------------------------------------- | ----------------------------------------------------------- | ----------------------------------------------------------- | ----------------------------------------------------------- |
| `phone_number_id`                                           | *::String*                                                  | :heavy_check_mark:                                          | The ID of the phone number to send the verification code to |

### Response

**[Crystalline::Nilable.new(Models::Operations::PreparePhoneNumberVerificationResponse)](../../models/operations/preparephonenumberverificationresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 401, 403, 404, 429     | application/json            |
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
is correct and the phone number is not already verified, it is also marked
as verified as a side effect (just as it would be in a frontend verification
flow); an already verified phone number is left unchanged. It never creates
a session; to sign the user in afterwards, mint a sign-in token.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="AttemptPhoneNumberVerification" method="post" path="/phone_numbers/{phone_number_id}/attempt_verification" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.phone_numbers.attempt_verification(phone_number_id: '<id>', body: Models::Operations::AttemptPhoneNumberVerificationRequestBody.new(
  verification_id: '<id>',
  code: '<value>'
))

unless res.verification_response.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                                             | Type                                                                                                                                  | Required                                                                                                                              | Description                                                                                                                           |
| ------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------- |
| `phone_number_id`                                                                                                                     | *::String*                                                                                                                            | :heavy_check_mark:                                                                                                                    | The ID of the phone number whose code is being verified                                                                               |
| `body`                                                                                                                                | [Models::Operations::AttemptPhoneNumberVerificationRequestBody](../../models/operations/attemptphonenumberverificationrequestbody.md) | :heavy_check_mark:                                                                                                                    | N/A                                                                                                                                   |

### Response

**[Crystalline::Nilable.new(Models::Operations::AttemptPhoneNumberVerificationResponse)](../../models/operations/attemptphonenumberverificationresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 401, 403, 404          | application/json            |
| Models::Errors::ClerkErrors | 500                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## replace_for_user

Replaces all of the user's phone numbers with a single primary phone number.
By default the new phone number is created verified, with the admin verification strategy.
When `identification_status` is `reserved` it is created reserved instead: unverified but usable
for sign-in and locked so no other user can claim it. The new phone number is never reserved for
second factor. Any existing phone numbers are deleted; replacing a phone number that is reserved
for second factor disables the user's MFA.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="ReplaceUserPhoneNumber" method="put" path="/users/{user_id}/phone_number" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.phone_numbers.replace_for_user(user_id: '<id>', body: Models::Operations::ReplaceUserPhoneNumberRequestBody.new(
  phone_number: '1-440-484-8878 x689'
))

unless res.phone_number.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                             | Type                                                                                                                  | Required                                                                                                              | Description                                                                                                           |
| --------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------- |
| `user_id`                                                                                                             | *::String*                                                                                                            | :heavy_check_mark:                                                                                                    | The ID of the user whose phone number to replace                                                                      |
| `body`                                                                                                                | [Models::Operations::ReplaceUserPhoneNumberRequestBody](../../models/operations/replaceuserphonenumberrequestbody.md) | :heavy_check_mark:                                                                                                    | N/A                                                                                                                   |

### Response

**[Crystalline::Nilable.new(Models::Operations::ReplaceUserPhoneNumberResponse)](../../models/operations/replaceuserphonenumberresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 401, 403, 404, 422     | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |