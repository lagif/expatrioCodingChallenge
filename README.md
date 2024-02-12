# coding_challenge

This is the expatrio home assignment for the mobile post

## setting up and running the project

- to get all the dependencies for the project run:
  ```
  flutter pub get
  ```
- all the auto-generative code pieces were already generated,
  but if for some reason you want to regenerate them
  (in case you've cnahged something in the serializable-annotated classes):
  ```
  dart run build_runner build 
  ```

## credentials for access

- email : tito+bs792@expatrio.com
- password : nemampojma

## things I definitely would change, given more time:

- would pay more attention to methods length, extracting logically seprated pieces
- the design should be more shaped and have some rules and semantic values for colors, styles,
  etc...
- the authorization right now is not the best,
  given that its access token is short-lived and we have no refresh token.
  I would otherwise also store it and also use local authorization
- would bring in more tests
- would pay attention to different screen sizes
- would use less hardcoded values and put some settings to app settings
- would keep the code more DRY and YAGNI
- it's not the test projects's scope but
  logging events and crashes into some crashlytics is a great feat and improvement

It was nice to try manage this in a small periods of time (I work on other projects now and don't
have much time left apart from family and work)

