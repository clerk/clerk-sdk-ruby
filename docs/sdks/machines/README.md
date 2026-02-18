# Machines

## Overview

### Available Operations

* [list](#list) - Get a list of machines for an instance
* [create](#create) - Create a machine
* [get](#get) - Retrieve a machine
* [update](#update) - Update a machine
* [delete](#delete) - Delete a machine
* [get_secret_key](#get_secret_key) - Retrieve a machine secret key
* [rotate_secret_key](#rotate_secret_key) - Rotate a machine's secret key
* [create_scope](#create_scope) - Create a machine scope
* [delete_scope](#delete_scope) - Delete a machine scope

## list

This request returns the list of machines for an instance. The machines are
ordered by descending creation date (i.e. most recent machines will be
returned first)

### Example Usage

<!-- UsageSnippet language="ruby" operationID="ListMachines" method="get" path="/machines" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.machines.list(limit: 10, offset: 0, order_by: '-created_at')

unless res.machine_list.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                                                                                                                                                                                                                                                                                              | Type                                                                                                                                                                                                                                                                                                                                                                                   | Required                                                                                                                                                                                                                                                                                                                                                                               | Description                                                                                                                                                                                                                                                                                                                                                                            |
| -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `limit`                                                                                                                                                                                                                                                                                                                                                                                | *Crystalline::Nilable.new(::Integer)*                                                                                                                                                                                                                                                                                                                                                  | :heavy_minus_sign:                                                                                                                                                                                                                                                                                                                                                                     | Applies a limit to the number of results returned.<br/>Can be used for paginating the results together with `offset`.                                                                                                                                                                                                                                                                  |
| `offset`                                                                                                                                                                                                                                                                                                                                                                               | *Crystalline::Nilable.new(::Integer)*                                                                                                                                                                                                                                                                                                                                                  | :heavy_minus_sign:                                                                                                                                                                                                                                                                                                                                                                     | Skip the first `offset` results when paginating.<br/>Needs to be an integer greater or equal to zero.<br/>To be used in conjunction with `limit`.                                                                                                                                                                                                                                      |
| `query`                                                                                                                                                                                                                                                                                                                                                                                | *Crystalline::Nilable.new(::String)*                                                                                                                                                                                                                                                                                                                                                   | :heavy_minus_sign:                                                                                                                                                                                                                                                                                                                                                                     | Returns machines with ID or name that match the given query. Uses exact match for machine ID and partial match for name.                                                                                                                                                                                                                                                               |
| `order_by`                                                                                                                                                                                                                                                                                                                                                                             | *Crystalline::Nilable.new(::String)*                                                                                                                                                                                                                                                                                                                                                   | :heavy_minus_sign:                                                                                                                                                                                                                                                                                                                                                                     | Allows to return machines in a particular order.<br/>You can order the returned machines by their `name` or `created_at`.<br/>To specify the direction, use the `+` or `-` symbols prepended to the property to order by.<br/>For example, to return machines in descending order by `created_at`, use `-created_at`.<br/>If you don't use `+` or `-`, then `+` is implied.<br/>Defaults to `-created_at`. |

### Response

**[Crystalline::Nilable.new(Models::Operations::ListMachinesResponse)](../../models/operations/listmachinesresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 401, 403, 422          | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## create

Creates a new machine.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="CreateMachine" method="post" path="/machines" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)

req = nil
res = s.machines.create(request: req)

unless res.machine_created.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                   | Type                                                                                        | Required                                                                                    | Description                                                                                 |
| ------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------- |
| `request`                                                                                   | [Models::Operations::CreateMachineRequest](../../models/operations/createmachinerequest.md) | :heavy_check_mark:                                                                          | The request object to use for the request.                                                  |

### Response

**[Crystalline::Nilable.new(Models::Operations::CreateMachineResponse)](../../models/operations/createmachineresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 401, 403, 422          | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## get

Returns the details of a machine.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="GetMachine" method="get" path="/machines/{machine_id}" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.machines.get(machine_id: '<id>')

unless res.machine.nil?
  # handle response
end

```

### Parameters

| Parameter                         | Type                              | Required                          | Description                       |
| --------------------------------- | --------------------------------- | --------------------------------- | --------------------------------- |
| `machine_id`                      | *::String*                        | :heavy_check_mark:                | The ID of the machine to retrieve |

### Response

**[Crystalline::Nilable.new(Models::Operations::GetMachineResponse)](../../models/operations/getmachineresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 401, 403, 404, 422     | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## update

Updates an existing machine.
Only the provided fields will be updated.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="UpdateMachine" method="patch" path="/machines/{machine_id}" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.machines.update(machine_id: '<id>')

unless res.machine.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                                     | Type                                                                                                                          | Required                                                                                                                      | Description                                                                                                                   |
| ----------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------- |
| `machine_id`                                                                                                                  | *::String*                                                                                                                    | :heavy_check_mark:                                                                                                            | The ID of the machine to update                                                                                               |
| `body`                                                                                                                        | [Crystalline::Nilable.new(Models::Operations::UpdateMachineRequestBody)](../../models/operations/updatemachinerequestbody.md) | :heavy_minus_sign:                                                                                                            | N/A                                                                                                                           |

### Response

**[Crystalline::Nilable.new(Models::Operations::UpdateMachineResponse)](../../models/operations/updatemachineresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 401, 403, 404, 422     | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## delete

Deletes a machine.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="DeleteMachine" method="delete" path="/machines/{machine_id}" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.machines.delete(machine_id: '<id>')

unless res.machine_deleted.nil?
  # handle response
end

```

### Parameters

| Parameter                       | Type                            | Required                        | Description                     |
| ------------------------------- | ------------------------------- | ------------------------------- | ------------------------------- |
| `machine_id`                    | *::String*                      | :heavy_check_mark:              | The ID of the machine to delete |

### Response

**[Crystalline::Nilable.new(Models::Operations::DeleteMachineResponse)](../../models/operations/deletemachineresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 401, 403, 404, 422     | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## get_secret_key

Returns the secret key for a machine.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="GetMachineSecretKey" method="get" path="/machines/{machine_id}/secret_key" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.machines.get_secret_key(machine_id: '<id>')

unless res.machine_secret_key.nil?
  # handle response
end

```

### Parameters

| Parameter                                            | Type                                                 | Required                                             | Description                                          |
| ---------------------------------------------------- | ---------------------------------------------------- | ---------------------------------------------------- | ---------------------------------------------------- |
| `machine_id`                                         | *::String*                                           | :heavy_check_mark:                                   | The ID of the machine to retrieve the secret key for |

### Response

**[Crystalline::Nilable.new(Models::Operations::GetMachineSecretKeyResponse)](../../models/operations/getmachinesecretkeyresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 401, 403, 404          | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## rotate_secret_key

Rotates the machine's secret key.
When the secret key is rotated, make sure to update it in your machine/application.
The previous secret key will remain valid for the duration specified by the previous_token_ttl parameter.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="RotateMachineSecretKey" method="post" path="/machines/{machine_id}/secret_key/rotate" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.machines.rotate_secret_key(machine_id: '<id>', body: Models::Operations::RotateMachineSecretKeyRequestBody.new(
  previous_token_ttl: 632_625
))

unless res.machine_secret_key.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                             | Type                                                                                                                  | Required                                                                                                              | Description                                                                                                           |
| --------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------- |
| `machine_id`                                                                                                          | *::String*                                                                                                            | :heavy_check_mark:                                                                                                    | The ID of the machine to rotate the secret key for                                                                    |
| `body`                                                                                                                | [Models::Operations::RotateMachineSecretKeyRequestBody](../../models/operations/rotatemachinesecretkeyrequestbody.md) | :heavy_check_mark:                                                                                                    | N/A                                                                                                                   |

### Response

**[Crystalline::Nilable.new(Models::Operations::RotateMachineSecretKeyResponse)](../../models/operations/rotatemachinesecretkeyresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 401, 403, 404, 422     | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## create_scope

Creates a new machine scope, allowing the specified machine to access another machine.
Maximum of 150 scopes per machine.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="CreateMachineScope" method="post" path="/machines/{machine_id}/scopes" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.machines.create_scope(machine_id: '<id>')

unless res.machine_scope.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                                               | Type                                                                                                                                    | Required                                                                                                                                | Description                                                                                                                             |
| --------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------- |
| `machine_id`                                                                                                                            | *::String*                                                                                                                              | :heavy_check_mark:                                                                                                                      | The ID of the machine that will have access to another machine                                                                          |
| `body`                                                                                                                                  | [Crystalline::Nilable.new(Models::Operations::CreateMachineScopeRequestBody)](../../models/operations/createmachinescoperequestbody.md) | :heavy_minus_sign:                                                                                                                      | N/A                                                                                                                                     |

### Response

**[Crystalline::Nilable.new(Models::Operations::CreateMachineScopeResponse)](../../models/operations/createmachinescoperesponse.md)**

### Errors

| Error Type                   | Status Code                  | Content Type                 |
| ---------------------------- | ---------------------------- | ---------------------------- |
| Models::Errors::ClerkErrors  | 400, 401, 403, 404, 409, 422 | application/json             |
| Errors::APIError             | 4XX, 5XX                     | \*/\*                        |

## delete_scope

Deletes a machine scope, removing access from one machine to another.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="DeleteMachineScope" method="delete" path="/machines/{machine_id}/scopes/{other_machine_id}" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.machines.delete_scope(machine_id: '<id>', other_machine_id: '<id>')

unless res.machine_scope_deleted.nil?
  # handle response
end

```

### Parameters

| Parameter                                                | Type                                                     | Required                                                 | Description                                              |
| -------------------------------------------------------- | -------------------------------------------------------- | -------------------------------------------------------- | -------------------------------------------------------- |
| `machine_id`                                             | *::String*                                               | :heavy_check_mark:                                       | The ID of the machine that has access to another machine |
| `other_machine_id`                                       | *::String*                                               | :heavy_check_mark:                                       | The ID of the machine that is being accessed             |

### Response

**[Crystalline::Nilable.new(Models::Operations::DeleteMachineScopeResponse)](../../models/operations/deletemachinescoperesponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 401, 403, 404, 422     | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |