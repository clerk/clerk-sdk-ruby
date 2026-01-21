# UpdateProductionInstanceDomainRequest


## Fields

| Field                                                                    | Type                                                                     | Required                                                                 | Description                                                              |
| ------------------------------------------------------------------------ | ------------------------------------------------------------------------ | ------------------------------------------------------------------------ | ------------------------------------------------------------------------ |
| `home_url`                                                               | *Crystalline::Nilable.new(::String)*                                     | :heavy_minus_sign:                                                       | The new home URL of the production instance e.g. https://www.example.com |
| `is_secondary`                                                           | *Crystalline::Nilable.new(Crystalline::Boolean.new)*                     | :heavy_minus_sign:                                                       | Whether the domain is a secondary app.                                   |