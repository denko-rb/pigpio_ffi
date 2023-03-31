module PiGPIO
  extend FFI::Library
  ffi_lib 'pigpio'

  # Args: gpio, pulsewidth (in microseconds)
  attach_function :gpioServo, [:uint, :uint], :int

  # Args: gpio
  attach_function :gpioGetServoPulsewidth, [:uint, :uint], :int
end
