# BillingPaymentAttemptDiscountsProration

Proration details from passed subscription time


## Fields

| Field                                                                                     | Type                                                                                      | Required                                                                                  | Description                                                                               |
| ----------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------- |
| `amount`                                                                                  | [Models::Components::CommerceMoneyResponse](../../models/shared/commercemoneyresponse.md) | :heavy_check_mark:                                                                        | N/A                                                                                       |
| `cycle_days_passed`                                                                       | *::Integer*                                                                               | :heavy_check_mark:                                                                        | Number of days that have passed in the billing cycle                                      |
| `cycle_days_total`                                                                        | *::Integer*                                                                               | :heavy_check_mark:                                                                        | Total number of days in the billing cycle                                                 |
| `cycle_passed_percent`                                                                    | *::Float*                                                                                 | :heavy_check_mark:                                                                        | Percentage of the billing cycle that has passed                                           |