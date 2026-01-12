# Jwks

## Overview

### Available Operations

* [get_jwks](#get_jwks) - Retrieve the JSON Web Key Set of the instance

## get_jwks

Retrieve the JSON Web Key Set of the instance

### Example Usage

<!-- UsageSnippet language="ruby" operationID="GetJWKS" method="get" path="/jwks" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.jwks.get_jwks()

unless res.jwks.nil?
  # handle response
end

```

### Response

**[Crystalline::Nilable.new(Models::Operations::GetJWKSResponse)](../../models/operations/getjwksresponse.md)**

### Errors

| Error Type       | Status Code      | Content Type     |
| ---------------- | ---------------- | ---------------- |
| Errors::APIError | 4XX, 5XX         | \*/\*            |