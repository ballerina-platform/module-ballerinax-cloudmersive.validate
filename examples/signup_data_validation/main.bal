// Validates the contact details submitted in a sign-up form: email address, full name and phone number.

import ballerina/io;
import ballerinax/cloudmersive.validate;

configurable string apiKey = ?;
configurable string email = ?;
configurable string fullName = ?;
configurable string phoneNumber = ?;
configurable string defaultCountryCode = "US";

public function main() returns error? {
    validate:Client validateClient = check new ({apikey: apiKey});

    // Step 1: Fully validate the email address. The API expects a JSON string, so the value is quoted.
    validate:FullEmailValidationResponse emailResult = check validateClient->validateEmailFully(string `"${email}"`);
    boolean emailValid = emailResult?.validAddress ?: false;
    io:println("Email valid: ", emailValid);
    if emailResult?.isDisposable ?: false {
        io:println("Warning: the email address belongs to a disposable email provider.");
    }

    // Step 2: Parse and validate the full name.
    validate:FullNameValidationResponse nameResult = check validateClient->validateFullName({fullNameString: fullName});
    io:println("Display name: ", nameResult?.displayName);
    io:println("First name check: ", nameResult?.validationResultFirstName);
    io:println("Last name check: ", nameResult?.validationResultLastName);

    // Step 3: Validate the phone number.
    validate:PhoneNumberValidationResponse phoneResult = check validateClient->validatePhoneNumber({
        phoneNumber,
        defaultCountryCode
    });
    boolean phoneValid = phoneResult?.isValid ?: false;
    io:println("Phone valid: ", phoneValid);
    if phoneValid {
        io:println("International format: ", phoneResult?.internationalFormat);
    }

    if emailValid && phoneValid {
        io:println("Sign-up details accepted.");
    } else {
        io:println("Sign-up details rejected: please correct the email address or phone number.");
    }
}
