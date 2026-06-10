# EnterpriseConnectionSamlConnection

Present when the enterprise connection uses SAML


## Fields

| Field                                                           | Type                                                            | Required                                                        | Description                                                     |
| --------------------------------------------------------------- | --------------------------------------------------------------- | --------------------------------------------------------------- | --------------------------------------------------------------- |
| `id`                                                            | *Crystalline::Nilable.new(::String)*                            | :heavy_minus_sign:                                              | SAML connection ID                                              |
| `name`                                                          | *Crystalline::Nilable.new(::String)*                            | :heavy_minus_sign:                                              | SAML connection display name                                    |
| `idp_entity_id`                                                 | *Crystalline::Nilable.new(::String)*                            | :heavy_minus_sign:                                              | IdP entity ID (optional, when connection details are loaded)    |
| `idp_sso_url`                                                   | *Crystalline::Nilable.new(::String)*                            | :heavy_minus_sign:                                              | IdP SSO URL (optional, when connection details are loaded)      |
| `idp_metadata_url`                                              | *Crystalline::Nilable.new(::String)*                            | :heavy_minus_sign:                                              | IdP metadata URL (optional, when connection details are loaded) |
| `acs_url`                                                       | *Crystalline::Nilable.new(::String)*                            | :heavy_minus_sign:                                              | Assertion Consumer Service URL                                  |
| `sp_entity_id`                                                  | *Crystalline::Nilable.new(::String)*                            | :heavy_minus_sign:                                              | Service Provider entity ID                                      |
| `sp_metadata_url`                                               | *Crystalline::Nilable.new(::String)*                            | :heavy_minus_sign:                                              | Service Provider metadata URL                                   |
| `active`                                                        | *Crystalline::Nilable.new(Crystalline::Boolean.new)*            | :heavy_minus_sign:                                              | Whether the SAML connection is active                           |
| `allow_idp_initiated`                                           | *Crystalline::Nilable.new(Crystalline::Boolean.new)*            | :heavy_minus_sign:                                              | Whether IdP-initiated SSO is allowed                            |
| `allow_subdomains`                                              | *Crystalline::Nilable.new(Crystalline::Boolean.new)*            | :heavy_minus_sign:                                              | Whether subdomains are allowed for domain matching              |
| `force_authn`                                                   | *Crystalline::Nilable.new(Crystalline::Boolean.new)*            | :heavy_minus_sign:                                              | Whether to force re-authentication                              |