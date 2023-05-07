Pod::Spec.new do |spec|

    spec.name         = "UIPinField"
    spec.version      = "0.0.1"
    spec.summary      = "Pin input field"
    spec.description  = <<-DESC
                        Small iOS library to provide a robust pin view
                     DESC
    spec.homepage     = "https://github.com/Unicorn-Space/UIPinField"
    spec.license      = "MIT"
    spec.author       = { "Alexander Dadukin" => "alexanderdadukin@gmail.com",
                          "g02dev" => "g02dev.xyz" }
    spec.platform     = :ios, "13.0"
    spec.source       = { :git => "https://github.com/Unicorn-Space/UIPinField.git", :tag => "#{spec.version}" }
    spec.swift_version = "5.0"
    spec.source_files  = 'UIPinField/*.swift'
  
    spec.frameworks = 'Foundation'
    spec.frameworks = 'UIKit'
  
  end
