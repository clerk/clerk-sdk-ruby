# SignUps

## Overview

### Available Operations

* [get](#get) - Retrieve a sign-up by ID
* [update](#update) - Update a sign-up

## get

Retrieve the details of the sign-up with the given ID

### Example Usage

<!-- UsageSnippet language="ruby" operationID="GetSignUp" method="get" path="/sign_ups/{id}" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.sign_ups.get(id: '<id>')

unless res.sign_up.nil?
  # handle response
end

```

### Parameters

| Parameter                         | Type                              | Required                          | Description                       |
| --------------------------------- | --------------------------------- | --------------------------------- | --------------------------------- |
| `id`                              | *::String*                        | :heavy_check_mark:                | The ID of the sign-up to retrieve |

### Response

**[Crystalline::Nilable.new(Models::Operations::GetSignUpResponse)](../../models/operations/getsignupresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 403                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## update

Update the sign-up with the given ID

### Example Usage

<!-- UsageSnippet language="ruby" operationID="UpdateSignUp" method="patch" path="/sign_ups/{id}" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.sign_ups.update(id: 'signup_1234567890abcdef', body: Models::Operations::UpdateSignUpRequestBody.new(
  external_id: 'ext_id_7890abcdef123456',
  custom_action: false
))

unless res.sign_up.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                                   | Type                                                                                                                        | Required                                                                                                                    | Description                                                                                                                 |
| --------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------- |
| `id`                                                                                                                        | *::String*                                                                                                                  | :heavy_check_mark:                                                                                                          | The ID of the sign-up to update                                                                                             |
| `body`                                                                                                                      | [Crystalline::Nilable.new(Models::Operations::UpdateSignUpRequestBody)](../../models/operations/updatesignuprequestbody.md) | :heavy_minus_sign:                                                                                                          | N/A                                                                                                                         |

### Response

**[Crystalline::Nilable.new(Models::Operations::UpdateSignUpResponse)](../../models/operations/updatesignupresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 403                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |