module PiGPIO
	extend FFI::Library
	ffi_lib 'pigpio'

  # Args: gpio, dutycycle (0-range)
	attach_function :gpioPWM, [:uint, :uint], :int
	
	# Args: gpio
	attach_function :gpioGetPWMdutycycle, [:uint], :int
	
	# Args: gpio, range (25-40000)
	attach_function :gpioSetPWMrange, [:uint, :uint], :int

	# Args: gpio
	attach_function :gpioGetPWMrange, [:uint], :int

	# Args: gpio
	attach_function :gpioGetPWMrealRange, [:uint], :int
	
	# Args: gpio, frequency (In Hz, matches nearest available. See pigpio docs for more)
  attach_function :gpioSetPWMfrequency, [:uint, :uint], :int 

	# Args: gpio
	attach_function :gpioGetPWMfrequency, [:uint], :int
end
