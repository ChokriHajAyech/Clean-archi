fastlane documentation
================
# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```
xcode-select --install
```

Install _fastlane_ using
```
[sudo] gem install fastlane -NV
```
or alternatively using `brew install fastlane`

# Available Actions
### podInstall
```
fastlane podInstall
```
Install pod dependencies
### lint
```
fastlane lint
```
Does a static analysis of the project. Configure the options in .swiftlint.yml
### test
```
fastlane test
```
Runs all the unit tests and UI Tests

Configure the .env.default file in this directory before you run the test or build lanes.

Info on the .env files and how to use them can be found here: https://github.com/fastlane/fastlane/blob/master/fastlane/docs/Advanced.md#environment-variables
### build
```
fastlane build
```
Builds the project and produces an .ipa. Pass in the build_number as a param. Default is 1.

Docs on how to pass in parameters are here: https://github.com/fastlane/fastlane/blob/master/fastlane/docs/Advanced.md#passing-parameters
### deploy
```
fastlane deploy
```
Deploys the built IPA and symbols on Testflight

----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
