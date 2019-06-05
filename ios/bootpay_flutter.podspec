#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = 'bootpay_flutter'
  s.version          = '0.0.1'
  s.summary          = 'Bootpay payment moudle for flutter'
  s.description      = <<-DESC
Bootpay payment moudle for flutter
                       DESC
  s.homepage         = 'https://facebook.com/jaceshi.kr'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Jace Shim' => 'https://facebook.com/jaceshi.kr' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.dependency 'SwiftyBootpay', '2.1.18'

  s.static_framework = true

  s.ios.deployment_target = '11.0'
end

