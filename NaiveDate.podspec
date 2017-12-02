Pod::Spec.new do |s|
    s.name             = 'NaiveDate'
    s.version          = '0.1'
    s.summary          = 'Naive date and time types'
    s.homepage         = 'https://github.com/kean/NaiveDate'
    s.license          = 'MIT'
    s.author           = 'Alexander Grebenyuk'
    s.social_media_url = 'https://twitter.com/a_grebenyuk'
    s.source           = { :git => 'https://github.com/kean/NaiveDate.git', :tag => s.version.to_s }

    s.ios.deployment_target = '10.0'
    s.watchos.deployment_target = '3.0'
    s.osx.deployment_target = '10.12'
    s.tvos.deployment_target = '10.0'

    s.source_files  = 'Sources/**/*'
end
