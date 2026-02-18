# ~~EmailSMSTemplates~~

> [!WARNING]
> This SDK is **DEPRECATED**

## Overview

### Available Operations

* [~~list~~](#list) - List all templates :warning: **Deprecated**
* [~~get~~](#get) - Retrieve a template :warning: **Deprecated**
* [~~revert~~](#revert) - Revert a template :warning: **Deprecated**
* [~~toggle_template_delivery~~](#toggle_template_delivery) - Toggle the delivery by Clerk for a template of a given type and slug :warning: **Deprecated**

## ~~list~~

Returns a list of all templates.
The templates are returned sorted by position.

> :warning: **DEPRECATED**: This will be removed in a future release, please migrate away from it as soon as possible.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="GetTemplateList" method="get" path="/templates/{template_type}" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.email_sms_templates.list(template_type: Models::Operations::GetTemplateListTemplateType::EMAIL, limit: 10, offset: 0)

unless res.template_list.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                                                 | Type                                                                                                                                      | Required                                                                                                                                  | Description                                                                                                                               |
| ----------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------- |
| `template_type`                                                                                                                           | [Models::Operations::GetTemplateListTemplateType](../../models/operations/gettemplatelisttemplatetype.md)                                 | :heavy_check_mark:                                                                                                                        | The type of templates to list (email or SMS)                                                                                              |
| `paginated`                                                                                                                               | *Crystalline::Nilable.new(Crystalline::Boolean.new)*                                                                                      | :heavy_minus_sign:                                                                                                                        | Whether to paginate the results.<br/>If true, the results will be paginated.<br/>If false, the results will not be paginated.             |
| `limit`                                                                                                                                   | *Crystalline::Nilable.new(::Integer)*                                                                                                     | :heavy_minus_sign:                                                                                                                        | Applies a limit to the number of results returned.<br/>Can be used for paginating the results together with `offset`.                     |
| `offset`                                                                                                                                  | *Crystalline::Nilable.new(::Integer)*                                                                                                     | :heavy_minus_sign:                                                                                                                        | Skip the first `offset` results when paginating.<br/>Needs to be an integer greater or equal to zero.<br/>To be used in conjunction with `limit`. |

### Response

**[Crystalline::Nilable.new(Models::Operations::GetTemplateListResponse)](../../models/operations/gettemplatelistresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 401, 422               | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## ~~get~~

Returns the details of a template

> :warning: **DEPRECATED**: This will be removed in a future release, please migrate away from it as soon as possible.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="GetTemplate" method="get" path="/templates/{template_type}/{slug}" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.email_sms_templates.get(template_type: Models::Operations::GetTemplateTemplateType::EMAIL, slug: 'welcome-email')

unless res.template.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                         | Type                                                                                              | Required                                                                                          | Description                                                                                       |
| ------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------- |
| `template_type`                                                                                   | [Models::Operations::GetTemplateTemplateType](../../models/operations/gettemplatetemplatetype.md) | :heavy_check_mark:                                                                                | The type of templates to retrieve (email or SMS)                                                  |
| `slug`                                                                                            | *::String*                                                                                        | :heavy_check_mark:                                                                                | The slug (i.e. machine-friendly name) of the template to retrieve                                 |

### Response

**[Crystalline::Nilable.new(Models::Operations::GetTemplateResponse)](../../models/operations/gettemplateresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 401, 404               | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## ~~revert~~

Reverts an updated template to its default state

> :warning: **DEPRECATED**: This will be removed in a future release, please migrate away from it as soon as possible.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="RevertTemplate" method="post" path="/templates/{template_type}/{slug}/revert" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.email_sms_templates.revert(template_type: Models::Operations::RevertTemplateTemplateType::EMAIL, slug: 'welcome-email')

unless res.template.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                               | Type                                                                                                    | Required                                                                                                | Description                                                                                             |
| ------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------- |
| `template_type`                                                                                         | [Models::Operations::RevertTemplateTemplateType](../../models/operations/reverttemplatetemplatetype.md) | :heavy_check_mark:                                                                                      | The type of template to revert                                                                          |
| `slug`                                                                                                  | *::String*                                                                                              | :heavy_check_mark:                                                                                      | The slug of the template to revert                                                                      |

### Response

**[Crystalline::Nilable.new(Models::Operations::RevertTemplateResponse)](../../models/operations/reverttemplateresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 401, 402, 404          | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## ~~toggle_template_delivery~~

Toggles the delivery by Clerk for a template of a given type and slug.
If disabled, Clerk will not deliver the resulting email or SMS.
The app developer will need to listen to the `email.created` or `sms.created` webhooks in order to handle delivery themselves.

> :warning: **DEPRECATED**: This will be removed in a future release, please migrate away from it as soon as possible.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="ToggleTemplateDelivery" method="post" path="/templates/{template_type}/{slug}/toggle_delivery" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.email_sms_templates.toggle_template_delivery(template_type: Models::Operations::ToggleTemplateDeliveryTemplateType::EMAIL, slug: 'welcome-email', body: Models::Operations::ToggleTemplateDeliveryRequestBody.new(
  delivered_by_clerk: true
))

unless res.template.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                                                       | Type                                                                                                                                            | Required                                                                                                                                        | Description                                                                                                                                     |
| ----------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------- |
| `template_type`                                                                                                                                 | [Models::Operations::ToggleTemplateDeliveryTemplateType](../../models/operations/toggletemplatedeliverytemplatetype.md)                         | :heavy_check_mark:                                                                                                                              | The type of template to toggle delivery for                                                                                                     |
| `slug`                                                                                                                                          | *::String*                                                                                                                                      | :heavy_check_mark:                                                                                                                              | The slug of the template for which to toggle delivery                                                                                           |
| `body`                                                                                                                                          | [Crystalline::Nilable.new(Models::Operations::ToggleTemplateDeliveryRequestBody)](../../models/operations/toggletemplatedeliveryrequestbody.md) | :heavy_minus_sign:                                                                                                                              | N/A                                                                                                                                             |

### Response

**[Crystalline::Nilable.new(Models::Operations::ToggleTemplateDeliveryResponse)](../../models/operations/toggletemplatedeliveryresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 401, 404               | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |