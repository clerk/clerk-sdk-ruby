# ClerkErrors

Request was not successful


## Fields

| Field                                                                                                   | Type                                                                                                    | Required                                                                                                | Description                                                                                             |
| ------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------- |
| `errors`                                                                                                | Crystalline::Array<[Models::Components::ClerkError](../../models/shared/clerkerror.md)>                 | :heavy_check_mark:                                                                                      | N/A                                                                                                     |
| `meta`                                                                                                  | [Crystalline::Nilable.new(Models::Components::ClerkErrorsMeta)](../../models/shared/clerkerrorsmeta.md) | :heavy_minus_sign:                                                                                      | N/A                                                                                                     |
| `raw_response`                                                                                          | [Faraday::Response](https://www.rubydoc.info/gems/faraday/Faraday/Response)                             | :heavy_minus_sign:                                                                                      | Raw HTTP response; suitable for custom response parsing                                                 |