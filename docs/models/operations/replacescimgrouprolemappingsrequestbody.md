# ReplaceSCIMGroupRoleMappingsRequestBody


## Fields

| Field                                                                                                     | Type                                                                                                      | Required                                                                                                  | Description                                                                                               |
| --------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------- |
| `mappings`                                                                                                | Crystalline::Array<[Models::Operations::Mapping](../../models/operations/mapping.md)>                     | :heavy_check_mark:                                                                                        | The desired set of mappings. Array order sets precedence (1-indexed). An empty array clears all mappings. |