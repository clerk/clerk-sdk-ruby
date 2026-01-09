# EmailAddresses

## Overview

### Available Operations

* [create](#create) - Create an email address
* [get](#get) - Retrieve an email address
* [delete](#delete) - Delete an email address
* [update](#update) - Update an email address

## create

Create a new email address

### Example Usage

<!-- UsageSnippet language="ruby" operationID="CreateEmailAddress" method="post" path="/email_addresses" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

req = Models::Operations::CreateEmailAddressRequest.new(
  user_id: 'user_12345',
  email_address: 'example@clerk.com',
  verified: false,
  primary: true,
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

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 401, 403, 404, 422     | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## get

Returns the details of an email address.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="GetEmailAddress" method="get" path="/email_addresses/{email_address_id}" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
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
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
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
| Models::Errors::ClerkErrors | 400, 401, 403, 404          | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## update

Updates an email address.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="UpdateEmailAddress" method="patch" path="/email_addresses/{email_address_id}" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.email_addresses.update(email_address_id: 'email_address_id_example', body: Models::Operations::UpdateEmailAddressRequestBody.new(
  verified: false,
  primary: true,
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
| Models::Errors::ClerkErrors | 400, 401, 403, 404          | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |