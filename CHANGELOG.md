## unreleased

## 2.0.0 - 2021-10-21

This release introduces the new networkless middleware which works with the new 
authentication scheme, [Auth v2](https://docs.clerk.dev/main-concepts/auth-v2).

It is backwards-incompatible with applications using Auth v1.

- [BREAKING]: In order to use this version, you must set the authVersion prop 
    accordingly in your frontend: `Clerk.load({authVersion: 2})`

For more information on Auth v2, please refer to 
https://docs.clerk.dev/main-concepts/auth-v2.

## 1.0.3 - 2021-07-21

- fix: Proper endpoint for oauth_access_token method

## 1.0.2 - 2021-06-03

- fix: Instantiation of `Clerk::SDK` without prior call to `Clerk.configure`

## 1.0.1 - 2021-06-03

### enhancements

- Middleware now uses a proxy object which lazy loads the Clerk session and user only when needed

## 1.0.0 - 2021-05-27

- initial release
