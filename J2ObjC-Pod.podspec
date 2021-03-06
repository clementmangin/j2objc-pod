#
# Be sure to run `pod lib lint J2ObjC-Pod.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

class Pod::SpecHelper; end

Pod::Spec.new do |s|
  s.name             = 'J2ObjC-Pod'
  s.version          = '1.3.1'
  s.summary          = 'Integrates the pre-built J2ObjC frameworks into your project.'
  s.description      = <<-DESC
  Downloads the J2ObjC v1.3.1 release and integrates the frameworks into your project.
                       DESC

  s.homepage         = 'https://bitbucket.org/smartika/j2objc-pod'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Smartika' => 'info@smartika.com' }
  s.source           = { :git => 'https://bitbucket.org/smartika/j2objc-pod.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.requires_arc = true
  s.preserve_paths = 'dist'

  s.prepare_command = <<-CMD
    Scripts/download.sh
  CMD

  s.default_subspec = 'lib/all'

  s.source_files = 'dist/include/**/*.h'
  # s.public_header_files = 'dist/include/**/*.h'
  s.header_mappings_dir = 'dist/include'

  s.subspec 'lib' do |lib|
    lib.frameworks = 'Security'
    lib.osx.frameworks = 'ExceptionHandling'
    # lib.pod_target_xcconfig = {
    #   'HEADER_SEARCH_PATHS' =>  "${PODS_ROOT}/#{s.name}/dist/include/**"
    # }

    lib.subspec 'all' do |all|
      all.dependency "#{s.name}/lib/jre"
      # all.dependency "#{s.name}/lib/jsr305"
      # all.dependency "#{s.name}/lib/guava"
      all.dependency "#{s.name}/lib/javax_inject"
      # all.dependency "#{s.name}/lib/xalan"
      # all.dependency "#{s.name}/protobuf_runtime"
    end

    lib.subspec 'jre' do |jre|
      jre.libraries = 'z', 'icucore'
      jre.vendored_libraries = 'dist/lib/libjre_emul.a'
    end

    lib.subspec 'jsr305' do |jsr305|
      jsr305.dependency "#{s.name}/lib/jre"
      jsr305.vendored_libraries = 'dist/lib/libjsr305.a'
    end

    # lib.subspec 'junit' do |junit|
    #   junit.dependency "#{s.name}/lib/jre"
    #   junit.vendored_libraries = 'dist/lib/libjunit.a', 'dist/lib/libmockito.a'
    # end

    lib.subspec 'guava' do |guava|
      guava.dependency "#{s.name}/lib/jre"
      guava.dependency "#{s.name}/lib/jsr305"
      guava.vendored_libraries = 'dist/lib/libguava.a'
    end

    lib.subspec 'javax_inject' do |javax_inject|
      javax_inject.dependency "#{s.name}/lib/jre"
      javax_inject.vendored_libraries = 'dist/lib/libjavax_inject.a'
    end

    # lib.subspec 'xalan' do |xalan|
    #   xalan.dependency "#{s.name}/lib/jre"
    #   xalan.vendored_libraries = 'dist/lib/libxalan.a'
    # end

    # lib.subspec 'protobuf_runtime' do |protobuf_runtime|
    #   protobuf_runtime.vendored_libraries = 'dist/lib/libprotobuf_runtime.a'
    # end
  end
end
