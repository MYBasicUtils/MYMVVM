

Pod::Spec.new do |s|
  s.name             = 'MYMVVM'
  s.version          = '0.1.0'
  s.summary          = 'A short description of MYMVVM.'

  s.description      = <<-DESC
    MYMvvm
                       DESC

  s.homepage         = 'https://github.com/WenMingYan/MYMVVM'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'WenMingYan' => 'wenmingyan1990@gmail.com' }
  s.source           = { :git => 'https://github.com/WenMingYan/MYMVVM.git', :tag => s.version.to_s }

  s.ios.deployment_target = '15.0'
  
  s.source_files = 'MYMVVM/Classes/**/*'
  
  s.dependency 'MYUtils'
  s.dependency 'Masonry'
  s.dependency 'MYRouter'
  s.dependency 'MYImageCache'
  s.dependency 'MYSkin'
  s.dependency 'MYUIKit'
  s.dependency 'MYIconfont'
#  s.dependency 'ReactiveCocoa'
  
end
