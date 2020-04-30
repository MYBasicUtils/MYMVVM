

Pod::Spec.new do |s|
  s.name             = 'MYMVVM'
  s.version          = '0.1.0'
  s.summary          = 'A short description of MYMVVM.'

  s.description      = <<-DESC
    MYMvvm
                       DESC

  s.homepage         = 'https://github.com/WenMingYan/MYMVVM'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'WenMingYan' => 'wenmy@tuya.com' }
  s.source           = { :git => 'https://github.com/WenMingYan/MYMVVM.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'MYMVVM/Classes/**/*'
  
  # s.resource_bundles = {
  #   'MYMVVM' => ['MYMVVM/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'MYUtils'
  s.dependency 'Masonry'
  s.dependency 'MYRouter'
  s.dependency 'MYImageCache'
  
end
