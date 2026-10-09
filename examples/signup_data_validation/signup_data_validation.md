# Sign-up data validation

Validates the contact details submitted in a sign-up form. The example fully validates the email address, parses and checks the full name, and validates the phone number, then reports whether the sign-up should be accepted.

## Prerequisites

- Ballerina Swan Lake 2201.12.0 or later
- A Cloudmersive API key
- Create a `Config.toml` in this directory:
  ```toml
  apiKey = "<YOUR_API_KEY>"
  email = "<EMAIL_ADDRESS>"
  fullName = "<FULL_NAME>"
  phoneNumber = "<PHONE_NUMBER>"
  defaultCountryCode = "US"
  ```

## Run the example

```bash
bal run
```
