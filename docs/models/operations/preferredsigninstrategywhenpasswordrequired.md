# PreferredSignInStrategyWhenPasswordRequired

When password is required at the instance level, sets the preferred sign-in strategy surfaced to Clerk components. Has no effect when password is not required. Defaults to `password`. Set to an empty string to clear the override.

## Example Usage

```ruby
require "clerk-sdk-ruby"

value = PreferredSignInStrategyWhenPasswordRequired::PASSWORD
```


## Values

| Name       | Value      |
| ---------- | ---------- |
| `PASSWORD` | password   |
| `OTP`      | otp        |
| `UNKNOWN`  |            |