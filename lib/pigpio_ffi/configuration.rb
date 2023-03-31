module PiGPIO
	extend FFI::Library
	ffi_lib 'pigpio'

  #
  # GPIO callbacks do not trigger immediately.
  # This batches them every X milliseconds. Defaults to 120.
  #
  # NOTE: Must be called before #gpioInitialise.
  #
  # Args: buffer in milliseconds
  attach_function :gpioCfgBufferSize, [:uint], :int

  #
  # Configure the sampling rate for GPIO pins in microseconds.
  # Defaults to 5us using the PCM peripheral.
  #
  # NOTE: Must be called before #gpioInitialise.
  #
  # Args: microseconds, peripheral (0=PWM, 1=PCM), source (deprecated, give 0)
	attach_function :gpioCfgClock, [:uint, :uint, :uint], :int

  # gpioCfgDMAchannel is deprecated.

  #
  # Configure pigpio to use specified DMA channels (0-14).
  # Defaults:
  #   BCM2711: 7  (primary), 6 (secondary)
  #   Others:  14 (primary), 6 (secondary)
  #
  # NOTE: Must be called before #gpioInitialise.
  #
  # Args: DMA channel number
  attach_function :gpioCfgDMAchannels, [:uint], :int

  # gpioCfgPermission not mapped.
  # gpioCfgSocketPort not mapped.
  # gpioCfgInterfaces not mapped.

  #
  # NOTE: Must be called before #gpioInitialise.
  #
  # Args: memAllocMode (0-2)
  #       0 = AUTO
  #       1 = PAGEMAP
  #       2 = MAILBOX
  attach_function :gpioCfgMemAlloc, [:uint], :int

  # gpioCfgNetAddr      not mapped.
  # gpioCfgGetInternals not mapped.
  # gpioCfgSetInternals not mapped.
end
