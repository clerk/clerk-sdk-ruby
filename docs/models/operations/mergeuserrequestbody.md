# MergeUserRequestBody


## Fields

| Field                                                                        | Type                                                                         | Required                                                                     | Description                                                                  |
| ---------------------------------------------------------------------------- | ---------------------------------------------------------------------------- | ---------------------------------------------------------------------------- | ---------------------------------------------------------------------------- |
| `from_user_id`                                                               | *::String*                                                                   | :heavy_check_mark:                                                           | The ID of the user to merge into the user in the path. This user is deleted. |
| `dry_run`                                                                    | *Crystalline::Nilable.new(Crystalline::Boolean.new)*                         | :heavy_minus_sign:                                                           | Return the merged user without changing anything.                            |