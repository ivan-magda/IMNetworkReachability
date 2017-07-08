# IMNetworkReachability

![Swift](https://img.shields.io/badge/Swift-4.0-blue.svg)
![License](https://img.shields.io/npm/l/express.svg)
![CocoaPods](https://img.shields.io/cocoapods/v/IMNetworkReachability.svg)
![Platforms](https://img.shields.io/cocoapods/p/IMNetworkReachability.svg)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

IMNetworkReachability is a reachability framework.
It is designed to help you interface with network activity events. It allows you to monitor network state synchronously and asynchronously.

- [Usage](#usage)
- [Installation](#installation)

## Usage

#### Synchronously

```swift
let reachability = IMNetworkReachability("www.google.com")

switch reachability.isReachable() {
  case .reachable:
    print("Reachable")
  case .offline:
    print("Offline")
  case .error(let error):
    print("Failed to check for a network reachability, error: \(error)")
}
```

#### Closures

```swift
// Declare this property where it won't go out of scope relative to your listener
let reachability = IMNetworkReachability("www.google.com")

reachability.startListening { (result) in
// this is called on a main thread
  switch result {
    case .reachable:
      print("Reachable")
    case .offline:
      print("Offline")
    case .error(let error):
      print("Failed to check for a network reachability, error: \(error)")
  }
}
```

and for stopping notifications

```swift
reachability.stopListening()
```

Also, don't forget to [enable network access](https://developer.apple.com/library/content/documentation/Miscellaneous/Reference/EntitlementKeyReference/Chapters/EnablingAppSandbox.html#//apple_ref/doc/uid/TP40011195-CH4-SW9) on macOS.

## Installation
IMNetworkReachability supports multiple methods for installing the library in a project.

## Installation with CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party libraries like IMNetworkReachability in your projects. See the ["Getting Started" guide for more information](https://guides.cocoapods.org/using/getting-started.html). You can install it with the following command:

```bash
$ gem install cocoapods
```

#### Podfile

To integrate IMNetworkReachability into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'

target 'iOS' do
  platform :ios, '8.0'
  use_frameworks!

  pod 'IMNetworkReachability', '~> 0.2.0'

end

target 'macOS' do
  platform :osx, '10.9'
  use_frameworks!

  pod 'IMNetworkReachability', '~> 0.2.0'

end

target 'tvOS' do
  platform :tvos, '9.0'
  use_frameworks!

  pod 'IMNetworkReachability', '~> 0.2.0'

end

```

Then, run the following command:

```bash
$ pod install
```

### Installation with Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks.

You can install Carthage with [Homebrew](http://brew.sh/) using the following command:

```bash
$ brew update
$ brew install carthage
```

To integrate IMNetworkReachability into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "vanyaland/IMNetworkReachability" ~> 0.2.0
```

Run `carthage` to build the framework and drag the built `IMNetworkReachability.framework` into your Xcode project.

### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the `swift` compiler. It is in early development, but IMNetworkReachability does support its use on supported platforms. 

Once you have your Swift package set up, adding IMNetworkReachability as a dependency is as easy as adding it to the `dependencies` value of your `Package.swift`.

```swift
dependencies: [
    .package(url: "https://github.com/vanyaland/IMNetworkReachability.git", from: "0.2.0"),
]
```

### Manually

If you prefer not to use any of the aforementioned dependency managers, you can integrate IMNetworkReachability into your project manually.

#### Embedded Framework

- Open up Terminal, `cd` into your top-level project directory, and run the following command "if" your project is not initialized as a git repository:

  ```bash
  $ git init
  ```

- Add IMNetworkReachability as a git [submodule](http://git-scm.com/docs/git-submodule) by running the following command:

  ```bash
  $ git submodule add https://github.com/vanyaland/IMNetworkReachability.git
  ```

- Open the new `IMNetworkReachability` folder, and drag the `IMNetworkReachability.xcodeproj` into the Project Navigator of your application's Xcode project.

    > It should appear nested underneath your application's blue project icon. Whether it is above or below all the other Xcode groups does not matter.

- Select the `IMNetworkReachability.xcodeproj` in the Project Navigator and verify the deployment target matches that of your application target.
- Next, select your application project in the Project Navigator (blue project icon) to navigate to the target configuration window and select the application target under the "Targets" heading in the sidebar.
- In the tab bar at the top of that window, open the "General" panel.
- Click on the `+` button under the "Embedded Binaries" section.
- You will see two different `IMNetworkReachability.xcodeproj` folders each with two different versions of the `IMNetworkReachability.framework` nested inside a `Products` folder.

    > It does not matter which `Products` folder you choose from, but it does matter whether you choose the top or bottom `IMNetworkReachability.framework`.

- Select the top `IMNetworkReachability.framework` for iOS and the bottom one for OS X.

    > You can verify which one you selected by inspecting the build log for your project. The build target for `IMNetworkReachability` will be listed as either `IMNetworkReachability_iOS`, `IMNetworkReachability_macOS` or `IMNetworkReachability_tvOS`.

- And that's it!

  > The `IMNetworkReachability.framework` is automagically added as a target dependency, linked framework and embedded framework in a copy files build phase which is all you need to build on the simulator and a device.

---

## Author
I'm [Ivan Magda](https://www.facebook.com/ivan.magda).
Email: [imagda15@gmail.com](mailto:imagda15@gmail.com).
Twitter: [@magda_ivan](https://twitter.com/magda_ivan).

## LICENSE
This project is open-sourced software licensed under the MIT License.

See the LICENSE file for more information.
