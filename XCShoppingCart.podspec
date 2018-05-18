

Pod::Spec.new do |s|
  s.name             = 'XCShoppingCart'
  s.version          = '0.0.1'
  s.summary          = 'XCShoppingCart 自定义购物车UI页面，使用简单'

  s.description      = <<-DESC
XCShoppingCart，自定义购物车UI页面，使用简单
                       DESC

  s.homepage         = 'https://github.com/fanxiaocong/XCShoppingCart'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'fanxiaocong' => '1016697223@qq.com' }
  s.source           = { :git => 'https://github.com/fanxiaocong/XCShoppingCart.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'XCShoppingCart/Classes/**/*'
  
  s.resource_bundles = {
    'XCShoppingCart' => ['XCShoppingCart/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'JSBadgeView', '~> 1.4.1'
end
