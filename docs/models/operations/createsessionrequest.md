# CreateSessionRequest


## Fields

| Field                                                        | Type                                                         | Required                                                     | Description                                                  |
| ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| `user_id`                                                    | *::String*                                                   | :heavy_check_mark:                                           | The ID representing the user                                 |
| `active_organization_id`                                     | *Crystalline::Nilable.new(::String)*                         | :heavy_minus_sign:                                           | The ID of the organization to set as active for this session |