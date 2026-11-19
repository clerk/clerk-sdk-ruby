# DirectoryGroup

A group reported by the identity provider for a directory.


## Fields

| Field                                                                                      | Type                                                                                       | Required                                                                                   | Description                                                                                |
| ------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------ |
| `object`                                                                                   | [Models::Components::DirectoryGroupObject](../../models/shared/directorygroupobject.md)    | :heavy_check_mark:                                                                         | String representing the object's type. Always "directory_group".                           |
| `id`                                                                                       | *::String*                                                                                 | :heavy_check_mark:                                                                         | The group ID from the identity provider.                                                   |
| `display_name`                                                                             | *::String*                                                                                 | :heavy_check_mark:                                                                         | The display name of the group.                                                             |
| `updated_at`                                                                               | *::Integer*                                                                                | :heavy_check_mark:                                                                         | Unix timestamp (milliseconds) of when the group was last updated on the identity provider. |