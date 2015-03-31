
Pod::Spec.new do |s|

  s.name         = "URBNEnvironmentPicker"
  s.version      = "0.2.1"
  s.summary      = "URBNEnvironmentPicker provides both UI & programmatic interfaces to switch environment settings during beta testing."
  s.homepage  	= 'http://www.urbn.com'
  s.license      = 'MIT'
  s.author    	= 'URBN Application Engineering Team'
  s.source       = { :git => "https://github.com/urbn/URBNEnvironmentPicker.git", :tag => s.version.to_s }
  s.platform  	= :ios, '7.0'
  s.requires_arc = true
  s.source_files = 'Pod/Classes/**/*'

end
