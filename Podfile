# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'CommonCodeWatch' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  pod 'Alamofire', '~> 4.5'
  pod 'SwiftLint'
  
  target 'OctoPrintWatch Extension' do
      inherit! :search_paths
  end
  
end

target 'CommonCodePhone' do
    # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
    use_frameworks!
    
    pod 'Alamofire', '~> 4.5'
    pod 'SwiftLint'
    
    target 'OctoPrint' do
        inherit! :search_paths
    end
end
