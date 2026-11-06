_Author_:  @DimuthuMadushan \
_Created_: 2026/10/09 \
_Updated_: 2026/10/09 \
_Edition_: Swan Lake

# Sanitation for OpenAPI specification

This document records the sanitation done on top of the official OpenAPI specification from Cloudmersive Validate. 
The OpenAPI specification is obtained from [`wso2/api-specs`](https://github.com/wso2/api-specs/blob/main/openapi/cloudmersive/validate/v1/openapi.json).
These changes are done in order to improve the overall usability, and as workarounds for some known language limitations.


1. Update the API Paths
- **Original**: Paths included common prefix `/validate` in each endpoint.
- **Updated**: Common prefix removed from endpoints as it is now in the base URL.
- **Reason**: Simplifies API paths and avoids duplication.
<!-- auto-generated -->

2. Remove empty per-operation `consumes`
- **Original**: `Address_CountryList` (`POST /validate/address/country/list`) and `DateTime_GetNowSimple` (`GET /validate/date-time/get/now`) declared `"consumes": []`.
- **Updated**: The empty `consumes` arrays are deleted so the operations inherit the default media types.
- **Reason**: An empty per-operation `consumes` overrides the defaults and degrades the generated signatures.

3. Change the API host
- **Original**: `host` was `testapi.cloudmersive.com`.
- **Updated**: `host` is `api.cloudmersive.com`.
- **Reason**: The test host is not the public service; the connector's default `serviceUrl` must target the production API.

4. Remove the doubled slash from the server URL (hand edit to the aligned spec; re-apply after a re-align)
- **Original**: After flatten and align, `servers[0].url` was `https://api.cloudmersive.com//validate`.
- **Updated**: `servers[0].url` is `https://api.cloudmersive.com/validate`.
- **Reason**: Flatten leaves a trailing slash on the host and align appends the `/validate` prefix to it, producing `//` in the default `serviceUrl`.

5. Restore the description of `IPIntelligenceResponse.Location` (hand edit to the aligned spec; re-apply after a re-align)
- **Original**: `Location` is a `$ref` to `GeolocateResponse` with a sibling `description` ("Returns the location of the IP address"), which is dropped when the `$ref` is wrapped in `allOf` during conversion.
- **Updated**: The aligned spec's `Location` property carries `"description": "Returns the location of the IP address"` beside its `allOf`.
- **Reason**: Without it the generated `location` field is undocumented and `bal build` warns.

6. Remove a malformed entry from the `GetGenderRequest.CountryCode` description
- **Original**: The list of possible values contained the malformed entry `DANIL"O""` between `"RO"` and `"ES"`.
- **Updated**: The entry is removed from the description in the original spec and in the aligned spec.
- **Reason**: It is not a country code (`"DO"` is already listed) and it rendered as broken documentation in the generated `types.bal`.

## OpenAPI cli command

The following command was used to generate the Ballerina client from the OpenAPI specification. The command should be executed from the repository root directory.

```bash
bal openapi -i docs/spec/aligned_ballerina_openapi.json -o ballerina --mode client --client-methods remote --license docs/license.txt
```

Note: The license year is hardcoded to 2026, change if necessary.
