# Ballerina Cloudmersive Validate connector

[![Build](https://github.com/ballerina-platform/module-ballerinax-cloudmersive.validate/actions/workflows/ci.yml/badge.svg)](https://github.com/ballerina-platform/module-ballerinax-cloudmersive.validate/actions/workflows/ci.yml)
[![GitHub Last Commit](https://img.shields.io/github/last-commit/ballerina-platform/module-ballerinax-cloudmersive.validate.svg)](https://github.com/ballerina-platform/module-ballerinax-cloudmersive.validate/commits/main)
[![GitHub Issues](https://img.shields.io/github/issues/ballerina-platform/ballerina-library/module/cloudmersive.validate.svg?label=Open%20Issues)](https://github.com/ballerina-platform/ballerina-library/labels/module%2Fcloudmersive.validate)

## Overview

The Cloudmersive Validate connector provides programmatic access to the [Cloudmersive Validation API](https://api.cloudmersive.com/docs/validate.asp), which helps you validate and enrich data such as email addresses, domains, URLs, phone numbers, postal addresses, names, VAT numbers and IP addresses. This connector supports version 1 of the API and lets Ballerina applications call every validation operation through remote methods.

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

- [signup_data_validation](examples/signup_data_validation/signup_data_validation.md) - Validate the email address, full name and phone number from a sign-up form.
- [request_threat_screening](examples/request_threat_screening/request_threat_screening.md) - Screen a web request by checking the client IP, referring URL and submitted text for threats.

## Build from the source

### Setting up the prerequisites

1. Download and install Java SE Development Kit (JDK) version 21. You can download it from either of the following sources:

    * [Oracle JDK](https://www.oracle.com/java/technologies/downloads/)
    * [OpenJDK](https://adoptium.net/)

   > **Note:** After installation, remember to set the `JAVA_HOME` environment variable to the directory where JDK was installed.

2. Download and install [Ballerina Swan Lake](https://ballerina.io/).

3. Download and install [Docker](https://www.docker.com/get-started).

   > **Note**: Ensure that the Docker daemon is running before executing any tests.

4. Export Github Personal access token with read package permissions as follows,

    ```bash
    export packageUser=<Username>
    export packagePAT=<Personal access token>
    ```

### Build options

Execute the commands below to build from the source.

1. To build the package:

   ```bash
   ./gradlew clean build
   ```

2. To run the tests:

   ```bash
   ./gradlew clean test
   ```

3. To build the without the tests:

   ```bash
   ./gradlew clean build -x test
   ```

4. To run tests against different environments:

   ```bash
   ./gradlew clean test -Pgroups=<Comma separated groups/test cases>
   ```

5. To debug the package with a remote debugger:

   ```bash
   ./gradlew clean build -Pdebug=<port>
   ```

6. To debug with the Ballerina language:

   ```bash
   ./gradlew clean build -PbalJavaDebug=<port>
   ```

7. Publish the generated artifacts to the local Ballerina Central repository:

    ```bash
    ./gradlew clean build -PpublishToLocalCentral=true
    ```

8. Publish the generated artifacts to the Ballerina Central repository:

   ```bash
   ./gradlew clean build -PpublishToCentral=true
   ```

## Contribute to Ballerina

As an open-source project, Ballerina welcomes contributions from the community.

For more information, go to the [contribution guidelines](https://github.com/ballerina-platform/ballerina-lang/blob/master/CONTRIBUTING.md).

## Code of conduct

All the contributors are encouraged to read the [Ballerina Code of Conduct](https://ballerina.io/code-of-conduct).

## Useful links

* For more information go to the [`cloudmersive.validate` package](https://central.ballerina.io/ballerinax/cloudmersive.validate/latest).
* For example demonstrations of the usage, go to [Ballerina By Examples](https://ballerina.io/learn/by-example/).
* Chat live with us via our [Discord server](https://discord.gg/ballerinalang).
* Post all technical questions on Stack Overflow with the [#ballerina](https://stackoverflow.com/questions/tagged/ballerina) tag.
