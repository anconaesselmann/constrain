# constrain

[![CI Status](https://img.shields.io/travis/anconaesselmann/constrain.svg?style=flat)](https://travis-ci.org/anconaesselmann/constrain)
[![Version](https://img.shields.io/cocoapods/v/constrain.svg?style=flat)](https://cocoapods.org/pods/constrain)
[![License](https://img.shields.io/cocoapods/l/constrain.svg?style=flat)](https://cocoapods.org/pods/constrain)
[![Platform](https://img.shields.io/cocoapods/p/constrain.svg?style=flat)](https://cocoapods.org/pods/constrain)

## Example

~To run the example project, clone the repo, and run `pod install` from the Example directory first.~ Example project only used for testing so far

## Requirements

## Installation

constrain is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'constrain'
```

## Usage

This library lets you quickly and efficiently set up a number of constraints using intuitive chaining syntax. For example:

```swift
let containerView = UIView()
let newView = UIView()
let centeredView = UIView()
containerView.constainSubview(newView).fillSafely()
centeredView.constrainIn(containerView).center()
```

Notes:
 - All constraints are enabled by default
 - Adding subviews is handled by `constrainSubview()`, `constrainIn()`, `constrainSibling()`, `constrainSiblingToTrailing()`, or `constrainSiblingToBottom()`. If you need to add more constraints at a later time, just call `constrain` subsequently to avoid redoing it, although there's no harm in it.
 - `translatesAutoresizingMaskIntoConstraints` is always set to false
 - Most methods can also be called with View Controllers, but only the `constrainChild()` method handles parent/child UIViewController relationships. Call `remove()` to undo it.

## Author

anconaesselmann, axel@anconaesselmann.com

## License

constrain is available under the MIT license. See the LICENSE file for more info.
