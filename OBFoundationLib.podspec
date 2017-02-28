
Pod::Spec.new do |s|

    s.name         = "OBFoundationLib"
    s.version      = "1.0.1"
    s.summary      = "Base foundation library."

    s.description      = <<-DESC
    TODO: A library of base foundation.
    DESC

    s.homepage     = "https://github.com/ObornJung/OBFoundationLib"
    s.license      = { :type => "MIT", :file => "LICENSE" }
    s.author       = { "Oborn.Jung" => "obornjung@gmail.com" }
    s.authors      = { "Oborn.Jung" => "obornjung.jj@alibaba-inc.com" }

    s.platform     = :ios, "7.0"
    s.source       = { :git => "https://github.com/ObornJung/OBFoundationLib.git", :tag => s.version }

    s.source_files = 'OBFoundationLib/*.{m,h}'
    s.public_header_files = 'OBFoundationLib/*.h'

    s.subspec 'Macro' do |ss|
        ss.source_files = 'OBFoundationLib/Macro/**/*.{m,h}'
        ss.public_header_files = 'OBFoundationLib/Macro/**/*.h'
    end

    s.subspec 'Moudle' do |ss|
        ss.dependency 'OBFoundationLib/Macro'
        ss.dependency 'OBFoundationLib/SystemExtend'
        ss.source_files = 'OBFoundationLib/Moudle/**/*.{m,h}'
        ss.public_header_files = 'OBFoundationLib/Moudle/**/*.h'
    end

    s.subspec 'SystemExtend' do |ss|
        ss.dependency 'OBFoundationLib/Macro'
        ss.source_files = 'OBFoundationLib/SystemExtend/**/*.{m,h}'
        ss.public_header_files = 'OBFoundationLib/SystemExtend/**/*.h'
    end

    s.requires_arc = true
    s.frameworks   = "Foundation", "UIKit", "AVFoundation"

end
