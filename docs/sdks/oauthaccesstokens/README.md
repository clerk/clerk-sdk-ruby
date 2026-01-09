# OauthAccessTokens

## Overview

### Available Operations

* [verify](#verify) - Verify an OAuth Access Token

## verify

Verify an OAuth Access Token

### Example Usage

<!-- UsageSnippet language="ruby" operationID="verifyOAuthAccessToken" method="post" path="/oauth_applications/access_tokens/verify" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

req = Models::Operations::VerifyOAuthAccessTokenRequest.new(
  access_token: 'XXXXXXXXXXXXXX',
)

res = s.oauth_access_tokens.verify(request: req)

unless res.one_of.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                     | Type                                                                                                          | Required                                                                                                      | Description                                                                                                   |
| ------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------- |
| `request`                                                                                                     | [Models::Operations::VerifyOAuthAccessTokenRequest](../../models/operations/verifyoauthaccesstokenrequest.md) | :heavy_check_mark:                                                                                            | The request object to use for the request.                                                                    |

### Response

**[Crystalline::Nilable.new(Models::Operations::VerifyOAuthAccessTokenResponse)](../../models/operations/verifyoauthaccesstokenresponse.md)**

### Errors

| Error Type                                            | Status Code                                           | Content Type                                          |
| ----------------------------------------------------- | ----------------------------------------------------- | ----------------------------------------------------- |
| Models::Errors::VerifyOAuthAccessTokenBadRequestError | 400                                                   | application/json                                      |
| Models::Errors::VerifyOAuthAccessTokenNotFoundError   | 404                                                   | application/json                                      |
| Errors::APIError                                      | 4XX, 5XX                                              | \*/\*                                                 |