# APIKeys

## Overview

Endpoints for managing API Keys

### Available Operations

* [create_api_key](#create_api_key) - Create an API Key
* [get_api_keys](#get_api_keys) - Get API Keys
* [get_api_key](#get_api_key) - Get an API Key by ID
* [update_api_key](#update_api_key) - Update an API Key
* [delete_api_key](#delete_api_key) - Delete an API Key
* [get_api_key_secret](#get_api_key_secret) - Get an API Key Secret
* [revoke_api_key](#revoke_api_key) - Revoke an API Key
* [verify_api_key](#verify_api_key) - Verify an API Key

## create_api_key

Create an API Key

### Example Usage

<!-- UsageSnippet language="ruby" operationID="createApiKey" method="post" path="/api_keys" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)

req = Models::Operations::CreateApiKeyRequest.new(
  name: '<value>',
  subject: '<value>'
)
res = s.api_keys.create_api_key(request: req)

unless res.object.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                 | Type                                                                                      | Required                                                                                  | Description                                                                               |
| ----------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------- |
| `request`                                                                                 | [Models::Operations::CreateApiKeyRequest](../../models/operations/createapikeyrequest.md) | :heavy_check_mark:                                                                        | The request object to use for the request.                                                |

### Response

**[Crystalline::Nilable.new(Models::Operations::CreateApiKeyResponse)](../../models/operations/createapikeyresponse.md)**

### Errors

| Error Type                                  | Status Code                                 | Content Type                                |
| ------------------------------------------- | ------------------------------------------- | ------------------------------------------- |
| Models::Errors::CreateApiKeyBadRequestError | 400                                         | application/json                            |
| Models::Errors::CreateApiKeyConflictError   | 409                                         | application/json                            |
| Errors::APIError                            | 4XX, 5XX                                    | \*/\*                                       |

## get_api_keys

Get API Keys

### Example Usage

<!-- UsageSnippet language="ruby" operationID="getApiKeys" method="get" path="/api_keys" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)

req = Models::Operations::GetApiKeysRequest.new(
  subject: '<value>'
)
res = s.api_keys.get_api_keys(request: req)

unless res.object.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                             | Type                                                                                  | Required                                                                              | Description                                                                           |
| ------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------- |
| `request`                                                                             | [Models::Operations::GetApiKeysRequest](../../models/operations/getapikeysrequest.md) | :heavy_check_mark:                                                                    | The request object to use for the request.                                            |

### Response

**[Crystalline::Nilable.new(Models::Operations::GetApiKeysResponse)](../../models/operations/getapikeysresponse.md)**

### Errors

| Error Type                                | Status Code                               | Content Type                              |
| ----------------------------------------- | ----------------------------------------- | ----------------------------------------- |
| Models::Errors::GetApiKeysBadRequestError | 400                                       | application/json                          |
| Models::Errors::GetApiKeysNotFoundError   | 404                                       | application/json                          |
| Errors::APIError                          | 4XX, 5XX                                  | \*/\*                                     |

## get_api_key

Get an API Key by ID

### Example Usage

<!-- UsageSnippet language="ruby" operationID="getApiKey" method="get" path="/api_keys/{apiKeyID}" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.api_keys.get_api_key(api_key_id: '<id>')

unless res.object.nil?
  # handle response
end

```

### Parameters

| Parameter          | Type               | Required           | Description        |
| ------------------ | ------------------ | ------------------ | ------------------ |
| `api_key_id`       | *::String*         | :heavy_check_mark: | N/A                |

### Response

**[Crystalline::Nilable.new(Models::Operations::GetApiKeyResponse)](../../models/operations/getapikeyresponse.md)**

### Errors

| Error Type                               | Status Code                              | Content Type                             |
| ---------------------------------------- | ---------------------------------------- | ---------------------------------------- |
| Models::Errors::GetApiKeyBadRequestError | 400                                      | application/json                         |
| Models::Errors::GetApiKeyNotFoundError   | 404                                      | application/json                         |
| Errors::APIError                         | 4XX, 5XX                                 | \*/\*                                    |

## update_api_key

Update an API Key

### Example Usage

<!-- UsageSnippet language="ruby" operationID="updateApiKey" method="patch" path="/api_keys/{apiKeyID}" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.api_keys.update_api_key(api_key_id: '<id>', body: Models::Operations::UpdateApiKeyRequestBody.new)

unless res.object.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                         | Type                                                                                              | Required                                                                                          | Description                                                                                       |
| ------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------- |
| `api_key_id`                                                                                      | *::String*                                                                                        | :heavy_check_mark:                                                                                | N/A                                                                                               |
| `body`                                                                                            | [Models::Operations::UpdateApiKeyRequestBody](../../models/operations/updateapikeyrequestbody.md) | :heavy_check_mark:                                                                                | N/A                                                                                               |

### Response

**[Crystalline::Nilable.new(Models::Operations::UpdateApiKeyResponse)](../../models/operations/updateapikeyresponse.md)**

### Errors

| Error Type                                  | Status Code                                 | Content Type                                |
| ------------------------------------------- | ------------------------------------------- | ------------------------------------------- |
| Models::Errors::UpdateApiKeyBadRequestError | 400                                         | application/json                            |
| Models::Errors::UpdateApiKeyNotFoundError   | 404                                         | application/json                            |
| Errors::APIError                            | 4XX, 5XX                                    | \*/\*                                       |

## delete_api_key

Delete an API Key

### Example Usage

<!-- UsageSnippet language="ruby" operationID="deleteApiKey" method="delete" path="/api_keys/{apiKeyID}" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.api_keys.delete_api_key(api_key_id: '<id>')

unless res.object.nil?
  # handle response
end

```

### Parameters

| Parameter          | Type               | Required           | Description        |
| ------------------ | ------------------ | ------------------ | ------------------ |
| `api_key_id`       | *::String*         | :heavy_check_mark: | N/A                |

### Response

**[Crystalline::Nilable.new(Models::Operations::DeleteApiKeyResponse)](../../models/operations/deleteapikeyresponse.md)**

### Errors

| Error Type                                  | Status Code                                 | Content Type                                |
| ------------------------------------------- | ------------------------------------------- | ------------------------------------------- |
| Models::Errors::DeleteApiKeyBadRequestError | 400                                         | application/json                            |
| Models::Errors::DeleteApiKeyNotFoundError   | 404                                         | application/json                            |
| Errors::APIError                            | 4XX, 5XX                                    | \*/\*                                       |

## get_api_key_secret

Get an API Key Secret

### Example Usage

<!-- UsageSnippet language="ruby" operationID="getApiKeySecret" method="get" path="/api_keys/{apiKeyID}/secret" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.api_keys.get_api_key_secret(api_key_id: '<id>')

unless res.object.nil?
  # handle response
end

```

### Parameters

| Parameter          | Type               | Required           | Description        |
| ------------------ | ------------------ | ------------------ | ------------------ |
| `api_key_id`       | *::String*         | :heavy_check_mark: | N/A                |

### Response

**[Crystalline::Nilable.new(Models::Operations::GetApiKeySecretResponse)](../../models/operations/getapikeysecretresponse.md)**

### Errors

| Error Type                                     | Status Code                                    | Content Type                                   |
| ---------------------------------------------- | ---------------------------------------------- | ---------------------------------------------- |
| Models::Errors::GetApiKeySecretBadRequestError | 400                                            | application/json                               |
| Models::Errors::GetApiKeySecretNotFoundError   | 404                                            | application/json                               |
| Errors::APIError                               | 4XX, 5XX                                       | \*/\*                                          |

## revoke_api_key

Revoke an API Key

### Example Usage

<!-- UsageSnippet language="ruby" operationID="revokeApiKey" method="post" path="/api_keys/{apiKeyID}/revoke" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.api_keys.revoke_api_key(api_key_id: '<id>', body: Models::Operations::RevokeApiKeyRequestBody.new)

unless res.object.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                         | Type                                                                                              | Required                                                                                          | Description                                                                                       |
| ------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------- |
| `api_key_id`                                                                                      | *::String*                                                                                        | :heavy_check_mark:                                                                                | N/A                                                                                               |
| `body`                                                                                            | [Models::Operations::RevokeApiKeyRequestBody](../../models/operations/revokeapikeyrequestbody.md) | :heavy_check_mark:                                                                                | N/A                                                                                               |

### Response

**[Crystalline::Nilable.new(Models::Operations::RevokeApiKeyResponse)](../../models/operations/revokeapikeyresponse.md)**

### Errors

| Error Type                                  | Status Code                                 | Content Type                                |
| ------------------------------------------- | ------------------------------------------- | ------------------------------------------- |
| Models::Errors::RevokeApiKeyBadRequestError | 400                                         | application/json                            |
| Models::Errors::RevokeApiKeyNotFoundError   | 404                                         | application/json                            |
| Errors::APIError                            | 4XX, 5XX                                    | \*/\*                                       |

## verify_api_key

Verify an API Key

### Example Usage

<!-- UsageSnippet language="ruby" operationID="verifyApiKey" method="post" path="/api_keys/verify" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)

req = Models::Operations::VerifyApiKeyRequest.new(
  secret: '<value>'
)
res = s.api_keys.verify_api_key(request: req)

unless res.object.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                 | Type                                                                                      | Required                                                                                  | Description                                                                               |
| ----------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------- |
| `request`                                                                                 | [Models::Operations::VerifyApiKeyRequest](../../models/operations/verifyapikeyrequest.md) | :heavy_check_mark:                                                                        | The request object to use for the request.                                                |

### Response

**[Crystalline::Nilable.new(Models::Operations::VerifyApiKeyResponse)](../../models/operations/verifyapikeyresponse.md)**

### Errors

| Error Type                                  | Status Code                                 | Content Type                                |
| ------------------------------------------- | ------------------------------------------- | ------------------------------------------- |
| Models::Errors::VerifyApiKeyBadRequestError | 400                                         | application/json                            |
| Models::Errors::VerifyApiKeyNotFoundError   | 404                                         | application/json                            |
| Errors::APIError                            | 4XX, 5XX                                    | \*/\*                                       |