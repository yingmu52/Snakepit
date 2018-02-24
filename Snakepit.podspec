Pod::Spec.new do |s|
  s.name = "Snakepit"
  s.version = "0.0.6"
  s.summary = "iOS Dev Tool Kit"
  s.description = <<-DESC
  				   Some useful tool to for iOS development
                   DESC
  s.homepage = "https://github.com/yingmu52/Snakepit"
  s.license = { :type => "MIT", :file => "LICENSE" }
  s.author = "Xinyi Zhuang"
  s.source = { :git => "https://github.com/yingmu52/Snakepit.git", :tag => "#{s.version}" }
  s.source_files = "Snakepit/*.{swift}"
  s.ios.deployment_target = "9.0"
end

