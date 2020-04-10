Pod::Spec.new do |s|


s.name = "NAWormySegment"
s.version = "0.1.0"
s.summary = "NAWormySegment is UIControl that acts like segment with animation(Wormy move)."
s.homepage = "https://github.com/abbaspour-narjes/NAWormySegment"
s.license = { :type => "abbaspour", :file => "LICENSE" }
s.author = { "Abbaspour" => "abbaspour_narjes@hotmail.com" }
s.ios.deployment_target = '13.2'
s.swift_version = "5"
s.source = { :git => "https://github.com/abbaspour-narjes/NAWormySegment.git",
             :tag => "#{s.version}" }
s.source_files = "NAWormySegment/**/*.{swift}"
s.requires_arc = true



end

