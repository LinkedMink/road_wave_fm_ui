# Contributing

## Setup

### Config Files

Edit: [api.properties](/android/api.properties)

```sh
google.mapsApiKey=<value>
```

Edit: [key.properties](/android/key.properties)

```sh
storePassword=<password>
keyPassword=<password>
keyAlias=upload
storeFile=/home/username/.keys/android.p12
```

## Build
```sh
flutter build appbundle
flutter build apk --split-per-abi
```
