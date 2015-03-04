
Pod::Spec.new do |s|

  s.name         = "URBNEnvironmentPicker"
  s.version      = "0.1"
  s.summary      = "The URBNEnvironmentPicker provides both UI and programmatic interfaces to switch environment dependent settings within your app during beta testing."
  s.homepage  	= 'http://www.urbn.com'
  s.license      = 'MIT'
  s.author    	= 'URBN Application Engineering Team'
  s.source       = { :git => "https://github.com/urbn/URBNEnvironmentPicker.git", :tag => s.version.to_s }
  s.platform  	= :ios, '7.0'
  s.requires_arc = true
  s.source_files = 'Pod/Classes/**/*'

end
