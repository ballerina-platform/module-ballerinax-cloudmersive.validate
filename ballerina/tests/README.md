# Running Tests

## Prerequisites

You need a Cloudmersive API key to run the tests against the live API. The default mock run needs no credentials.

## Test environments

The suite runs in two modes.

| Mode | How to run | Behaviour |
|---|---|---|
| Mock server (default) | `bal test` | Requests are served by `tests/mock_service.bal` on `localhost:9090` |
| Live server | `IS_LIVE_SERVER=true CLOUDMERSIVE_API_KEY=<key> bal test` | Requests go to `https://api.cloudmersive.com/validate` |

The tests read `IS_LIVE_SERVER` and `CLOUDMERSIVE_API_KEY` from the environment.

## Coverage

The mock server and the tests cover 25 of the connector's operations across address, date and time, domain and URL, email, IP address, lead enrichment, name, phone number, text input and user-agent validation, and VAT lookup. Each test is tagged with the `live_tests` and `mock_tests` groups.

```bash
bal test --groups mock_tests
```
