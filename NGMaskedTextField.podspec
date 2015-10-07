Pod::Spec.new do |s|
s.name         = "NGMaskedTextField"
s.version      = "0.1"
s.summary      = "The NGMaskedTextField enables you to apply masks or formats to UITextField instances."
s.homepage     = "https://github.com/Ngier/NGMaskedTextField"
s.license      = 'MIT'
s.author       = { "Faruk Kuscan" => "faruk.kuscan@ngier.com" }
s.source       = { :git => "https://github.com/Ngier/NGMaskedTextField.git", :commit => "fe0ca4589aa25a9cabdf6a929c517f04ac3cb26d" }

s.ios.deployment_target = '6.0'

s.source_files = 'Classes/*.{h,m}'

s.requires_arc = true
end
