# CreateBillingPriceRequest


## Fields

| Field                                                               | Type                                                                | Required                                                            | Description                                                         |
| ------------------------------------------------------------------- | ------------------------------------------------------------------- | ------------------------------------------------------------------- | ------------------------------------------------------------------- |
| `plan_id`                                                           | *::String*                                                          | :heavy_check_mark:                                                  | The ID of the plan this price belongs to.                           |
| `currency`                                                          | *Crystalline::Nilable.new(::String)*                                | :heavy_minus_sign:                                                  | The currency code (e.g., "USD"). Defaults to USD.                   |
| `amount`                                                            | *::Integer*                                                         | :heavy_check_mark:                                                  | The amount in cents for the price. Must be at least $1 (100 cents). |
| `annual_monthly_amount`                                             | *Crystalline::Nilable.new(::Integer)*                               | :heavy_minus_sign:                                                  | The monthly amount in cents when billed annually. Optional.         |
| `description`                                                       | *Crystalline::Nilable.new(::String)*                                | :heavy_minus_sign:                                                  | An optional description for this custom price.                      |