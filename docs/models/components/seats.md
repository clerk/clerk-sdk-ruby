# Seats

Seat quantity for seat-based billing.


## Fields

| Field                                                                                                                 | Type                                                                                                                  | Required                                                                                                              | Description                                                                                                           |
| --------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------- |
| `quantity`                                                                                                            | *Crystalline::Nilable.new(::Integer)*                                                                                 | :heavy_check_mark:                                                                                                    | Seat quantity being billed; null means unlimited                                                                      |
| `tiers`                                                                                                               | Crystalline::Array<[Models::Components::CommercePerUnitTotalTier2](../../models/shared/commerceperunittotaltier2.md)> | :heavy_minus_sign:                                                                                                    | Per-unit cost breakdown by pricing tier                                                                               |