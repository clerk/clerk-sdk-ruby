# UserCursorPage

A page of users from `GET /v1/users` with `pagination=cursor`.


## Fields

| Field                                                                                   | Type                                                                                    | Required                                                                                | Description                                                                             |
| --------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------- |
| `data`                                                                                  | Crystalline::Array<[Models::Components::User](../../models/shared/user.md)>             | :heavy_check_mark:                                                                      | N/A                                                                                     |
| `cursor`                                                                                | [Models::Components::UserCursorPageCursor](../../models/shared/usercursorpagecursor.md) | :heavy_check_mark:                                                                      | Cursor information for pagination.                                                      |