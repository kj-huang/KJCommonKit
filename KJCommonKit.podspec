#
# Be sure to run `pod lib lint KJCommonKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'KJCommonKit'
  s.version          = '0.0.1'
  s.summary          = 'KJCommonKit'
  s.description      = <<-DESC
TODO: 一些原生小组件
                       DESC
  s.homepage         = 'https://github.com/kj-huang/KJCommonKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'jin' => 'kegem@foxmail.com' }
  s.source           = { :git => 'https://github.com/kj-huang/KJCommonKit.git', :tag => s.version.to_s }
  s.ios.deployment_target = '9.0'
  s.source_files = 'KJCommonKit/KJCommonKit/**/*'
  s.frameworks = 'UIKit', 'Foundation'
  
  
  s.subspec 'KJAlertController' do |ss|
    ss.source_files = 'KJCommonKit/KJCommonKit/KJAlertController'
    ss.dependency = 'KJCommonKit/KJCommonKit/KJCommonCore'
    

end
