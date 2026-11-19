# SAMLConnectionIdpCertificate1


## Fields

| Field                                                | Type                                                 | Required                                             | Description                                          |
| ---------------------------------------------------- | ---------------------------------------------------- | ---------------------------------------------------- | ---------------------------------------------------- |
| `certificate`                                        | *::String*                                           | :heavy_check_mark:                                   | The X.509 certificate, base64 DER without PEM armor  |
| `issued_at`                                          | *Crystalline::Nilable.new(::Integer)*                | :heavy_check_mark:                                   | Unix timestamp (milliseconds) of the X.509 NotBefore |
| `expires_at`                                         | *Crystalline::Nilable.new(::Integer)*                | :heavy_check_mark:                                   | Unix timestamp (milliseconds) of the X.509 NotAfter  |