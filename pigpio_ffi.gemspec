require_relative 'lib/pigpio_ffi/version'

Gem::Specification.new do |s|
  s.name        = 'pigpio_ffi'
  s.version     = PiGPIO::VERSION
  s.licenses    = ['MIT']
  s.summary     = "FFI bindings for pigpio C library on Raspberry Pi devices"
  s.description = "Use your Raspberry Pi GPIO pins in Ruby. This gem uses FFI to provide Ruby bindings for the pigpio C library on compatible Raspberry Pi Devices."
  s.authors     = ["vickash"]
  s.email       = 'vickashmahabir@gmail.com'
  s.files       =  Dir['**/*']
  s.homepage    = 'https://github.com/dino-rb/pigpio_ffi'
  s.metadata    = { "source_code_uri" => "https://github.com/dino-rb/pigpio_ffi" }

  s.add_dependency 'ffi'
end
