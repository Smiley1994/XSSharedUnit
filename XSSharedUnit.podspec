Pod::Spec.new do |s|
  s.name         = "XSSharedUnit"
  s.version      = "0.0.3"
  s.summary      = "common library~~"
  s.homepage     = "https://github.com/Smiley1994"
  s.license      = "MIT"
  s.author       = { "macrolor" => "smileysun1994@gmail.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/Smiley1994/XSSharedUnit", :tag => s.version }
  s.requires_arc = true
  s.source_files = 'XSSharedUnit/**/*.{m,h}'
  s.frameworks = 'UIKit', 'Foundation', 'SystemConfiguration'
  s.dependency "AFNetworking"
  # s.libraries = 's'
  # s.default_subspec = 'XSSharedUnit'


end
