Pod::Spec.new do |s|

# 1
s.platform = :ios
s.ios.deployment_target = '13.2'
s.name = "NAWormySegment"
s.summary = "NAWormySegment is UIControl that acts like segment with animation(Wormy move)."
s.requires_arc = true

# 2
s.version = "0.1.0"

# 3
s.license = { :type => "abbaspour", :file => "LICENSE" }

# 4 - Replace with your name and e-mail address
s.author = { "Abbaspour" => "abbaspour_narjes@hotmail.com" }

# 5 - Replace this URL with your own GitHub page's URL (from the address bar)
s.homepage = "https://github.com/abbaspour-narjes/NAWormySegment"

# 6 - Replace this URL with your own Git URL from "Quick Setup"
s.source = { :git => "https://github.com/abbaspour-narjes/NAWormySegment.git",
             :tag => "#{s.version}" }

# 7
s.framework = "UIKit"


# 8
s.source_files = "NAWormySegment/**/*.{swift}"

# 9
s.resources = "NAWormySegment/**/*.{png,jpeg,jpg,storyboard,xib,xcassets}"

# 10
s.swift_version = "5"

end

