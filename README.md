# JustDoIt

#### An example iOS Todo app. This is not full-featured, but it's meant to establish a base architectural pattern for adding features.

## Requirements
* Xcode 9.3
* iOS 11
* Carthage (current version `0.18-19-g743fa0f`)

## Usage
#### Setup
1. Clone the repo.
```
git clone git@github.com:davemess/JustDoIt.git
```
2. Update Carthage dependencies.
```
carthage update --platform iOS
```
3. Open using Xcode. Build and run the Development scheme. There are multiple schemes (Development, Staging, etc.) included with the project.

#### Branching
Gitflow is the guiding branch strategy. In addition to feature and bug branches, there are long-lived branches:
* `develop` bleeding-edge development and merge-branch for feature work
* `staging` beta testing and distribution
* `master` App Store distribution; releases should be marked with tags

#### Configurations
User-defined configuration settings can be found in the xcconfig files in `Configurations` directory.

## Acknowledgements
_TBD_
