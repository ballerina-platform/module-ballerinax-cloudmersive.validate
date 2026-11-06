
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


import ballerina/os;
import ballerina/test;

final boolean isLiveServer = os:getEnv("IS_LIVE_SERVER") == "true";
final string serviceUrl = isLiveServer ? "https://api.cloudmersive.com/validate" : "http://localhost:9090";
final string apiKey = isLiveServer ? os:getEnv("CLOUDMERSIVE_API_KEY") : "test_api_key";

final Client cloudmersive = check new ({apikey: apiKey}, {httpVersion: "1.1"}, serviceUrl);

@test:Config {groups: ["live_tests", "mock_tests"]}
isolated function testGetCurrentDateTime() returns error? {
    DateTimeNowResult response = check cloudmersive->getCurrentDateTime();
    test:assertTrue(response?.successful is boolean);
    test:assertTrue(response?.now is string);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
isolated function testGetCountryCurrency() returns error? {
    ValidateCountryResponse response = check cloudmersive->getCountryCurrency({rawCountryInput: "USA"});
    test:assertEquals(response?.iSOCurrencyCode, "USD");
}

@test:Config {groups: ["live_tests", "mock_tests"]}
isolated function testListCountries() returns error? {
    CountryListResult response = check cloudmersive->listCountries();
    CountryDetails[]? countries = response?.countries;
    test:assertTrue(countries is CountryDetails[] && countries.length() > 0);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
isolated function testGeocodeAddress() returns error? {
    ValidateAddressResponse response = check cloudmersive->geocodeAddress({streetAddress: "1600 Amphitheatre Parkway", stateOrProvince: "CA"});
    test:assertTrue(response?.latitude is decimal);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
isolated function testParseAddress() returns error? {
    ParseAddressResponse response = check cloudmersive->parseAddress({addressString: "1600 Amphitheatre Parkway, Mountain View, CA 94043"});
    test:assertTrue(response?.city is string);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
isolated function testValidateAddress() returns error? {
    ValidateAddressResponse response = check cloudmersive->validateAddress({streetAddress: "1600 Amphitheatre Parkway", stateOrProvince: "CA"});
    test:assertTrue(response?.validAddress is boolean);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
isolated function testNormalizeAddress() returns error? {
    NormalizeAddressResponse response = check cloudmersive->normalizeAddress({streetAddress: "1600 Amphitheatre Parkway", stateOrProvince: "CA"});
    test:assertTrue(response?.street is string);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
isolated function testGetPublicHolidays() returns error? {
    PublicHolidaysResponse response = check cloudmersive->getPublicHolidays({rawCountryInput: "US", year: 2026});
    PublicHolidayOccurrence[]? holidays = response?.publicHolidays;
    test:assertTrue(holidays is PublicHolidayOccurrence[] && holidays.length() > 0);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
isolated function testValidateDomain() returns error? {
    CheckResponse response = check cloudmersive->validateDomain("\"cloudmersive.com\"");
    test:assertTrue(response?.validDomain is boolean);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
isolated function testValidateUrl() returns error? {
    ValidateUrlResponseFull response = check cloudmersive->validateUrl({uRL: "https://www.cloudmersive.com"});
    test:assertTrue(response?.validURL is boolean);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
isolated function testCheckUrlPhishing() returns error? {
    PhishingCheckResponse response = check cloudmersive->checkUrlPhishing({uRL: "https://www.cloudmersive.com"});
    test:assertTrue(response?.cleanURL is boolean);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
isolated function testGetDomainWhois() returns error? {
    WhoisResponse response = check cloudmersive->getDomainWhois("\"cloudmersive.com\"");
    test:assertTrue(response?.validDomain is boolean);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
isolated function testValidateEmailFully() returns error? {
    FullEmailValidationResponse response = check cloudmersive->validateEmailFully("\"support@cloudmersive.com\"");
    test:assertTrue(response?.validAddress is boolean);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
isolated function testValidateEmailSyntax() returns error? {
    AddressVerifySyntaxOnlyResponse response = check cloudmersive->validateEmailSyntax("\"support@cloudmersive.com\"");
    test:assertTrue(response?.validAddress is boolean);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
isolated function testGetIpIntelligence() returns error? {
    IPIntelligenceResponse response = check cloudmersive->getIpIntelligence("\"8.8.8.8\"");
    test:assertTrue(response?.isThreat is boolean);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
isolated function testGeolocateIp() returns error? {
    GeolocateResponse response = check cloudmersive->geolocateIp("\"8.8.8.8\"");
    test:assertTrue(response?.countryCode is string);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
isolated function testCheckIpThreat() returns error? {
    IPThreatResponse response = check cloudmersive->checkIpThreat("\"8.8.8.8\"");
    test:assertTrue(response?.isThreat is boolean);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
isolated function testEnrichLead() returns error? {
    LeadEnrichmentResponse response = check cloudmersive->enrichLead({contactBusinessEmail: "jane.doe@example.com"});
    test:assertTrue(response?.successful is boolean);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
isolated function testValidateFullName() returns error? {
    FullNameValidationResponse response = check cloudmersive->validateFullName({fullNameString: "Ms. Jane A. Doe"});
    test:assertTrue(response?.lastName is string);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
isolated function testGetGender() returns error? {
    GetGenderResponse response = check cloudmersive->getGender({firstName: "Jane"});
    test:assertTrue(response?.gender is string);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
isolated function testValidatePhoneNumber() returns error? {
    PhoneNumberValidationResponse response = check cloudmersive->validatePhoneNumber({phoneNumber: "415-555-2671", defaultCountryCode: "US"});
    test:assertTrue(response?.isValid is boolean);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
isolated function testCheckSqlInjection() returns error? {
    SqlInjectionDetectionResult response = check cloudmersive->checkSqlInjection("\"SELECT * FROM users\"");
    test:assertTrue(response?.containedSqlInjectionAttack is boolean);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
isolated function testCheckXss() returns error? {
    XssProtectionResult response = check cloudmersive->checkXss("\"<script>alert(1)</script>\"");
    test:assertTrue(response?.containedXss is boolean);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
isolated function testParseUserAgent() returns error? {
    UserAgentValidateResponse response = check cloudmersive->parseUserAgent({userAgentString: "Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/118.0"});
    test:assertTrue(response?.browserName is string);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
isolated function testValidateVat() returns error? {
    VatLookupResponse response = check cloudmersive->validateVat({vatCode: "DE123456789"});
    test:assertTrue(response?.isValid is boolean);
}
