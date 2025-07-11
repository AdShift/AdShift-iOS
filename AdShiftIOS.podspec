Pod::Spec.new do |s|
  s.name             = 'AdShiftIOS'
  s.version          = '1.0.2'
  s.summary          = 'Adshift SDK for iOS'
  s.documentation_url = 'https://github.com/AdShift/AdShift-iOS/blob/main/README.md'
  s.homepage         = 'https://github.com/AdShift/AdShift-iOS'
  s.license          = 'https://opensource.org/licenses/MIT'
  s.author           = { 'AdShift' => 'ios@adshift.com' }
  s.platform         = :ios, '14.0'

  
  s.source           = { :http => 'https://github.com/AdShift/AdShift-iOS/releases/download/1.0.1/AdshiftIOS.xcframework.zip' }

  s.vendored_frameworks = 'AdshiftIOS.xcframework'
end
