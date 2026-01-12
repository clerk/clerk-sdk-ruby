# NextInvoice

Information about the next invoice.


## Fields

| Field                                                                                                       | Type                                                                                                        | Required                                                                                                    | Description                                                                                                 |
| ----------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------- |
| `amount`                                                                                                    | [Crystalline::Nilable.new(Models::Components::NextInvoiceAmount)](../../models/shared/nextinvoiceamount.md) | :heavy_minus_sign:                                                                                          | Amount for the next payment.                                                                                |
| `date`                                                                                                      | *Crystalline::Nilable.new(::Integer)*                                                                       | :heavy_minus_sign:                                                                                          | Unix timestamp (in milliseconds) for the next payment date.                                                 |