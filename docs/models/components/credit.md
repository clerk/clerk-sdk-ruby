# Credit

Credit information (only available in PaymentAttempt events).


## Fields

| Field                                                                                             | Type                                                                                              | Required                                                                                          | Description                                                                                       |
| ------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------- |
| `amount`                                                                                          | [Crystalline::Nilable.new(Models::Components::CreditAmount)](../../models/shared/creditamount.md) | :heavy_minus_sign:                                                                                | Credit amount.                                                                                    |
| `cycle_remaining_percent`                                                                         | *Crystalline::Nilable.new(::Float)*                                                               | :heavy_minus_sign:                                                                                | Percentage of the billing cycle remaining.                                                        |