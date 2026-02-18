# Miscellaneous

## Overview

### Available Operations

* [get_public_interstitial](#get_public_interstitial) - Returns the markup for the interstitial page

## get_public_interstitial

The Clerk interstitial endpoint serves an html page that loads clerk.js in order to check the user's authentication state.
It is used by Clerk SDKs when the user's authentication state cannot be immediately determined.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="GetPublicInterstitial" method="get" path="/public/interstitial" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new

req = Models::Operations::GetPublicInterstitialRequest.new(
  frontend_api_query_parameter1: 'pub_1a2b3c4d'
)
res = s.miscellaneous.get_public_interstitial(request: req)

if res.status_code == 200
  # handle response
end

```

### Parameters

| Parameter                                                                                                   | Type                                                                                                        | Required                                                                                                    | Description                                                                                                 |
| ----------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------- |
| `request`                                                                                                   | [Models::Operations::GetPublicInterstitialRequest](../../models/operations/getpublicinterstitialrequest.md) | :heavy_check_mark:                                                                                          | The request object to use for the request.                                                                  |

### Response

**[Crystalline::Nilable.new(Models::Operations::GetPublicInterstitialResponse)](../../models/operations/getpublicinterstitialresponse.md)**

### Errors

| Error Type       | Status Code      | Content Type     |
| ---------------- | ---------------- | ---------------- |
| Errors::APIError | 4XX, 5XX         | \*/\*            |