platform :ios, '16.0'

flutter_application_path = File.expand_path(
  'DataspikeModule/dataspike_module/dataspike_module',
  __dir__
)
load File.join(flutter_application_path, '.ios', 'Flutter', 'podhelper.rb')

target 'flutteriosexample' do
  use_frameworks! :linkage => :static
  use_modular_headers!
  install_all_flutter_pods(flutter_application_path)
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    flutter_additional_ios_build_settings(target)
    target.build_configurations.each do |config|
      config.build_settings['EXCLUDED_ARCHS[sdk=iphonesimulator*]'] = 'arm64'
      config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] ||= [
      '$(inherited)',
      'PERMISSION_CAMERA=1',
      'PERMISSION_PHOTOS=1',
      'PERMISSION_MEDIA_LIBRARY=1',
      ]
      
      if Gem::Version.new($iOSVersion) > Gem::Version.new(config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'])
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = $iOSVersion
      end
    end
  end
  
  flutter_post_install(installer) if defined?(flutter_post_install)
end
