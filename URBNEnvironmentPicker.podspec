
Pod::Spec.new do |s|

  s.name         = "URBNEnvironmentPicker"
  s.version      = "0.0.3"
  s.summary      = "The URBNEnvironmentPicker provides both UI and programmatic interfaces to switch environment dependent settings within your app during beta testing."

  s.description  = <<-DESC
				   The URBNEnvironmentPicker provides both UI and programmatic interfaces to switch environment dependent settings within your app during beta testing.

           It comes with 3 classes:

           `URBNEnvironment`
           `URBNEnvironmentController`
           `URBNEnvironmentPickerTableViewController`


           The classes themselves are fairly simple - the API for the `URBNEnvironmentController` is very similar to `NSUserDefaults`. The class interfaces are well documented, so using it should be straightforward.

           The environment picker is driven by a that plist you include in your app named `URBNEnvironments.plist`. Checkout the sample plist provided in the demo app for the format.
                   DESC

  s.homepage  	= 'http://www.urbn.com'
  s.license      = 'MIT'
  s.author    	= 'URBN Application Engineering Team'

  s.source       = { :git => "https://github.com/urbn/URBNEnvironmentPicker.git", :tag => s.version.to_s }

  s.platform  	= :ios, '7.0'
  s.requires_arc = true

  s.source_files  = "URBNEnvironmentPicker/*.{h,m}"
  s.frameworks = 'UIKit','Foundation'
  s.dependencies = 'BlocksKit','Mantle','libextobjc'

end
