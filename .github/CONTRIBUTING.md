# Contributing

## Submission Process

### Engage

- Features: Discuss
- Bugs: Open Issue

### Branch

- fix/*: Changes to address bugs
- feature/*: Changes to add new or alter existing functionality
- main: Changes that are destined for the next release

### Release

- Pull Request
- Private Deployment
- Documentation
- Public Deployment

## Developer Setup

### Build Config

Generate publish keys

```sh
keytool -genkey -v -keystore /Users/<username>/.keys/android-keystore.p12 -storetype pkcs12 -keyalg RSA -keysize 2048 -validity 10000 -alias dev
```

Edit: [build.properties](/android/build.properties)

```properties
google.mapsApiKey=<value>
keys.storePassword=<password>
keys.keyPassword=<password>
keys.keyAlias=dev
keys.storeFile=/Users/<username>/.keys/android-keystore.p12
```

### Commands

```sh
# Build
flutter build appbundle
flutter build apk --split-per-abi
# Test
flutter test --reporter expanded --coverage
```
