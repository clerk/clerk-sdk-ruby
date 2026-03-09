# EmailAddressObject

String representing the object's type. Objects of the same type share the same value.


## Example Usage

```ruby
require "clerk-sdk-ruby"

value = EmailAddressObject::EMAIL_ADDRESS

# Open enum: use .deserialize() to create instances from custom string values
custom = EmailAddressObject.deserialize("custom_value")
```


## Values

| Name            | Value           |
| --------------- | --------------- |
| `EMAIL_ADDRESS` | email_address   |