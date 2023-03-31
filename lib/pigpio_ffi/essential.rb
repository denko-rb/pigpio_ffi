module PiGPIO
  extend FFI::Library
  ffi_lib 'pigpio'

  attach_function :gpioInitialise, [], :int
  attach_function :gpioTerminate, [], :int
end
