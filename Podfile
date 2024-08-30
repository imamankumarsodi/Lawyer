# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Lawyer' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  
  # Pods for Lawyer
  
  pod 'IQKeyboardManagerSwift'
  pod 'SkyFloatingLabelTextField', '~> 3.0'
  pod 'lottie-ios'
  pod 'DropDown','2.3.4'
  pod 'paper-onboarding'
  pod 'ViewAnimator'
  pod 'Cosmos', '~> 22.1'
  pod 'Alamofire','~> 4.9.0'
  pod 'SwiftyJSON'
  #pod 'FullMaterialLoader', '~> 0.2.3'
  pod 'SDWebImage', '~> 5.0'
  pod 'ReachabilitySwift'
  pod 'XCGLogger', '~> 7.0.1'
  pod 'TagListView', '~> 1.0'
  pod 'SkeletonView'
  pod 'SwipeCellKit'
  pod 'razorpay-pod', '~> 1.1.7'
  pod 'FSPagerView'
  # pod 'RealmSwift'
  # pod 'ObjectMapper', '~> 3.5'

  # add the Firebase pod for Google Analytics
  pod 'Firebase/Analytics'
  pod 'Firebase/Messaging'
  pod 'Firebase/Crashlytics'
  pod 'Firebase/Performance'
  pod 'Firebase/Core'
  # pod 'Fabric', '~> 1.10.2'

  # add pods for any other desired Firebase products
  # https://firebase.google.com/docs/ios/setup#available-pods

  
  target 'LawyerTests' do
    inherit! :search_paths
    # Pods for testing
  end
  
  target 'LawyerUITests' do
    # Pods for testing
  end
  
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['CLANG_WARN_DOCUMENTATION_COMMENTS'] = 'NO'
    end
  end
end
