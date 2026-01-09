# TestingTokens

## Overview

### Available Operations

* [create](#create) - Retrieve a new testing token

## create

Retrieve a new testing token.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="CreateTestingToken" method="post" path="/testing_tokens" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.testing_tokens.create()

unless res.testing_token.nil?
  # handle response
end

```

### Response

**[Crystalline::Nilable.new(Models::Operations::CreateTestingTokenResponse)](../../models/operations/createtestingtokenresponse.md)**

### Errors

| Error Type       | Status Code      | Content Type     |
| ---------------- | ---------------- | ---------------- |
| Errors::APIError | 4XX, 5XX         | \*/\*            |