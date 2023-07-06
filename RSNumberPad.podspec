#
# Be sure to run `pod lib lint RSNumberPad.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'RSNumberPad'
  s.version          = '1.1.0'
  s.summary          = 'Random and Secure NumberPad'
  s.swift_version    = '5.0'

  s.description      = <<-DESC
  A library to store and verify algorithmically encrypted numbers in a keychain using a keypad with randomly changing numbers.
                       DESC

  s.homepage         = 'https://github.com/devxsby/RSNumberPad'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'devxsby' => 'devxsby@gmail.com' }
  s.source           = { :git => 'https://github.com/devxsby/RSNumberPad.git', :tag => s.version.to_s }
  
  s.ios.deployment_target = '13.0'

  s.source_files = 'Sources/RSNumberPad/**/*'
  
end
