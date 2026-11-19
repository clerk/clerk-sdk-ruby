# Act

The actor chain of an access token issued by an OAuth 2.0 Token Exchange (RFC 8693 section 4.1). Omitted for other access tokens.


## Fields

| Field                                                                                     | Type                                                                                      | Required                                                                                  | Description                                                                               |
| ----------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------- |
| `iss`                                                                                     | *Crystalline::Nilable.new(::String)*                                                      | :heavy_minus_sign:                                                                        | N/A                                                                                       |
| `sub`                                                                                     | *::String*                                                                                | :heavy_check_mark:                                                                        | N/A                                                                                       |
| `act`                                                                                     | [Crystalline::Nilable.new(Models::Operations::ActAct)](../../models/operations/actact.md) | :heavy_minus_sign:                                                                        | N/A                                                                                       |