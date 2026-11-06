
// Copyright (c) 2026, WSO2 LLC. (http://www.wso2.com).
//
// WSO2 LLC. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.


import ballerina/http;

listener http:Listener ep0 = new (9090);

@http:ServiceConfig {treatNilableAsOptional: true}
service / on ep0 {

    # Get current date and time as of now
    #
    # + return - Current date and time
    resource function get date\-time/get/now() returns DateTimeNowResult {
        return {nowGmt: "2026-10-09T05:30:00Z", now: "2026-10-09T11:00:00+05:30", successful: true};
    }

    # Get the currency of the input country
    #
    # + payload - Country to look up
    # + return - Country currency details
    resource function post address/country/get\-currency(@http:Payload ValidateCountryRequest payload) returns ValidateCountryResponse {
        return {
            countryFullName: "United States of America",
            iSOTwoLetterCode: "US",
            threeLetterCode: "USA",
            iSOCurrencyCode: "USD",
            currencyEnglishName: "United States dollar",
            currencySymbol: "$",
            region: "Americas",
            subregion: "Northern America",
            isEuropeanUnionMember: false,
            successful: true
        };
    }

    # Get a list of ISO 3166-1 countries
    #
    # + return - List of countries
    resource function post address/country/list() returns CountryListResult {
        return {
            countries: [
                {countryName: "United States of America", iSOTwoLetterCode: "US", threeLetterCode: "USA", iSOCurrencyCode: "USD", currencySymbol: "$", region: "Americas", isEuropeanUnionMember: false},
                {countryName: "Germany", iSOTwoLetterCode: "DE", threeLetterCode: "DEU", iSOCurrencyCode: "EUR", currencySymbol: "€", region: "Europe", isEuropeanUnionMember: true}
            ],
            successful: true
        };
    }

    # Geocode a street address into latitude and longitude
    #
    # + payload - Address to geocode
    # + return - Geocoded address
    resource function post address/geocode(@http:Payload ValidateAddressRequest payload) returns ValidateAddressResponse {
        return {validAddress: true, latitude: 37.4220, longitude: -122.0841};
    }

    # Parse an unstructured input text string into a formatted address
    #
    # + payload - Address text to parse
    # + return - Parsed address
    resource function post address/parse(@http:Payload ParseAddressRequest payload) returns ParseAddressResponse {
        return {
            streetNumber: "1600",
            street: "Amphitheatre Parkway",
            city: "Mountain View",
            stateOrProvince: "CA",
            postalCode: "94043",
            countryFullName: "United States of America",
            iSOTwoLetterCode: "US",
            successful: true
        };
    }

    # Validate a street address
    #
    # + payload - Address to validate
    # + return - Validation result
    resource function post address/street\-address(@http:Payload ValidateAddressRequest payload) returns ValidateAddressResponse {
        return {validAddress: true, latitude: 37.4220, longitude: -122.0841};
    }

    # Normalize a street address
    #
    # + payload - Address to normalize
    # + return - Normalized address
    resource function post address/street\-address/normalize(@http:Payload ValidateAddressRequest payload) returns NormalizeAddressResponse {
        return {
            validAddress: true,
            streetNumber: "1600",
            street: "Amphitheatre Pkwy",
            city: "Mountain View",
            stateOrProvince: "CA",
            postalCode: "94043",
            countryFullName: "United States of America",
            iSOTwoLetterCode: "US",
            latitude: 37.4220,
            longitude: -122.0841
        };
    }

    # Get public holidays in the specified country and year
    #
    # + payload - Country and year
    # + return - Public holidays
    resource function post date\-time/get/holidays(@http:Payload GetPublicHolidaysRequest payload) returns PublicHolidaysResponse {
        return {
            publicHolidays: [
                {englishName: "New Year's Day", localName: "New Year's Day", occurrenceDate: "2026-01-01", holidayType: "Public", nationwide: true},
                {englishName: "Independence Day", localName: "Independence Day", occurrenceDate: "2026-07-04", holidayType: "Public", nationwide: true}
            ],
            successful: true
        };
    }

    # Validate a domain name
    #
    # + payload - Domain name to check
    # + return - Domain validity
    resource function post domain/'check(@http:Payload string payload) returns CheckResponse {
        return {validDomain: true};
    }

    # Validate a URL fully
    #
    # + payload - URL to validate
    # + return - URL validation result
    resource function post domain/url/full(@http:Payload ValidateUrlRequestFull payload) returns ValidateUrlResponseFull {
        return {validURL: true, validSyntax: true, validDomain: true, validEndpoint: true, wellFormedURL: "https://www.cloudmersive.com/"};
    }

    # Check a URL for phishing threats
    #
    # + payload - URL to check
    # + return - Phishing check result
    resource function post domain/url/phishing\-threat\-check(@http:Payload PhishingCheckRequest payload) returns PhishingCheckResponse {
        return {cleanURL: true, threatType: "None"};
    }

    # Get WHOIS information for a domain
    #
    # + payload - Domain name
    # + return - WHOIS record
    resource function post domain/whois(@http:Payload string payload) returns WhoisResponse {
        return {
            validDomain: true,
            whoisServer: "whois.markmonitor.com",
            createdDt: "1997-09-15T00:00:00Z",
            registrantName: "Domain Administrator",
            registrantOrganization: "Example Corp",
            registrantCity: "Mountain View",
            registrantCountry: "US",
            registrantEmail: "admin@example.com",
            rawTextRecord: "Domain Name: EXAMPLE.COM"
        };
    }

    # Fully validate an email address
    #
    # + payload - Email address
    # + return - Full validation result
    resource function post email/address/full(@http:Payload string payload) returns FullEmailValidationResponse {
        return {
            validAddress: true,
            validSyntax: true,
            validDomain: true,
            validSMTP: true,
            isCatchallDomain: false,
            isFreeEmailProvider: false,
            isDisposable: false,
            domain: "cloudmersive.com",
            mailServerUsedForValidation: "mx1.cloudmersive.com"
        };
    }

    # Validate email address for syntactic correctness
    #
    # + payload - Email address
    # + return - Syntax validation result
    resource function post email/address/syntaxOnly(@http:Payload string payload) returns AddressVerifySyntaxOnlyResponse {
        return {validAddress: true, isFreeEmailProvider: false, isDisposable: false, domain: "cloudmersive.com"};
    }

    # Geolocate an IP address
    #
    # + payload - IP address
    # + return - Location of the IP address
    resource function post ip/geolocate(@http:Payload string payload) returns GeolocateResponse {
        return {
            countryCode: "US",
            countryName: "United States",
            regionCode: "CA",
            regionName: "California",
            city: "Mountain View",
            zipCode: "94043",
            latitude: 37.386,
            longitude: -122.0838,
            timezoneStandardName: "America/Los_Angeles"
        };
    }

    # Get intelligence on an IP address
    #
    # + payload - IP address
    # + return - IP intelligence
    resource function post ip/intelligence(@http:Payload string payload) returns IPIntelligenceResponse {
        return {
            isThreat: false,
            isTorNode: false,
            isBot: false,
            isEU: false,
            currencyCode: "USD",
            currencyName: "United States dollar",
            regionArea: "Americas",
            subregionArea: "Northern America",
            location: {countryCode: "US", countryName: "United States", city: "Mountain View"}
        };
    }

    # Check if an IP address is a known threat
    #
    # + payload - IP address
    # + return - Threat check result
    resource function post ip/is\-threat(@http:Payload string payload) returns IPThreatResponse {
        return {isThreat: false, threatType: "None"};
    }

    # Enrich an input lead with additional fields of data
    #
    # + payload - Lead to enrich
    # + return - Enriched lead
    resource function post lead\-enrichment/lead/enrich(@http:Payload LeadEnrichmentRequest payload) returns LeadEnrichmentResponse {
        return {
            successful: true,
            contactFirstName: "Jane",
            contactLastName: "Doe",
            contactGender: "Female",
            contactBusinessEmail: "jane.doe@example.com",
            companyName: "Example Corp",
            companyDomainName: "example.com",
            companyCity: "Mountain View",
            companyCountry: "United States",
            companyCountryCode: "US",
            employeeCount: 250,
            leadType: "Business"
        };
    }

    # Parse and validate a full name
    #
    # + payload - Full name to validate
    # + return - Parsed name
    resource function post name/full\-name(@http:Payload FullNameValidationRequest payload) returns FullNameValidationResponse {
        return {
            successful: true,
            title: "Ms.",
            firstName: "Jane",
            middleName: "A.",
            lastName: "Doe",
            displayName: "Jane A. Doe",
            validationResultFirstName: "ValidFirstName",
            validationResultLastName: "ValidLastName"
        };
    }

    # Get the gender of a first name
    #
    # + payload - First name
    # + return - Gender
    resource function post name/get\-gender(@http:Payload GetGenderRequest payload) returns GetGenderResponse {
        return {gender: "Female", successful: true};
    }

    # Validate phone number (basic)
    #
    # + payload - Phone number and country
    # + return - Phone number validation result
    resource function post phonenumber/basic(@http:Payload PhoneNumberValidateRequest payload) returns PhoneNumberValidationResponse {
        return {
            isValid: true,
            successful: true,
            phoneNumberType: "Mobile",
            e164Format: "+14155552671",
            internationalFormat: "+1 415-555-2671",
            nationalFormat: "(415) 555-2671",
            countryName: "United States",
            countryCode: "US"
        };
    }

    # Check text input for SQL Injection attacks
    #
    # + detectionLevel - Detection level: Normal or High
    # + payload - Text input
    # + return - SQL injection detection result
    resource function post text\-input/'check/sql\-injection(@http:Header string? detectionLevel, @http:Payload string payload) returns SqlInjectionDetectionResult {
        return {successful: true, containedSqlInjectionAttack: false, originalInput: payload};
    }

    # Check text input for Cross-Site-Scripting attacks
    #
    # + payload - Text input
    # + return - XSS detection result
    resource function post text\-input/'check/xss(@http:Payload string payload) returns XssProtectionResult {
        return {successful: true, containedXss: false, originalInput: payload, normalizedResult: payload};
    }

    # Parse an HTTP User-Agent string
    #
    # + payload - User-Agent string
    # + return - Parsed user agent
    resource function post useragent/parse(@http:Payload UserAgentValidateRequest payload) returns UserAgentValidateResponse {
        return {
            successful: true,
            browserName: "Chrome",
            browserVersion: "118.0",
            browserEngineName: "Blink",
            operatingSystem: "Windows",
            operatingSystemVersion: "10",
            deviceType: "Desktop",
            isBot: false
        };
    }

    # Validate a VAT number
    #
    # + payload - VAT number to look up
    # + return - VAT lookup result
    resource function post vat/lookup(@http:Payload VatLookupRequest payload) returns VatLookupResponse {
        return {
            isValid: true,
            countryCode: "DE",
            vatNumber: "DE123456789",
            businessName: "Example GmbH",
            businessCity: "Berlin",
            businessCountry: "Germany"
        };
    }
}
