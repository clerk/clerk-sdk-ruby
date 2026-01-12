# WaitlistEntries

## Overview

### Available Operations

* [list](#list) - List all waitlist entries
* [create](#create) - Create a waitlist entry
* [delete](#delete) - Delete a pending waitlist entry
* [invite](#invite) - Invite a waitlist entry
* [reject](#reject) - Reject a waitlist entry

## list

Retrieve a list of waitlist entries for the instance.
Entries are ordered by creation date in descending order by default.
Supports filtering by email address or status and pagination with limit and offset parameters.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="ListWaitlistEntries" method="get" path="/waitlist_entries" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

req = Models::Operations::ListWaitlistEntriesRequest.new()

res = s.waitlist_entries.list(request: req)

unless res.waitlist_entries.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                               | Type                                                                                                    | Required                                                                                                | Description                                                                                             |
| ------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------- |
| `request`                                                                                               | [Models::Operations::ListWaitlistEntriesRequest](../../models/operations/listwaitlistentriesrequest.md) | :heavy_check_mark:                                                                                      | The request object to use for the request.                                                              |

### Response

**[Crystalline::Nilable.new(Models::Operations::ListWaitlistEntriesResponse)](../../models/operations/listwaitlistentriesresponse.md)**

### Errors

| Error Type       | Status Code      | Content Type     |
| ---------------- | ---------------- | ---------------- |
| Errors::APIError | 4XX, 5XX         | \*/\*            |

## create

Creates a new waitlist entry for the given email address.
If the email address is already on the waitlist, no new entry will be created and the existing waitlist entry will be returned.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="CreateWaitlistEntry" method="post" path="/waitlist_entries" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

req = 

res = s.waitlist_entries.create(request: req)

unless res.waitlist_entry.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                               | Type                                                                                                    | Required                                                                                                | Description                                                                                             |
| ------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------- |
| `request`                                                                                               | [Models::Operations::CreateWaitlistEntryRequest](../../models/operations/createwaitlistentryrequest.md) | :heavy_check_mark:                                                                                      | The request object to use for the request.                                                              |

### Response

**[Crystalline::Nilable.new(Models::Operations::CreateWaitlistEntryResponse)](../../models/operations/createwaitlistentryresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 422                    | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## delete

Delete a pending waitlist entry.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="DeleteWaitlistEntry" method="delete" path="/waitlist_entries/{waitlist_entry_id}" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.waitlist_entries.delete(waitlist_entry_id: '<id>')

unless res.deleted_object.nil?
  # handle response
end

```

### Parameters

| Parameter                              | Type                                   | Required                               | Description                            |
| -------------------------------------- | -------------------------------------- | -------------------------------------- | -------------------------------------- |
| `waitlist_entry_id`                    | *::String*                             | :heavy_check_mark:                     | The ID of the waitlist entry to delete |

### Response

**[Crystalline::Nilable.new(Models::Operations::DeleteWaitlistEntryResponse)](../../models/operations/deletewaitlistentryresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 404, 409, 422          | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## invite

Send an invite to the email address in a waitlist entry.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="InviteWaitlistEntry" method="post" path="/waitlist_entries/{waitlist_entry_id}/invite" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.waitlist_entries.invite(waitlist_entry_id: '<id>')

unless res.waitlist_entry.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                                                 | Type                                                                                                                                      | Required                                                                                                                                  | Description                                                                                                                               |
| ----------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------- |
| `waitlist_entry_id`                                                                                                                       | *::String*                                                                                                                                | :heavy_check_mark:                                                                                                                        | The ID of the waitlist entry to invite                                                                                                    |
| `body`                                                                                                                                    | [Crystalline::Nilable.new(Models::Operations::InviteWaitlistEntryRequestBody)](../../models/operations/invitewaitlistentryrequestbody.md) | :heavy_minus_sign:                                                                                                                        | N/A                                                                                                                                       |

### Response

**[Crystalline::Nilable.new(Models::Operations::InviteWaitlistEntryResponse)](../../models/operations/invitewaitlistentryresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 404, 409, 422          | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## reject

Reject a waitlist entry.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="RejectWaitlistEntry" method="post" path="/waitlist_entries/{waitlist_entry_id}/reject" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.waitlist_entries.reject(waitlist_entry_id: '<id>')

unless res.waitlist_entry.nil?
  # handle response
end

```

### Parameters

| Parameter                              | Type                                   | Required                               | Description                            |
| -------------------------------------- | -------------------------------------- | -------------------------------------- | -------------------------------------- |
| `waitlist_entry_id`                    | *::String*                             | :heavy_check_mark:                     | The ID of the waitlist entry to reject |

### Response

**[Crystalline::Nilable.new(Models::Operations::RejectWaitlistEntryResponse)](../../models/operations/rejectwaitlistentryresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 404, 409, 422          | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |