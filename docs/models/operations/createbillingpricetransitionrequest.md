# CreateBillingPriceTransitionRequest


## Fields

| Field                                                                                       | Type                                                                                        | Required                                                                                    | Description                                                                                 |
| ------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------- |
| `subscription_item_id`                                                                      | *::String*                                                                                  | :heavy_check_mark:                                                                          | The ID of the subscription item to transition                                               |
| `body`                                                                                      | [Models::Components::PriceTransitionRequest](../../models/shared/pricetransitionrequest.md) | :heavy_check_mark:                                                                          | Parameters for the price transition                                                         |