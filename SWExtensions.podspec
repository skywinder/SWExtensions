Pod::Spec.new do |s|
  s.name             = "SWExtensions"
  s.version          = "0.1.0"
  s.summary          = "Collection of must have swift extensions for iOS developers."
  s.description      = "Collection of must have swift extensions for iOS developers.
                        Most of them is a wrapper of UIKit, Foundations and Core Animation boilerplates.
                       "
  s.homepage         = "https://github.com/skywinder/SWExtensions"
  s.license          = 'MIT'
  s.author           = { "Petr Korolev" => "sky4winder@gmail.com" }
  s.source           = { :git => "https://github.com/skywinder/SWExtensions.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/skywinder'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'SWExtensions/**/*'

  s.frameworks = 'UIKit', 'QuartzCore'
end
