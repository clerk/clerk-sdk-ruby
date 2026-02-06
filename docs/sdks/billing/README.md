# Billing

## Overview

### Available Operations

* [list_plans](#list_plans) - List all billing plans
* [list_prices](#list_prices) - List all billing prices
* [create_price](#create_price) - Create a custom billing price
* [list_subscription_items](#list_subscription_items) - List all subscription items
* [cancel_subscription_item](#cancel_subscription_item) - Cancel a subscription item
* [extend_subscription_item_free_trial](#extend_subscription_item_free_trial) - Extend free trial for a subscription item
* [create_price_transition](#create_price_transition) - Create a price transition for a subscription item
* [list_statements](#list_statements) - List all billing statements
* [get_statement](#get_statement) - Retrieve a billing statement
* [get_statement_payment_attempts](#get_statement_payment_attempts) - List payment attempts for a billing statement

## list_plans

Returns a list of all billing plans for the instance. The plans are returned sorted by creation date,
with the newest plans appearing first. This includes both free and paid plans. Pagination is supported.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="GetCommercePlanList" method="get" path="/billing/plans" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.billing.list_plans(limit: 10, offset: 0)

unless res.paginated_commerce_plan_response.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                                                 | Type                                                                                                                                      | Required                                                                                                                                  | Description                                                                                                                               |
| ----------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------- |
| `paginated`                                                                                                                               | *Crystalline::Nilable.new(Crystalline::Boolean.new)*                                                                                      | :heavy_minus_sign:                                                                                                                        | Whether to paginate the results.<br/>If true, the results will be paginated.<br/>If false, the results will not be paginated.             |
| `limit`                                                                                                                                   | *Crystalline::Nilable.new(::Integer)*                                                                                                     | :heavy_minus_sign:                                                                                                                        | Applies a limit to the number of results returned.<br/>Can be used for paginating the results together with `offset`.                     |
| `offset`                                                                                                                                  | *Crystalline::Nilable.new(::Integer)*                                                                                                     | :heavy_minus_sign:                                                                                                                        | Skip the first `offset` results when paginating.<br/>Needs to be an integer greater or equal to zero.<br/>To be used in conjunction with `limit`. |
| `payer_type`                                                                                                                              | [Crystalline::Nilable.new(Models::Operations::GetCommercePlanListPayerType)](../../models/operations/getcommerceplanlistpayertype.md)     | :heavy_minus_sign:                                                                                                                        | Filter plans by payer type                                                                                                                |

### Response

**[Crystalline::Nilable.new(Models::Operations::GetCommercePlanListResponse)](../../models/operations/getcommerceplanlistresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 401, 422               | application/json            |
| Models::Errors::ClerkErrors | 500                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## list_prices

Returns a list of all prices for the instance. The prices are returned sorted by amount ascending,
then by creation date descending. This includes both default and custom prices. Pagination is supported.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="GetBillingPriceList" method="get" path="/billing/prices" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.billing.list_prices(limit: 10, offset: 0)

unless res.paginated_billing_price_response.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                                                 | Type                                                                                                                                      | Required                                                                                                                                  | Description                                                                                                                               |
| ----------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------- |
| `paginated`                                                                                                                               | *Crystalline::Nilable.new(Crystalline::Boolean.new)*                                                                                      | :heavy_minus_sign:                                                                                                                        | Whether to paginate the results.<br/>If true, the results will be paginated.<br/>If false, the results will not be paginated.             |
| `limit`                                                                                                                                   | *Crystalline::Nilable.new(::Integer)*                                                                                                     | :heavy_minus_sign:                                                                                                                        | Applies a limit to the number of results returned.<br/>Can be used for paginating the results together with `offset`.                     |
| `offset`                                                                                                                                  | *Crystalline::Nilable.new(::Integer)*                                                                                                     | :heavy_minus_sign:                                                                                                                        | Skip the first `offset` results when paginating.<br/>Needs to be an integer greater or equal to zero.<br/>To be used in conjunction with `limit`. |
| `plan_id`                                                                                                                                 | *Crystalline::Nilable.new(::String)*                                                                                                      | :heavy_minus_sign:                                                                                                                        | Filter prices by plan ID                                                                                                                  |

### Response

**[Crystalline::Nilable.new(Models::Operations::GetBillingPriceListResponse)](../../models/operations/getbillingpricelistresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 401, 404, 422          | application/json            |
| Models::Errors::ClerkErrors | 500                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## create_price

Creates a custom price for a billing plan. Custom prices allow you to offer different pricing
to specific customers while maintaining the same plan structure.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="CreateBillingPrice" method="post" path="/billing/prices" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

req = Models::Components::CreateBillingPriceRequest.new(
  plan_id: '<id>',
  amount: 826_545,
)

res = s.billing.create_price(request: req)

unless res.billing_price_response.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                         | Type                                                                                              | Required                                                                                          | Description                                                                                       |
| ------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------- |
| `request`                                                                                         | [Models::Components::CreateBillingPriceRequest](../../models/shared/createbillingpricerequest.md) | :heavy_check_mark:                                                                                | The request object to use for the request.                                                        |

### Response

**[Crystalline::Nilable.new(Models::Operations::CreateBillingPriceResponse)](../../models/operations/createbillingpriceresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 401, 404, 422          | application/json            |
| Models::Errors::ClerkErrors | 500                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## list_subscription_items

Returns a list of all subscription items for the instance. The subscription items are returned sorted by creation date,
with the newest appearing first. This includes subscriptions for both users and organizations. Pagination is supported.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="GetCommerceSubscriptionItemList" method="get" path="/billing/subscription_items" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

req = Models::Operations::GetCommerceSubscriptionItemListRequest.new()

res = s.billing.list_subscription_items(request: req)

unless res.paginated_commerce_subscription_item_response.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                                       | Type                                                                                                                            | Required                                                                                                                        | Description                                                                                                                     |
| ------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------- |
| `request`                                                                                                                       | [Models::Operations::GetCommerceSubscriptionItemListRequest](../../models/operations/getcommercesubscriptionitemlistrequest.md) | :heavy_check_mark:                                                                                                              | The request object to use for the request.                                                                                      |

### Response

**[Crystalline::Nilable.new(Models::Operations::GetCommerceSubscriptionItemListResponse)](../../models/operations/getcommercesubscriptionitemlistresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 401, 422               | application/json            |
| Models::Errors::ClerkErrors | 500                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## cancel_subscription_item

Cancel a specific subscription item. The subscription item can be canceled immediately or at the end of the current billing period.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="CancelCommerceSubscriptionItem" method="delete" path="/billing/subscription_items/{subscription_item_id}" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.billing.cancel_subscription_item(subscription_item_id: '<id>', end_now: false)

unless res.commerce_subscription_item.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                          | Type                                                                                                               | Required                                                                                                           | Description                                                                                                        |
| ------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------ |
| `subscription_item_id`                                                                                             | *::String*                                                                                                         | :heavy_check_mark:                                                                                                 | The ID of the subscription item to cancel                                                                          |
| `end_now`                                                                                                          | *Crystalline::Nilable.new(Crystalline::Boolean.new)*                                                               | :heavy_minus_sign:                                                                                                 | Whether to cancel the subscription immediately (true) or at the end of the current billing period (false, default) |

### Response

**[Crystalline::Nilable.new(Models::Operations::CancelCommerceSubscriptionItemResponse)](../../models/operations/cancelcommercesubscriptionitemresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 401, 403, 404, 422     | application/json            |
| Models::Errors::ClerkErrors | 500                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## extend_subscription_item_free_trial

Extends the free trial period for a specific subscription item to the specified timestamp.
The subscription item must be currently in a free trial period, and the plan must support free trials.
The timestamp must be in the future and not more than 365 days from the end of the current trial period
This operation is idempotent - repeated requests with the same timestamp will not change the trial period.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="ExtendBillingSubscriptionItemFreeTrial" method="post" path="/billing/subscription_items/{subscription_item_id}/extend_free_trial" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.billing.extend_subscription_item_free_trial(subscription_item_id: '<id>', body: Models::Components::ExtendFreeTrialRequest.new(
  extend_to: DateTime.iso8601('2026-01-08T00:00:00Z'),
))

unless res.schemas_commerce_subscription_item.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                   | Type                                                                                        | Required                                                                                    | Description                                                                                 |
| ------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------- |
| `subscription_item_id`                                                                      | *::String*                                                                                  | :heavy_check_mark:                                                                          | The ID of the subscription item to extend the free trial for                                |
| `body`                                                                                      | [Models::Components::ExtendFreeTrialRequest](../../models/shared/extendfreetrialrequest.md) | :heavy_check_mark:                                                                          | Parameters for extending the free trial                                                     |

### Response

**[Crystalline::Nilable.new(Models::Operations::ExtendBillingSubscriptionItemFreeTrialResponse)](../../models/operations/extendbillingsubscriptionitemfreetrialresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 401, 403, 404, 422     | application/json            |
| Models::Errors::ClerkErrors | 500                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## create_price_transition

Creates a price transition for the specified subscription item.
This may create an upcoming subscription item or activate immediately depending on plan and payer rules.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="CreateBillingPriceTransition" method="post" path="/billing/subscription_items/{subscription_item_id}/price_transition" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.billing.create_price_transition(subscription_item_id: '<id>', body: Models::Components::PriceTransitionRequest.new(
  from_price_id: '<id>',
  to_price_id: '<id>',
))

unless res.commerce_price_transition_response.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                   | Type                                                                                        | Required                                                                                    | Description                                                                                 |
| ------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------- |
| `subscription_item_id`                                                                      | *::String*                                                                                  | :heavy_check_mark:                                                                          | The ID of the subscription item to transition                                               |
| `body`                                                                                      | [Models::Components::PriceTransitionRequest](../../models/shared/pricetransitionrequest.md) | :heavy_check_mark:                                                                          | Parameters for the price transition                                                         |

### Response

**[Crystalline::Nilable.new(Models::Operations::CreateBillingPriceTransitionResponse)](../../models/operations/createbillingpricetransitionresponse.md)**

### Errors

| Error Type                   | Status Code                  | Content Type                 |
| ---------------------------- | ---------------------------- | ---------------------------- |
| Models::Errors::ClerkErrors  | 400, 401, 403, 404, 409, 422 | application/json             |
| Models::Errors::ClerkErrors  | 500                          | application/json             |
| Errors::APIError             | 4XX, 5XX                     | \*/\*                        |

## list_statements

Returns a list of all billing statements for the instance. The statements are returned sorted by creation date,
with the newest statements appearing first. Pagination is supported.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="GetBillingStatementList" method="get" path="/billing/statements" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.billing.list_statements(limit: 10, offset: 0)

unless res.paginated_billing_statement_response.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                                                 | Type                                                                                                                                      | Required                                                                                                                                  | Description                                                                                                                               |
| ----------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------- |
| `paginated`                                                                                                                               | *Crystalline::Nilable.new(Crystalline::Boolean.new)*                                                                                      | :heavy_minus_sign:                                                                                                                        | Whether to paginate the results.<br/>If true, the results will be paginated.<br/>If false, the results will not be paginated.             |
| `limit`                                                                                                                                   | *Crystalline::Nilable.new(::Integer)*                                                                                                     | :heavy_minus_sign:                                                                                                                        | Applies a limit to the number of results returned.<br/>Can be used for paginating the results together with `offset`.                     |
| `offset`                                                                                                                                  | *Crystalline::Nilable.new(::Integer)*                                                                                                     | :heavy_minus_sign:                                                                                                                        | Skip the first `offset` results when paginating.<br/>Needs to be an integer greater or equal to zero.<br/>To be used in conjunction with `limit`. |

### Response

**[Crystalline::Nilable.new(Models::Operations::GetBillingStatementListResponse)](../../models/operations/getbillingstatementlistresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 401, 422               | application/json            |
| Models::Errors::ClerkErrors | 500                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## get_statement

Retrieves the details of a billing statement.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="GetBillingStatement" method="get" path="/billing/statements/{statementID}" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.billing.get_statement(statement_id: '<id>')

unless res.billing_statement.nil?
  # handle response
end

```

### Parameters

| Parameter                            | Type                                 | Required                             | Description                          |
| ------------------------------------ | ------------------------------------ | ------------------------------------ | ------------------------------------ |
| `statement_id`                       | *::String*                           | :heavy_check_mark:                   | The ID of the statement to retrieve. |

### Response

**[Crystalline::Nilable.new(Models::Operations::GetBillingStatementResponse)](../../models/operations/getbillingstatementresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 401, 404, 422          | application/json            |
| Models::Errors::ClerkErrors | 500                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## get_statement_payment_attempts

Returns a list of all payment attempts for a specific billing statement. The payment attempts are returned sorted by creation date,
with the newest payment attempts appearing first. Pagination is supported.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="GetBillingStatementPaymentAttempts" method="get" path="/billing/statements/{statementID}/payment_attempts" -->
```ruby
require 'clerk_sdk_ruby'

Models = ::Clerk::Models
s = ::Clerk::OpenAPIClient.new(
      bearer_auth: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.billing.get_statement_payment_attempts(statement_id: '<id>', limit: 10, offset: 0)

unless res.paginated_billing_payment_attempt_response.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                                                 | Type                                                                                                                                      | Required                                                                                                                                  | Description                                                                                                                               |
| ----------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------- |
| `statement_id`                                                                                                                            | *::String*                                                                                                                                | :heavy_check_mark:                                                                                                                        | The ID of the statement to retrieve payment attempts for.                                                                                 |
| `paginated`                                                                                                                               | *Crystalline::Nilable.new(Crystalline::Boolean.new)*                                                                                      | :heavy_minus_sign:                                                                                                                        | Whether to paginate the results.<br/>If true, the results will be paginated.<br/>If false, the results will not be paginated.             |
| `limit`                                                                                                                                   | *Crystalline::Nilable.new(::Integer)*                                                                                                     | :heavy_minus_sign:                                                                                                                        | Applies a limit to the number of results returned.<br/>Can be used for paginating the results together with `offset`.                     |
| `offset`                                                                                                                                  | *Crystalline::Nilable.new(::Integer)*                                                                                                     | :heavy_minus_sign:                                                                                                                        | Skip the first `offset` results when paginating.<br/>Needs to be an integer greater or equal to zero.<br/>To be used in conjunction with `limit`. |

### Response

**[Crystalline::Nilable.new(Models::Operations::GetBillingStatementPaymentAttemptsResponse)](../../models/operations/getbillingstatementpaymentattemptsresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ClerkErrors | 400, 401, 404, 422          | application/json            |
| Models::Errors::ClerkErrors | 500                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |