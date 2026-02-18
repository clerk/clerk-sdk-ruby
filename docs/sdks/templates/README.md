# ~~Templates~~

> [!WARNING]
> This SDK is **DEPRECATED**

## Overview

### Available Operations

* [~~preview~~](#preview) - Preview changes to a template :warning: **Deprecated**

## ~~preview~~

Returns a preview of a template for a given template_type, slug and body

> :warning: **DEPRECATED**: This will be removed in a future release, please migrate away from it as soon as possible.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="PreviewTemplate" method="post" path="/templates/{template_type}/{slug}/preview" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.templates.preview(template_type: 'email', slug: 'welcome-email', body: Models::Operations::PreviewTemplateRequestBody.new(
  subject: 'Welcome to our service!',
  body: 'Hi, thank you for joining our service.',
  from_email_name: 'hello',
  reply_to_email_name: 'support'
))

unless res.object.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                                         | Type                                                                                                                              | Required                                                                                                                          | Description                                                                                                                       |
| --------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| `template_type`                                                                                                                   | *::String*                                                                                                                        | :heavy_check_mark:                                                                                                                | The type of template to preview                                                                                                   |
| `slug`                                                                                                                            | *::String*                                                                                                                        | :heavy_check_mark:                                                                                                                | The slug of the template to preview                                                                                               |
| `body`                                                                                                                            | [Crystalline::Nilable.new(Models::Operations::PreviewTemplateRequestBody)](../../models/operations/previewtemplaterequestbody.md) | :heavy_minus_sign:                                                                                                                | Required parameters                                                                                                               |

### Response

**[Crystalline::Nilable.new(Models::Operations::PreviewTemplateResponse)](../../models/operations/previewtemplateresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 401, 404, 422          | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |