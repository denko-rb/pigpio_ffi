module PiGPIO
  extend FFI::Library
  ffi_lib 'pigpio'

  # Args: gpio, mode (0 = input, 1 = output, 2-7 = alternative)
  attach_function :gpioSetMode, [:uint, :uint], :int
  
  # Args: gpio
  attach_function :gpioGetMode, [:uint], :int

  # Args, gpio, pud (0 = off, 1 = pulldown, 2 = pullup)
  attach_function :gpioSetPullUpDown, [:uint, :uint], :int
  
  # Args: gpio
  attach_function :gpioRead, [:uint], :int

  # Args: gpio, level
  attach_function :gpioWrite, [:uint, :uint], :int
end
