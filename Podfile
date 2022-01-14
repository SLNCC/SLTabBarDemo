
platform :ios, '9.0'
#pod源
source 'https://github.com/cocoapods/specs.git'
install!'cocoapods',:deterministic_uuids=>false

#消除警告
inhibit_all_warnings!
#指定三方库支持的target版本
post_install do |installer|
  #指定三方库支持的target版本
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      if config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'].to_f < 9.0
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '9.0'
      end
    end
  end
end


target 'SLTabBarDemo' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  #lottie动画
  pod 'lottie-ios'
  pod 'CYLTabBarController', '~> 1.28.5'
end

