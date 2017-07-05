# IMNetworkReachability

![Swift](https://img.shields.io/badge/Swift-4.0-blue.svg)
![License](https://img.shields.io/npm/l/express.svg)
![CocoaPods](https://img.shields.io/cocoapods/v/IMNetworkReachability.svg)
![Platforms](https://img.shields.io/cocoapods/p/IMNetworkReachability.svg)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

IMNetworkReachability is a reachability framework.
It is designed to help you interface with network activity events. It allows you to monitor network state synchronously and asynchronously.

## Examples

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

  pod 'IMNetworkReachability', '~> 0.1'

end

target 'macOS' do
  platform :osx, '10.9'
  use_frameworks!

  pod 'IMNetworkReachability', '~> 0.1'

end

target 'tvOS' do
  platform :tvos, '9.0'
  use_frameworks!

  pod 'IMNetworkReachability', '~> 0.1'

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
github "vanyaland/IMNetworkReachability" ~> 0.1
```

Run `carthage` to build the framework and drag the built `IMNetworkReachability.framework` into your Xcode project.

## Author
I'm [Ivan Magda](https://www.facebook.com/ivan.magda).
Email: [imagda15@gmail.com](mailto:imagda15@gmail.com).
Twitter: [@magda_ivan](https://twitter.com/magda_ivan).

## LICENSE
This project is open-sourced software licensed under the MIT License.

See the LICENSE file for more information.
