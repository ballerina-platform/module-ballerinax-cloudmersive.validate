## Overview

The Cloudmersive Validate connector provides programmatic access to the [Cloudmersive Validation API](https://api.cloudmersive.com/docs/validate.asp), which helps you validate and enrich data such as email addresses, domains, URLs, phone numbers, postal addresses, names, VAT numbers and IP addresses. This connector supports version 1 of the API and lets Ballerina applications call every validation operation through remote methods.

### Key features

- Validate and normalize postal addresses, countries and geocodes
- Validate email addresses, domains, URLs and phone numbers
- Check IP addresses and URLs for threats, and geolocate IP addresses
- Detect SQL injection, XSS and XXE attacks in text input
- Parse names, user-agent strings, dates and VAT numbers
- Authenticate with a single Cloudmersive API key

## Setup guide

To use this connector you need a Cloudmersive API key.

1. Sign up or log in at the [Cloudmersive portal](https://account.cloudmersive.com/).
2. Open the **API Keys** page of your account.
3. Create a new API key, or copy an existing one.
4. Supply the key as the `apikey` field when you initialize the client. Keep it out of source control, for example by reading it from `Config.toml`.

## Quickstart

1. Add the import:

    ```ballerina
    import ballerinax/cloudmersive.validate;
    ```

2. Create a `Config.toml` with your API key:

    ```toml
    apiKey = "<YOUR_API_KEY>"
    ```

3. Declare the configurable for the API key:

    ```ballerina
    configurable string apiKey = ?;
    ```

4. Create the client and invoke an operation. Operations that take a plain string body expect a JSON string, so enclose the value in double-quotes:

    ```ballerina
    public function main() returns error? {
        validate:Client validateClient = check new ({apikey: apiKey});
        validate:CheckResponse _ = check validateClient->validateDomain("\"cloudmersive.com\"");
    }
    ```

## Examples

The `Cloudmersive Validate` connector provides practical examples illustrating usage in various scenarios. Explore these [examples](https://github.com/ballerina-platform/module-ballerinax-cloudmersive.validate/tree/main/examples/), covering the following use cases:

- [signup_data_validation](../examples/signup_data_validation/signup_data_validation.md) - Validate the email address, full name and phone number from a sign-up form.
- [request_threat_screening](../examples/request_threat_screening/request_threat_screening.md) - Screen a web request by checking the client IP, referring URL and submitted text for threats.
