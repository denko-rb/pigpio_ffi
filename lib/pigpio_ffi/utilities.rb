module PiGPIO
  extend FFI::Library
  ffi_lib 'pigpio'

  # Args: delay time in microseconds
  # Returns: actual delay time in microseconds
  attach_function :gpioDelay, [:uint32], :uint32

  #
  # Returns: current system tick (microseconds with 72 miniute rollover)
  attach_function :gpioTick, [], :uint32

  # Returns: integer corresponding to Raspberry Pi hardware revision
  attach_function :gpioHardwareRevision, [], :uint

  # Returns: pigpio version
  attach_function :gpioVersion, [], :uint

  # getBitInBytes not mapped.
  # putBitInBytes not mapped.
  # gpioTime      not mapped.
  # gpioSleep     not mapped.
  # time_time     not mapped.
  # time_sleep    not mapped.
end
