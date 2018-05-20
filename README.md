# JustDoIt

#### An example iOS Todo app. This is not full-featured, but it's meant to establish a base architectural pattern for adding features.

### Requirements
* Xcode 9.3
* iOS 11
* Carthage (current version `0.18-19-g743fa0f`)

### Setup
1. Clone the repo.
```
git clone git@github.com:davemess/JustDoIt.git
```
2. Update Carthage dependencies.
```
carthage update --platform iOS
```
3. Open using Xcode. Build and run the Development scheme. There are multiple schemes (Development, Staging, etc.) included with the project.

_**Note:** This project requires the WeatherService submodule which will not compile without a `Keys.swift` file. Keys are not included in the public repository due to security concerns. Request the keys from repo owner._

---

## Architecture
JustDoIt is an MVC app built modularly utilizing independent frameworks for additional functionality. The components are described here:

#### JustDoIt
This is the main app. It houses all the user-facing views and controllers.

#### JDIKit
This is the model and interaction layer. Model interactions are hidden behind a repository pattern. Utilize model managers for model CRUD operations.

#### WeatherService
This is a network-enabled service for getting the current weather at a designated location.

#### AFNAppKit
This module provides common, non-UI app utilities and helpers.

#### AFNUIUtilities
This module provides common UI app utilities.

#### AFNUIPermissions
This module provides a common interface for requesting user permissions for different iOS services such as location and photos.

---

## Usage

#### Branching
Gitflow is the guiding branch strategy. In addition to feature and bug branches, there are long-lived branches:
* `develop` bleeding-edge development and merge-branch for feature work
* `staging` beta testing and distribution
* `master` App Store distribution; releases should be marked with tags

#### Schemes
There are multiple schemes provided included in the workspace. For development use the `JustDoIT Development` and for release use `JustDoIT Staging`.

#### Configurations
User-defined configuration settings can be found in the xcconfig files in `Configurations` directory.

## Acknowledgements
https://openweathermap.org

---

## TODOs
* Better design
* Edit and delete Todo items
* Categorize Todo items
* Use mulitple CD contexts
* Add an onboarding flow
* Add Fastlane and distribute to beta testers (TestFlight)
* CloudKit sync
