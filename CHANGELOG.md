# Change Log

All notable changes to this project will be documented in this file.
The format is based on [Keep a Changelog](https://keepachangelog.com/), and this project adheres to [Semantic Versioning](https://semver.org/).

## [2.0.0] - 2026-08-11

This is a major release that migrates from Azure AD to Microsoft Entra ID terminology and replaces client secret authentication with certificate-based authentication. This release includes breaking changes that require reconfiguration of global variables and App Registration settings.

### Added

- Added GitHub Actions workflow for automated release creation (`Create Release` workflow)
- Added GitHub Actions workflow to verify CHANGELOG.md updates on pull requests (`Verify CHANGELOG Updated` workflow)
- Added data source for wildcard user search (`EntraID-Get-Users-Wildcard-DisplayName-UPN-Mail`)
  - Supports searching by display name, user principal name, and mail address
  - Includes additional user properties in grid: description, account enabled status, job title, department, and company name
- Added data source for creating Temporary Access Pass (`Entra ID - Temporary Access Pass - Create`)
  - Configurable lifetime in minutes (default: 60 minutes)
  - Single-use or multi-use option via "Is Usable Once" switch
  - Immediate TAP creation via datasource with detailed result display in grid
- Added certificate-based authentication functions (`Get-MSEntraCertificate` and `Get-MSEntraAccessToken`)
  - Implements JWT token generation with X.509 certificate signing
  - Uses SHA-256 certificate thumbprint (`x5t#S256`) for enhanced security
- Added comprehensive error handling with `Resolve-MicrosoftGraphAPIError` function
- Added audit logging for Temporary Access Pass creation operations
- Added CSV download functionality in the form for user search results
- Added filtering capabilities in the dynamic form for improved user experience

### Changed

- **BREAKING:** Migrated from Azure AD terminology to Microsoft Entra ID terminology throughout all scripts, documentation, and configuration files
- **BREAKING:** Updated global variable names to use Entra ID naming convention:
  - Old: `AADTenantId` → New: `EntraIdTenantId`
  - Old: `AADAppId` → New: `EntraIdAppId`
  - Old: `AADAppSecret` → New: `EntraIdCertificateBase64String` and `EntraIdCertificatePassword`
- **BREAKING:** Replaced client secret authentication with certificate-based authentication for Microsoft Graph API access
  - Now uses JWT (JSON Web Tokens) generated from X.509 certificates
  - Requires certificate to be uploaded to Entra ID App Registration
- **BREAKING:** Refactored data source names from Azure AD to Entra ID naming:
  - Old: `Azure-AD-temp-access-pass-generate-user-table-wildcard` → New: `EntraID-Get-Users-Wildcard-DisplayName-UPN-Mail`
  - Old: `Azure-AD-temp-access-pass-create-access-pass` → New: `Entra ID - Temporary Access Pass - Create`
- Updated task name from "Azure AD - Temporary Access Pass" to "Entra ID - Temporary Access Pass - Create"
- Updated API permissions to minimal required set:
  - `User.ReadWrite.All` - To read and write user information
  - `UserAuthenticationMethod.ReadWrite.All` - To read and write user authentication methods
- Enhanced delegated form with improved user experience and field layout
  - Added CSV download functionality for user search results
  - Added filtering capabilities in user search grid
  - Improved field labels and placeholders
  - Added comprehensive user information columns (description, account enabled, job title, department, company name)
  - Added TAP result grid showing all Temporary Access Pass details (TAP value, usability status, lifetime, start/created dates)
- Improved error handling with graceful error messages and audit logging
- Updated Temporary Access Pass creation to use Microsoft Graph API v1.0:
  - Create TAP: `POST /v1.0/users/{id}/authentication/temporaryAccessPassMethods`
- Updated README.md with comprehensive documentation including:
  - Certificate-based authentication setup instructions
  - API permissions requirements
  - Connection settings
  - Remarks on user search, TAP configuration, and error handling
  - Development resources with API endpoints and documentation links
- Improved code formatting and consistency across all PowerShell scripts
- Disabled cloud execution in task configuration

### Deprecated

- Deprecated support for Azure AD naming convention in global variables (use Entra ID naming convention instead)
- Deprecated client secret authentication method (use certificate-based authentication instead)

### Removed

- Removed support for client secret-based authentication in favor of certificate-based authentication
- Removed Azure AD terminology from all scripts and documentation
- Removed obsolete input and model JSON files for Azure AD Temporary Access Pass generation
- Removed excessive API permissions that were not required for Temporary Access Pass creation

### Fixed

- Fixed error handling to provide more detailed error messages with line numbers and friendly messages
- Fixed user search functionality to properly search across display name, User Principal Name, and mail address
- Fixed form validation to ensure proper user selection before Temporary Access Pass creation

## [1.0.0] - 2024-03-11

### Added

- Initial release of HelloID-Conn-SA-Full-AzureAD-Account-CreateTemporaryAccessPass
- Basic Azure AD Temporary Access Pass creation functionality
- Form-based user selection with wildcard search across displayName and userPrincipalName
- Lifetime configuration for Temporary Access Pass in minutes
- Single-use or multi-use option for Temporary Access Pass
- Immediate Temporary Access Pass generation and display in form grid
- Client secret-based authentication for Microsoft Graph API
- Data source for searching Azure AD users (`Azure-AD-temp-access-pass-generate-user-table-wildcard`)
- Data source for creating Temporary Access Pass (`Azure-AD-temp-access-pass-create-access-pass`)
- All-in-one setup script for HelloID form deployment
- Basic error handling and audit logging

### Changed

### Deprecated

### Removed

### Fixed
