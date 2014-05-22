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

`pod 'URBNEnvironmentPicker', :git => 'git@github.com:urbn/URBNEnvironmentPicker.git'`
