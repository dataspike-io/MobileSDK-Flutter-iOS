# MobileSDK-Flutter-iOS

## Example Project with Integrated API

This repository contains an example iOS project demonstrating how to integrate
**DataspikeMobile SDK** using a Flutter module and how to work with the Dataspike API.

The example covers:
- Embedding a Flutter module into a native iOS application
- Initializing the Dataspike verification flow
- Passing API credentials (`dsApiToken`, `shortId`)
- Handling verification completion via `onVerificationCompleted` callback

The project can be used as a reference implementation for integrating
DataspikeMobile SDK into an existing iOS application.

## Documentation & API References

To understand how the Flutter module is integrated and which setup steps are required,
please refer to the official Flutter SDK repository:

- Flutter SDK & integration guide:  
  https://github.com/dataspike-io/MobileSDK-Flutter

This example project already contains an implementation of the required Dataspike API calls.
You do **not** need to implement the full API flow from scratch for this sample.

### Dataspike API
If you need to customize or extend the backend integration, the full API reference is available here:
- API overview:  
  https://docs.dataspike.io/api-reference/overview

To obtain a valid `shortId`, you must create a new verification using the following endpoint:
- Create new verification:  
  https://docs.dataspike.io/api-reference/verifications/create-new-verification

The resulting `shortId` should then be passed to the SDK **exactly as demonstrated in this test application**.
All required requests for the basic verification flow are already implemented inside the app.

## Verification Flow

Inside the application, you open the verification screen according to the SDK documentation
and start the KYC flow.

The verification steps and flow configuration are managed from the Dataspike Dashboard:
- Dashboard:  
  https://dash.dataspike.io/dashboard/

Once the user completes the KYC flow (based on the steps configured in the dashboard),
the SDK triggers the `onVerificationCompleted` callback.

You should handle this callback to determine the next screen in your application
(e.g. success, retry, or failure state after verification).

> ⚠️ Note: An explicit exit / cancellation from the verification flow is not available yet.
> This will be added in one of the upcoming SDK versions.
