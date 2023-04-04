## unreleased

## 2.10.0 - 2023-04-04

Identical to 2.10.0.beta2

## 2.10.0.beta2 - 2023-03-08

- fix: incorrect usage keyword parameter (fix for 2.10.0.beta1)

## 2.10.0.beta1 - 2023-03-08

- fix: Change signed-out & interstitial request state conditions [https://github.com/clerkinc/clerk-sdk-ruby/pull/30]

## 2.9.0

Identical to 2.9.0.beta3

## 2.9.0.beta3 - 2023-01-17

## Changed

- internal: Change request payloads to `application/json` content type [https://github.com/clerkinc/clerk-sdk-ruby/pull/29]

## 2.9.0.beta2 - 2023-01-05

- feat: Support setting the secret key (previously called Backend API key) using
  the `CLERK_SECRET_KEY` environment variable [https://github.com/clerkinc/clerk-sdk-ruby/pull/28]

## 2.9.0.beta1 - 2022-12-23

- fix: Make JWKS cache work across different SDK instances [https://github.com/clerkinc/clerk-sdk-ruby/pull/27]

## 2.8.0 - 2022-11-29

- feat: Add support for the users.verify_totp endpoint

## 2.7.0 - 2022-11-02

- feat: Add `#clerk_organization` and `#clerk_organization_id` helpers to fetch the current user's active organization [https://github.com/clerkinc/clerk-sdk-ruby/pull/22]
- feat: Implement Organization Metadata update endpoint [https://github.com/clerkinc/clerk-sdk-ruby/pull/21]

## 2.6.0 - 2022-11-01

- feat: Implement Organization endpoints [https://github.com/clerkinc/clerk-sdk-ruby/pull/20]

## 2.5.0 - 2022-09-20

- feat: Add support for disabling the middleware on specific routes [https://github.com/clerkinc/clerk-sdk-ruby/pull/19]

## 2.4.0 - 2022-09-05

- feat: Add support for the users.disable_mfa endpoint

## 2.3.0 - 2022-08-30

- feat: Add support for the users.verify_password endpoint

## 2.2.0 - 2022-08-26

- feat: Add support for the [users.create](https://clerk.com/docs/reference/backend-api/tag/Users#operation/CreateUser) endpoint

## 2.1.2 - 2022-08-26

- fix: Gracefully handle invalid JSON in Authorization header [https://github.com/clerkinc/clerk-sdk-ruby/pull/16]

## 2.1.1 - 2022-02-24

- fix: Make Authv2 middleware thread-safe

## 2.0.0 - 2021-10-21

This release introduces the new networkless middleware which works with the new 
authentication scheme, [Auth v2](https://clerk.com/docs/upgrade-guides/auth-v2).

It is backwards-incompatible with applications using Auth v1.

- [BREAKING]: In order to use this version, you must set the authVersion prop 
    accordingly in your frontend: `Clerk.load({authVersion: 2})`

For more information on Auth v2, please refer to
https://clerk.com/docs/upgrade-guides/auth-v2.

## 1.0.3 - 2021-07-21

- fix: Proper endpoint for oauth_access_token method

## 1.0.2 - 2021-06-03

- fix: Instantiation of `Clerk::SDK` without prior call to `Clerk.configure`

## 1.0.1 - 2021-06-03

### enhancements

- Middleware now uses a proxy object which lazy loads the Clerk session and user only when needed

## 1.0.0 - 2021-05-27

- initial release
