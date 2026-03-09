# AgentTasks

## Overview

### Available Operations

* [create](#create) - Create agent task
* [revoke](#revoke) - Revoke agent task

## create

Create an agent task on behalf of a user.
The response contains a URL that, when visited, creates a session for the user.
The agent_id is stable per agent_name within an instance. The task_id is unique per call.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="CreateAgentTask" method="post" path="/agents/tasks" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)

req = nil
res = s.agent_tasks.create(request: req)

unless res.agent_task.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                       | Type                                                                                            | Required                                                                                        | Description                                                                                     |
| ----------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------- |
| `request`                                                                                       | [Models::Operations::CreateAgentTaskRequest](../../models/operations/createagenttaskrequest.md) | :heavy_check_mark:                                                                              | The request object to use for the request.                                                      |

### Response

**[Crystalline::Nilable.new(Models::Operations::CreateAgentTaskResponse)](../../models/operations/createagenttaskresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 404, 422               | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## revoke

Revokes a pending agent task.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="RevokeAgentTask" method="post" path="/agents/tasks/{agent_task_id}/revoke" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
  bearer_auth: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.agent_tasks.revoke(agent_task_id: '<id>')

unless res.agent_task.nil?
  # handle response
end

```

### Parameters

| Parameter                               | Type                                    | Required                                | Description                             |
| --------------------------------------- | --------------------------------------- | --------------------------------------- | --------------------------------------- |
| `agent_task_id`                         | *::String*                              | :heavy_check_mark:                      | The ID of the agent task to be revoked. |

### Response

**[Crystalline::Nilable.new(Models::Operations::RevokeAgentTaskResponse)](../../models/operations/revokeagenttaskresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 404                    | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |