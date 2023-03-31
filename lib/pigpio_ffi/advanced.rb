module PiGPIO
	extend FFI::Library
	ffi_lib 'pigpio'

  # gpioNotifyOpen         not mapped.
  # gpioNotifyClose        not mapped.
	# gpioNotifyOpenWithSize not mapped.
	# gpioNotifyBegin        not mapped.
	# gpioNotifyPause        not mapped.

  # gpioHardwareClock      not mapped.
  # gpioHardwarePWM        not mapped.

	# Args: gpio, steady time
	attach_function :gpioGlitchFilter, [:uint, :uint], :int 

	# Args: gpio, steady time, active time
	attach_function :gpioNoiseFilter, [:uint, :uint, :uint], :int

  # gpioSetPad	            not mapped.
  # gpioGetPad	            not mapped.
  # shell	                  not mapped.
  # gpioSetISRFunc	        not mapped.
  # gpioSetISRFuncEx	      not mapped.
  # gpioSetSignalFunc	      not mapped.
  # gpioSetSignalFuncEx	    not mapped.
  # gpioSetGetSamplesFunc	  not mapped.
  # gpioSetGetSamplesFuncEx	not mapped.
end
