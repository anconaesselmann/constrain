Pod::Spec.new do |s|
  s.name             = 'constrain'
  s.version          = '1.0.3'
  s.summary          = 'Constrain helps with creating layout constraints'
  s.swift_version    = '5.0'

  s.description      = <<-DESC
Simplified syntax for layout constraints. Save and edit layout constraints.
                       DESC

  s.homepage         = 'https://github.com/anconaesselmann/constrain'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'anconaesselmann' => 'axel@anconaesselmann.com' }
  s.source           = { :git => 'https://github.com/anconaesselmann/constrain.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'

  s.source_files = 'constrain/Classes/**/*'
end
