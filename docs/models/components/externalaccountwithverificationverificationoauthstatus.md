# ExternalAccountWithVerificationVerificationOauthStatus

## Example Usage

```ruby
require "clerk-sdk-ruby"

value = ExternalAccountWithVerificationVerificationOauthStatus::UNVERIFIED

# Open enum: use .deserialize() to create instances from custom string values
custom = ExternalAccountWithVerificationVerificationOauthStatus.deserialize("custom_value")
```


## Values

| Name           | Value          |
| -------------- | -------------- |
| `UNVERIFIED`   | unverified     |
| `VERIFIED`     | verified       |
| `FAILED`       | failed         |
| `EXPIRED`      | expired        |
| `TRANSFERABLE` | transferable   |