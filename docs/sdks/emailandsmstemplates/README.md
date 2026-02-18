# ~~EmailAndSmsTemplates~~

> [!WARNING]
> This SDK is **DEPRECATED**

## Overview

### Available Operations

* [~~upsert~~](#upsert) - Update a template for a given type and slug :warning: **Deprecated**

## ~~upsert~~

Updates the existing template of the given type and slug

> :warning: **DEPRECATED**: This will be removed in a future release, please migrate away from it as soon as possible.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="UpsertTemplate" method="put" path="/templates/{template_type}/{slug}" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.email_and_sms_templates.upsert(template_type: Models::Operations::UpsertTemplateTemplateType::SMS, slug: 'verification-code', body: Models::Operations::UpsertTemplateRequestBody.new(
  name: 'Verification Code',
  subject: 'Your Verification Code',
  markup: '<p>Your code: {{code}}</p>',
  body: 'Use this code to verify your email: {{code}}',
  delivered_by_clerk: true,
  from_email_name: 'hello',
  reply_to_email_name: 'support'
))

unless res.template.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                                       | Type                                                                                                                            | Required                                                                                                                        | Description                                                                                                                     |
| ------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------- |
| `template_type`                                                                                                                 | [Models::Operations::UpsertTemplateTemplateType](../../models/operations/upserttemplatetemplatetype.md)                         | :heavy_check_mark:                                                                                                              | The type of template to update                                                                                                  |
| `slug`                                                                                                                          | *::String*                                                                                                                      | :heavy_check_mark:                                                                                                              | The slug of the template to update                                                                                              |
| `body`                                                                                                                          | [Crystalline::Nilable.new(Models::Operations::UpsertTemplateRequestBody)](../../models/operations/upserttemplaterequestbody.md) | :heavy_minus_sign:                                                                                                              | N/A                                                                                                                             |

### Response

**[Crystalline::Nilable.new(Models::Operations::UpsertTemplateResponse)](../../models/operations/upserttemplateresponse.md)**

### Errors

| Error Type                   | Status Code                  | Content Type                 |
| ---------------------------- | ---------------------------- | ---------------------------- |
| Models::Errors::ClerkErrors  | 400, 401, 402, 403, 404, 422 | application/json             |
| Errors::APIError             | 4XX, 5XX                     | \*/\*                        |