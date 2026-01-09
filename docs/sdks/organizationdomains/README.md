# OrganizationDomains

## Overview

### Available Operations

* [create](#create) - Create a new organization domain.
* [list](#list) - Get a list of all domains of an organization.
* [update](#update) - Update an organization domain.
* [delete](#delete) - Remove a domain from an organization.
* [list_all](#list_all) - List all organization domains

## create

Creates a new organization domain. By default the domain is verified, but can be optionally set to unverified.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="CreateOrganizationDomain" method="post" path="/organizations/{organization_id}/domains" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.organization_domains.create(organization_id: '<id>', body: Models::Operations::CreateOrganizationDomainRequestBody.new())

unless res.organization_domain.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                                 | Type                                                                                                                      | Required                                                                                                                  | Description                                                                                                               |
| ------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------- |
| `organization_id`                                                                                                         | *::String*                                                                                                                | :heavy_check_mark:                                                                                                        | The ID of the organization where the new domain will be created.                                                          |
| `body`                                                                                                                    | [Models::Operations::CreateOrganizationDomainRequestBody](../../models/operations/createorganizationdomainrequestbody.md) | :heavy_check_mark:                                                                                                        | N/A                                                                                                                       |

### Response

**[Crystalline::Nilable.new(Models::Operations::CreateOrganizationDomainResponse)](../../models/operations/createorganizationdomainresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 403, 404, 422          | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## list

Get a list of all domains of an organization.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="ListOrganizationDomains" method="get" path="/organizations/{organization_id}/domains" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

req = Models::Operations::ListOrganizationDomainsRequest.new(
  organization_id: '<id>',
)

res = s.organization_domains.list(request: req)

unless res.organization_domains.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                       | Type                                                                                                            | Required                                                                                                        | Description                                                                                                     |
| --------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------- |
| `request`                                                                                                       | [Models::Operations::ListOrganizationDomainsRequest](../../models/operations/listorganizationdomainsrequest.md) | :heavy_check_mark:                                                                                              | The request object to use for the request.                                                                      |

### Response

**[Crystalline::Nilable.new(Models::Operations::ListOrganizationDomainsResponse)](../../models/operations/listorganizationdomainsresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 401, 422                    | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## update

Updates the properties of an existing organization domain.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="UpdateOrganizationDomain" method="patch" path="/organizations/{organization_id}/domains/{domain_id}" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.organization_domains.update(organization_id: '<id>', domain_id: '<id>', body: Models::Operations::UpdateOrganizationDomainRequestBody.new())

unless res.organization_domain.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                                 | Type                                                                                                                      | Required                                                                                                                  | Description                                                                                                               |
| ------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------- |
| `organization_id`                                                                                                         | *::String*                                                                                                                | :heavy_check_mark:                                                                                                        | The ID of the organization to which the domain belongs                                                                    |
| `domain_id`                                                                                                               | *::String*                                                                                                                | :heavy_check_mark:                                                                                                        | The ID of the domain                                                                                                      |
| `body`                                                                                                                    | [Models::Operations::UpdateOrganizationDomainRequestBody](../../models/operations/updateorganizationdomainrequestbody.md) | :heavy_check_mark:                                                                                                        | N/A                                                                                                                       |

### Response

**[Crystalline::Nilable.new(Models::Operations::UpdateOrganizationDomainResponse)](../../models/operations/updateorganizationdomainresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 404, 422               | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## delete

Removes the given domain from the organization.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="DeleteOrganizationDomain" method="delete" path="/organizations/{organization_id}/domains/{domain_id}" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.organization_domains.delete(organization_id: '<id>', domain_id: '<id>')

unless res.deleted_object.nil?
  # handle response
end

```

### Parameters

| Parameter                                              | Type                                                   | Required                                               | Description                                            |
| ------------------------------------------------------ | ------------------------------------------------------ | ------------------------------------------------------ | ------------------------------------------------------ |
| `organization_id`                                      | *::String*                                             | :heavy_check_mark:                                     | The ID of the organization to which the domain belongs |
| `domain_id`                                            | *::String*                                             | :heavy_check_mark:                                     | The ID of the domain                                   |

### Response

**[Crystalline::Nilable.new(Models::Operations::DeleteOrganizationDomainResponse)](../../models/operations/deleteorganizationdomainresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 401, 404               | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## list_all

Retrieves a list of all organization domains within the current instance.
This endpoint can be used to list all domains across all organizations
or filter domains by organization, verification status, enrollment mode, or search query.

The response includes pagination information and details about each domain
including its verification status, enrollment mode, and associated counts.


### Example Usage

<!-- UsageSnippet language="ruby" operationID="ListAllOrganizationDomains" method="get" path="/organization_domains" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

req = Models::Operations::ListAllOrganizationDomainsRequest.new()

res = s.organization_domains.list_all(request: req)

unless res.organization_domains.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                             | Type                                                                                                                  | Required                                                                                                              | Description                                                                                                           |
| --------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------- |
| `request`                                                                                                             | [Models::Operations::ListAllOrganizationDomainsRequest](../../models/operations/listallorganizationdomainsrequest.md) | :heavy_check_mark:                                                                                                    | The request object to use for the request.                                                                            |

### Response

**[Crystalline::Nilable.new(Models::Operations::ListAllOrganizationDomainsResponse)](../../models/operations/listallorganizationdomainsresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 401, 403, 422               | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |