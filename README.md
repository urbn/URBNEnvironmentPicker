[![CI Status](http://img.shields.io/travis/urbn/URBNEnvironmentPicker.svg?style=flat)](https://travis-ci.org/urbn/URBNEnvironmentPicker)
[![Version](https://img.shields.io/cocoapods/v/URBNEnvironmentPicker.svg?style=flat)](http://cocoadocs.org/docsets/URBNEnvironmentPicker)
[![License](https://img.shields.io/cocoapods/l/URBNEnvironmentPicker.svg?style=flat)](http://cocoadocs.org/docsets/URBNEnvironmentPicker)
[![Platform](https://img.shields.io/cocoapods/p/URBNEnvironmentPicker.svg?style=flat)](http://cocoadocs.org/docsets/URBNEnvironmentPicker)

URBNEnvironmentPicker
=====================

The URBNEnvironmentPicker provides both UI and programmatic interfaces to switch environment dependent settings within your app during beta testing.

It comes with 3 classes:

`URBNEnvironment`  
`URBNEnvironmentController`  
`URBNEnvironmentPickerTableViewController`  


The classes themselves are fairly simple - the API for the `URBNEnvironmentController` is very similar to `NSUserDefaults`. The class interfaces are well documented, so using it should be straightforward.

The environment picker is driven by a that plist you include in your app named `URBNEnvironments.plist`. Checkout the sample plist provided in the demo app for the format.


## Setup

Add this to your Podfile:

`pod 'URBNEnvironmentPicker'`