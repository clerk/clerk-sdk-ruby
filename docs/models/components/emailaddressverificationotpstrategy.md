# EmailAddressVerificationOtpStrategy

## Example Usage

```ruby
require "clerk-sdk-ruby"

value = EmailAddressVerificationOtpStrategy::PHONE_CODE

# Open enum: use .deserialize() to create instances from custom string values
custom = EmailAddressVerificationOtpStrategy.deserialize("custom_value")
```


## Values

| Name                        | Value                       |
| --------------------------- | --------------------------- |
| `PHONE_CODE`                | phone_code                  |
| `EMAIL_CODE`                | email_code                  |
| `RESET_PASSWORD_EMAIL_CODE` | reset_password_email_code   |