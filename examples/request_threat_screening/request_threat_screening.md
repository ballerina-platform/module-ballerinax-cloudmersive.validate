# Request threat screening

Screens an incoming web request. The example checks whether the client IP address is a known threat, geolocates it, checks the referring URL for phishing, and scans a submitted text field for SQL injection before deciding whether to allow the request.

## Prerequisites

- Ballerina Swan Lake 2201.12.0 or later
- A Cloudmersive API key
- Create a `Config.toml` in this directory:
  ```toml
  apiKey = "<YOUR_API_KEY>"
  clientIp = "<CLIENT_IP_ADDRESS>"
  referrerUrl = "<REFERRER_URL>"
  submittedText = "<SUBMITTED_TEXT>"
  ```

## Run the example

```bash
bal run
```
