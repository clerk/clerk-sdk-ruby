# ReplaceUserEmailAddressIdentificationStatus

Controls the status of the replacement email address. Defaults to `verified`. Set to
`reserved` to create it reserved (unverified but usable for sign-in and locked)
instead of verified.

## Example Usage

```ruby
require "clerk-sdk-ruby"

value = ReplaceUserEmailAddressIdentificationStatus::VERIFIED
```


## Values

| Name       | Value      |
| ---------- | ---------- |
| `VERIFIED` | verified   |
| `RESERVED` | reserved   |