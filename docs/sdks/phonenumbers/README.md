# PhoneNumbers

## Overview

### Available Operations

* [create](#create) - Create a phone number
* [get](#get) - Retrieve a phone number
* [delete](#delete) - Delete a phone number
* [update](#update) - Update a phone number

## create

Create a new phone number

### Example Usage

<!-- UsageSnippet language="ruby" operationID="CreatePhoneNumber" method="post" path="/phone_numbers" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

req = Models::Operations::CreatePhoneNumberRequest.new(
  user_id: 'usr_12345',
  phone_number: '+11234567890',
  verified: true,
  primary: false,
  reserved_for_second_factor: false,
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
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
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
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
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
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.phone_numbers.update(phone_number_id: 'phone_12345', body: Models::Operations::UpdatePhoneNumberRequestBody.new(
  verified: false,
  primary: true,
  reserved_for_second_factor: true,
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