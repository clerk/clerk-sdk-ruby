# Token


## Fields

| Field                                                                                  | Type                                                                                   | Required                                                                               | Description                                                                            |
| -------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------- |
| `object`                                                                               | [Models::Components::TokenObject](../../models/shared/tokenobject.md)                  | :heavy_check_mark:                                                                     | String representing the object's type. Objects of the same type share the same value.<br/> |
| `jwt`                                                                                  | *::String*                                                                             | :heavy_check_mark:                                                                     | String representing the encoded JSON Web Token (JWT) value.<br/>                       |