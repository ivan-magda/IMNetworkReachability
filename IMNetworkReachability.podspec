Pod::Spec.new do |s|
  s.name = "IMNetworkReachability"
  s.version = "0.2.1"
  s.license = { :type => "MIT", :file => "LICENSE" }
  s.summary = "Network reachability framework"
  s.homepage = "https://github.com/vanyaland/IMNetworkReachability"
  s.social_media_url = "https://twitter.com/magda_ivan"
  s.author = { "Ivan Magda" => "imagda15@gmail.com" }
  s.source = { :git => "https://github.com/vanyaland/IMNetworkReachability.git", :tag => "#{s.version}" }

  s.ios.deployment_target  = "8.0"
  s.osx.deployment_target  = "10.9"
  s.tvos.deployment_target = "9.0"
  
  s.source_files  = "IMNetworkReachability", "Sources/**/*.{h,m,swift}"
end