# DirectoryGroupList

A cursor-paginated list of groups for a directory.


## Fields

| Field                                                                                           | Type                                                                                            | Required                                                                                        | Description                                                                                     |
| ----------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------- |
| `data`                                                                                          | Crystalline::Array<[Models::Components::DirectoryGroup](../../models/shared/directorygroup.md)> | :heavy_check_mark:                                                                              | N/A                                                                                             |
| `cursor`                                                                                        | [Models::Components::DirectoryGroupListCursor](../../models/shared/directorygrouplistcursor.md) | :heavy_check_mark:                                                                              | Cursor information for pagination.                                                              |