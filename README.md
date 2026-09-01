# HelloID-Conn-SA-Full-AzureAD-Account-CreateTemporaryAccessPass

| :information_source: Information |
|:---------------------------|
| This repository contains the connector and configuration code only. The implementer is responsible for acquiring the connection details such as certificate, tenant ID, and application ID. You might need administrator consent and to configure an App Registration in Microsoft Entra ID before implementing this connector. Please contact the client's application owner to coordinate the requirements. |

## Description
HelloID-Conn-SA-Full-AzureAD-Account-CreateTemporaryAccessPass is a delegated form designed for use with HelloID Service Automation (SA). It can be imported into HelloID and customized according to your requirements.

By using this delegated form, you can create a Temporary Access Pass for Microsoft Entra ID (formerly Azure AD) user accounts. The following options are available:

1. Search for and select the target Microsoft Entra ID user account (wildcard search by display name, UserPrincipalName, or mail).
2. Configure the lifetime of the Temporary Access Pass in minutes (default: 60 minutes).
3. Specify whether the Temporary Access Pass is usable once (single-use) or multiple times (default: single-use).
4. Choose to create the Temporary Access Pass immediately (the TAP will be displayed in the form grid with all details).

## Getting started

### Requirements

#### App Registration & Certificate Setup
Before implementing this connector, make sure to configure a Microsoft Entra ID App Registration. During the setup process, you'll create a new App Registration in the Entra portal, assign the necessary API permissions (such as user and authentication method read/write), and generate and assign a certificate.

Follow the official Microsoft documentation for creating an App Registration and setting up certificate-based authentication:

* [App-only authentication with certificate](https://learn.microsoft.com/en-us/powershell/exchange/app-only-auth-powershell-v2?view=exchange-ps#set-up-app-only-authentication)

#### HelloID-specific configuration
Once you have completed the Microsoft setup and followed their best practices, configure the following HelloID-specific requirements.

* API Permissions (Application permissions):
  * `User.ReadWrite.All` - To read and write user information
  * `UserAuthenticationMethod.ReadWrite.All` - To read and write user authentication methods
* Certificate Base64 encoded string:
  * Base64 encoded string of the certificate assigned to the app registration. For instructions on creating the certificate and obtaining the base64 string, refer to our forum post: [Setting up a certificate for Microsoft Graph API in HelloID connectors](https://forum.helloid.com/forum/helloid-provisioning/5338-instruction-setting-up-a-certificate-for-microsoft-graph-api-in-helloid-connectors#post5338)

### Connection settings
The following global variables must be configured in HelloID when importing and configuring the delegated form.

| Variable name | Description | Required |
| ------------- | ----------- | -------- |
| EntraIdTenantId | The unique identifier (ID) of the tenant in Microsoft Entra ID | Yes |
| EntraIdAppId | The unique identifier (ID) of the App Registration in Microsoft Entra ID | Yes |
| EntraIdCertificateBase64String | The Base64-encoded string representation of the app certificate | Yes |
| EntraIdCertificatePassword | The password associated with the app certificate | Yes |

## Remarks

### User Search
* Search Functionality: Users can search for accounts using a wildcard (`*`) to return all users, or by entering partial text to search across user attributes (display name, User Principal Name, or mail address).

### Temporary Access Pass Configuration
* Lifetime: The lifetime of the Temporary Access Pass is configured in minutes through the form field "lifetime (minutes)". The default value is 60 minutes.
* Single-Use Option: The form includes a switch "Is Usable Once" to determine whether the TAP can be used once (single-use) or multiple times. The default value is single-use (true).
* Immediate Creation: When the "Create Temporary Access Pass Now" switch is enabled, the TAP is generated immediately via the datasource and displayed in a grid with the following details:
  * Temporary Access Pass (the actual password)
  * Is Usable (whether the TAP is currently usable)
  * Is Usable Once (single-use or multi-use)
  * Lifetime In Minutes (configured lifetime)
  * Method Usability Reason (reason for current usability status)
  * Start Date Time (when the TAP becomes valid)
  * Created Date Time (when the TAP was created)

### Certificate-Based Authentication
* JWT Token Generation: The connector uses certificate-based authentication to generate JSON Web Tokens (JWT) for secure communication with Microsoft Graph API. The certificate is converted from a base64 string and used to sign the JWT assertion for OAuth2 authentication.

### Error Handling
* Validation: The form validates user input including the required user selection and lifetime configuration before creating the Temporary Access Pass.
* Comprehensive Error Messages: The connector uses the `Resolve-MicrosoftGraphAPIError` function to provide detailed error information including script line numbers and friendly error messages.
* TAP Creation: Each form submission creates a new Temporary Access Pass. The TAP is created via a datasource and displayed in the form grid for the administrator to copy and securely provide to the user.

## Development resources

### API endpoints
The following Microsoft Graph API endpoints are used by the connector:

| Endpoint | Description |
| -------- | ----------- |
| /v1.0/users | List users |
| /v1.0/users/{id}/authentication/temporaryAccessPassMethods | Create Temporary Access Pass |

### API documentation
* [List users](https://learn.microsoft.com/en-us/graph/api/user-list)
* [Create temporaryAccessPassAuthenticationMethod](https://learn.microsoft.com/en-us/graph/api/authentication-post-temporaryaccesspassmethods)
* [temporaryAccessPassAuthenticationMethod resource type](https://learn.microsoft.com/en-us/graph/api/resources/temporaryaccesspassauthenticationmethod)

## Getting help

| :bulb: Tip |
|:---------------------------|
| For more information on Delegated Forms, please refer to our [documentation](https://docs.helloid.com/en/service-automation/delegated-forms.html) pages. |

## HelloID docs
The official HelloID documentation can be found at: [https://docs.helloid.com/](https://docs.helloid.com/)
