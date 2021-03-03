# Uncomment the next line to define a global platform for your project
platform :ios, '12.0'

#Avoid using code signing for librairies
post_install do |installer|
  installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
          config.build_settings['EXPANDED_CODE_SIGN_IDENTITY'] = ""
          config.build_settings['CODE_SIGNING_REQUIRED'] = "NO"
          config.build_settings['CODE_SIGNING_ALLOWED'] = "NO"
          config.build_settings['CLANG_WARN_QUOTED_INCLUDE_IN_FRAMEWORK_HEADER'] = 'NO'
          config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
      end
  end
end

def test_pods
    pod 'RxTest'
    pod 'RxBlocking'
    pod 'Quick'
    pod 'Nimble'
end

def swinject_pods
    pod 'Swinject'
    pod 'SwinjectAutoregistration'
end

def rx_pods
  pod 'RxCocoa'
  pod 'RxSwift'
  pod 'RxReachability'
  pod 'RxDataSources'
  pod 'RxCoreData'
  pod 'SDWebImage'
  pod 'SwiftLint'
end

target 'SeLoger' do
  use_frameworks!
  swinject_pods
  rx_pods
 # pod 'RxAlamofire'
  target 'SeLogerTests' do
    inherit! :search_paths
    test_pods
  end

end
