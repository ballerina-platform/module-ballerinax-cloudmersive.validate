# Changelog

All notable changes to this project are documented in this file.
The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- `getCompanyInformation`, which gets company information from an email address, with its `EmailLead` request record.
- A `headers` parameter on every remote method. `checkSqlInjection`, `checkXxe` and `checkHtmlSsrf` take a typed headers record (`CheckSqlInjectionHeaders`, `CheckXxeHeaders` and `CheckHtmlSsrfHeaders`) for their optional settings.
- The `allowCidScheme` option on `checkHtmlSsrf`, passed in `CheckHtmlSsrfHeaders`, which allows `cid:` scheme URLs for email message attachments.
- New `ConnectionConfig` fields, taken from `http:ClientConfiguration`: `followRedirects`, `cookieConfig`, `socketConfig` and `laxDataBinding`.

### Changed

- **Breaking:** the remote methods are renamed:

    | 1.5.2 | 2.0.0 |
    |---|---|
    | `addressParseString` | `parseAddress` |
    | `addressValidateAddress` | `validateAddress` |
    | `addressNormalizeAddress` | `normalizeAddress` |
    | `addressValidateCity` | `validateCity` |
    | `addressValidateState` | `validateState` |
    | `addressValidatePostalCode` | `validatePostalCode` |
    | `addressCountry` | `validateCountry` |
    | `addressCountryList` | `listCountries` |
    | `addressCheckEumembership` | `checkEuMembership` |
    | `addressGetCountryCurrency` | `getCountryCurrency` |
    | `addressGetCountryRegion` | `getCountryRegion` |
    | `addressGetTimezone` | `getTimezones` |
    | `addressGeocode` | `geocodeAddress` |
    | `addressReverseGeocodeAddress` | `reverseGeocodeAddress` |
    | `dateTimeGetNowSimple` | `getCurrentDateTime` |
    | `dateTimeGetPublicHolidays` | `getPublicHolidays` |
    | `dateTimeParseStandardDateTime` | `parseStandardDateTime` |
    | `dateTimeParseNaturalLanguageDateTime` | `parseNaturalLanguageDateTime` |
    | `domainCheck` | `validateDomain` |
    | `domainQualityScore` | `getDomainQualityScore` |
    | `domainPost` | `getDomainWhois` |
    | `domainUrlSyntaxOnly` | `validateUrlSyntax` |
    | `domainUrlFull` | `validateUrl` |
    | `domainGetTopLevelDomainFromUrl` | `getTopLevelDomain` |
    | `domainPhishingCheck` | `checkUrlPhishing` |
    | `domainIsAdminPath` | `checkAdminPath` |
    | `domainSafetyCheck` | `checkUrlSafety` |
    | `domainSsrfCheck` | `checkUrlSsrf` |
    | `domainSsrfCheckBatch` | `checkUrlSsrfBatch` |
    | `domainUrlHtmlSsrfCheck` | `checkUrlHtmlSsrf` |
    | `emailPost` | `validateEmailSyntax` |
    | `emailAddressGetServers` | `checkEmailServers` |
    | `emailFullValidation` | `validateEmailFully` |
    | `ipaddressIpIntelligence` | `getIpIntelligence` |
    | `ipaddressPost` | `geolocateIp` |
    | `ipaddressGeolocateStreetAddress` | `geolocateIpToStreetAddress` |
    | `ipaddressIsThreat` | `checkIpThreat` |
    | `ipaddressIsTorNode` | `checkIpTorNode` |
    | `ipaddressIsBot` | `checkIpBot` |
    | `ipaddressReverseDomainLookup` | `reverseLookupIp` |
    | `leadEnrichmentEnrichLead` | `enrichLead` |
    | `nameValidateFullName` | `validateFullName` |
    | `nameValidateFirstName` | `validateFirstName` |
    | `nameValidateLastName` | `validateLastName` |
    | `nameGetGender` | `getGender` |
    | `nameIdentifier` | `validateIdentifier` |
    | `phoneNumberSyntaxOnly` | `validatePhoneNumber` |
    | `textInputCheckSqlInjection` | `checkSqlInjection` |
    | `textInputCheckSqlInjectionBatch` | `checkSqlInjectionBatch` |
    | `textInputCheckXss` | `checkXss` |
    | `textInputProtectXss` | `protectXss` |
    | `textInputCheckXssBatch` | `checkXssBatch` |
    | `textInputCheckHtmlSsrf` | `checkHtmlSsrf` |
    | `textInputCheckXxe` | `checkXxe` |
    | `textInputCheckXxeBatch` | `checkXxeBatch` |
    | `userAgentParse` | `parseUserAgent` |
    | `vatVatLookup` | `validateVat` |

- **Breaking:** the optional header settings of `checkSqlInjection` and `checkXxe` are no longer positional parameters. Pass them in the method's headers record:

    ```ballerina
    // 1.5.2
    validate:SqlInjectionDetectionResult r1 = check cl->textInputCheckSqlInjection(input, "High");
    validate:XxeDetectionResult r2 = check cl->textInputCheckXxe(xmlInput, true);
    ```

    ```ballerina
    // 2.0.0
    validate:SqlInjectionDetectionResult r1 = check cl->checkSqlInjection(input, {detectionLevel: "High"});
    validate:XxeDetectionResult r2 = check cl->checkXxe(xmlInput, {allowInternetUrls: true});
    ```

- **Breaking:** record fields use camel case, mapped to the API's Pascal-case JSON names with `@jsondata:Name`. For example, `ParseAddressResponse.Building` is now `building`, and `LeadEnrichmentResponse.CompanyName` is now `companyName`.
- **Breaking:** `PublicHolidayOccurrence.Nationwaide` is now `nationwide`, mapped to the API's `Nationwide` JSON field (1.5.2 read the misspelt `Nationwaide` field).
- **Breaking:** integer fields are `int:Signed32` (was `int`): `DateTimeStandardizedParseResponse` `year`, `month`, `day`, `hour`, `minute` and `second`, `GetPublicHolidaysRequest.year`, `LeadEnrichmentResponse.employeeCount`, `UrlHtmlSsrfResponseFull.httpResponseCode`, and `ValidateIdentifierRequest` `maxLength` and `minLength`.
- **Breaking:** fields that were nilable as well as optional are now only optional, for example `ValidateAddressResponse.latitude` is `decimal` (was `decimal?`). This covers:
  - `latitude` and `longitude` on `ValidateAddressResponse`, `ValidateCityResponse`, `ValidateStateResponse`, `ValidatePostalCodeResponse` and `NormalizeAddressResponse`.
  - `building` and `countryFullName` on `ParseAddressResponse` and `NormalizeAddressResponse`, and `ParseAddressResponse.iSOTwoLetterCode`.
  - `businessBuilding` and `businessCountry` on `VatLookupResponse`, and `UserAgentValidateResponse.botName`.

  With `laxDataBinding` (on by default) a `null` in the response is treated as an absent field.
- **Breaking:** the default `serviceUrl` is `https://api.cloudmersive.com/validate`, Cloudmersive's production endpoint (was the test endpoint `https://testapi.cloudmersive.com/`). A custom `serviceUrl` must now include the `/validate` path.
- **Breaking:** `ConnectionConfig.http1Settings` is now `http:ClientHttp1Settings` (was the connector's own `ClientHttp1Settings`).
- `ConnectionConfig.timeout` defaults to 30 seconds (was 60).

### Removed

- **Breaking:** the connector's own `ClientHttp1Settings` and `ProxyConfig` records. Use `http:ClientHttp1Settings` and `http:ProxyConfig` instead.
