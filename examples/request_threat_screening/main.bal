// Screens an incoming web request by checking the client IP address, a referring URL and a submitted text field.

import ballerina/io;
import ballerinax/cloudmersive.validate;

configurable string apiKey = ?;
configurable string clientIp = ?;
configurable string referrerUrl = ?;
configurable string submittedText = ?;

public function main() returns error? {
    validate:Client validateClient = check new ({apikey: apiKey});

    // Step 1: Check whether the client IP address is a known threat. The API expects a JSON string, so values are quoted.
    validate:IPThreatResponse ipResult = check validateClient->checkIpThreat(string `"${clientIp}"`);
    boolean ipThreat = ipResult?.isThreat ?: false;
    io:println("IP threat: ", ipThreat);

    // Step 2: Geolocate the IP address to log where the request came from.
    validate:GeolocateResponse location = check validateClient->geolocateIp(string `"${clientIp}"`);
    io:println("Request origin: ", location?.city, ", ", location?.countryName);

    // Step 3: Check the referring URL for phishing threats.
    validate:PhishingCheckResponse phishingResult = check validateClient->checkUrlPhishing({uRL: referrerUrl});
    boolean cleanUrl = phishingResult?.cleanURL ?: false;
    io:println("Referrer URL clean: ", cleanUrl);

    // Step 4: Check the submitted text for SQL injection.
    validate:SqlInjectionDetectionResult sqlResult = check validateClient->checkSqlInjection(string `"${submittedText}"`);
    boolean sqlInjection = sqlResult?.containedSqlInjectionAttack ?: false;
    io:println("SQL injection detected: ", sqlInjection);

    if ipThreat || !cleanUrl || sqlInjection {
        io:println("Request blocked.");
    } else {
        io:println("Request allowed.");
    }
}
