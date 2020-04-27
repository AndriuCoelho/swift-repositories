# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'GithubRepo' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  pod 'Alamofire', '~> 5.1'
  pod 'AlamofireImage', '~> 4.1'
  pod 'lottie-ios'
  pod 'FBSnapshotTestCase'

  post_install do |installer|
      installer.pods_project.targets.each do |target|
          target.build_configurations.each do |config|
              config.build_settings['ENABLE_BITCODE'] = 'NO'
          end
      end
  end

  target 'GithubRepoTests' do
    pod 'OHHTTPStubs/Swift'
    inherit! :search_paths
  end

end
