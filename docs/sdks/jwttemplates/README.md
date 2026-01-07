# JwtTemplates

## Overview

### Available Operations

* [list](#list) - List all templates
* [create](#create) - Create a JWT template
* [get](#get) - Retrieve a template
* [update](#update) - Update a JWT template
* [delete](#delete) - Delete a Template

## list

List all templates

### Example Usage

<!-- UsageSnippet language="ruby" operationID="ListJWTTemplates" method="get" path="/jwt_templates" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.jwt_templates.list(limit: 10, offset: 0)

unless res.jwt_template_list.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                                                 | Type                                                                                                                                      | Required                                                                                                                                  | Description                                                                                                                               |
| ----------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------- |
| `paginated`                                                                                                                               | *Crystalline::Nilable.new(Crystalline::Boolean.new)*                                                                                      | :heavy_minus_sign:                                                                                                                        | Whether to paginate the results.<br/>If true, the results will be paginated.<br/>If false, the results will not be paginated.             |
| `limit`                                                                                                                                   | *Crystalline::Nilable.new(::Integer)*                                                                                                     | :heavy_minus_sign:                                                                                                                        | Applies a limit to the number of results returned.<br/>Can be used for paginating the results together with `offset`.                     |
| `offset`                                                                                                                                  | *Crystalline::Nilable.new(::Integer)*                                                                                                     | :heavy_minus_sign:                                                                                                                        | Skip the first `offset` results when paginating.<br/>Needs to be an integer greater or equal to zero.<br/>To be used in conjunction with `limit`. |

### Response

**[Crystalline::Nilable.new(Models::Operations::ListJWTTemplatesResponse)](../../models/operations/listjwttemplatesresponse.md)**

### Errors

| Error Type       | Status Code      | Content Type     |
| ---------------- | ---------------- | ---------------- |
| Errors::APIError | 4XX, 5XX         | \*/\*            |

## create

Create a new JWT template

### Example Usage

<!-- UsageSnippet language="ruby" operationID="CreateJWTTemplate" method="post" path="/jwt_templates" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

req = Models::Operations::CreateJWTTemplateRequest.new(
  name: 'Example Template',
  claims: Models::Operations::CreateJWTTemplateClaims.new(),
  lifetime: 3600,
  allowed_clock_skew: 5,
  custom_signing_key: false,
  signing_algorithm: 'RS256',
  signing_key: 'PRIVATE_KEY_PLACEHOLDER',
)

res = s.jwt_templates.create(request: req)

unless res.jwt_template.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                           | Type                                                                                                | Required                                                                                            | Description                                                                                         |
| --------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------- |
| `request`                                                                                           | [Models::Operations::CreateJWTTemplateRequest](../../models/operations/createjwttemplaterequest.md) | :heavy_check_mark:                                                                                  | The request object to use for the request.                                                          |

### Response

**[Crystalline::Nilable.new(Models::Operations::CreateJWTTemplateResponse)](../../models/operations/createjwttemplateresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 402, 422               | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## get

Retrieve the details of a given JWT template

### Example Usage

<!-- UsageSnippet language="ruby" operationID="GetJWTTemplate" method="get" path="/jwt_templates/{template_id}" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.jwt_templates.get(template_id: 'template_123')

unless res.jwt_template.nil?
  # handle response
end

```

### Parameters

| Parameter          | Type               | Required           | Description        |
| ------------------ | ------------------ | ------------------ | ------------------ |
| `template_id`      | *::String*         | :heavy_check_mark: | JWT Template ID    |

### Response

**[Crystalline::Nilable.new(Models::Operations::GetJWTTemplateResponse)](../../models/operations/getjwttemplateresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 404                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## update

Updates an existing JWT template

### Example Usage

<!-- UsageSnippet language="ruby" operationID="UpdateJWTTemplate" method="patch" path="/jwt_templates/{template_id}" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.jwt_templates.update(template_id: '<id>')

unless res.jwt_template.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                                             | Type                                                                                                                                  | Required                                                                                                                              | Description                                                                                                                           |
| ------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------- |
| `template_id`                                                                                                                         | *::String*                                                                                                                            | :heavy_check_mark:                                                                                                                    | The ID of the JWT template to update                                                                                                  |
| `body`                                                                                                                                | [Crystalline::Nilable.new(Models::Operations::UpdateJWTTemplateRequestBody)](../../models/operations/updatejwttemplaterequestbody.md) | :heavy_minus_sign:                                                                                                                    | N/A                                                                                                                                   |

### Response

**[Crystalline::Nilable.new(Models::Operations::UpdateJWTTemplateResponse)](../../models/operations/updatejwttemplateresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 402, 422               | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## delete

Delete a Template

### Example Usage

<!-- UsageSnippet language="ruby" operationID="DeleteJWTTemplate" method="delete" path="/jwt_templates/{template_id}" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.jwt_templates.delete(template_id: '<id>')

unless res.deleted_object.nil?
  # handle response
end

```

### Parameters

| Parameter          | Type               | Required           | Description        |
| ------------------ | ------------------ | ------------------ | ------------------ |
| `template_id`      | *::String*         | :heavy_check_mark: | JWT Template ID    |

### Response

**[Crystalline::Nilable.new(Models::Operations::DeleteJWTTemplateResponse)](../../models/operations/deletejwttemplateresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 403, 404                    | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |