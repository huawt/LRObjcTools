Pod::Spec.new do |s|
  s.name             = 'LRObjcTools'
  s.version          = '0.2.0'
  s.summary          = 'A short description of LRObjcTools.'
  s.description      = 'A short description of LRObjcTools.'
  s.homepage         = 'https://github.com/huawt/LRObjcTools'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'huawt' => 'ghost263sky@163.com' }
  s.source           = { :git => 'https://github.com/huawt/LRObjcTools.git', :tag => s.version.to_s }
  s.ios.deployment_target = '12.0'
  s.source_files = 'LRObjcTools/Classes/**/*'
  s.frameworks = 'UIKit','Foundation','AVFoundation','ContactsUI','Contacts','CoreLocation','WebKit'
end
