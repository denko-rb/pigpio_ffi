module PiGPIO
	extend FFI::Library
	ffi_lib 'pigpio'

	# Pulse a GPIO by holding it at level for pulse length, then resetting to not level.
	# Args: gpio, pulse length, level
	attach_function :gpioTrigger, [:uint, :uint, :uint], :int

	# gpioSetWatchdog not mapped.

	# Returns: bit mask of GPIO states
	attach_function :gpioRead_Bits_0_31, [], :uint32 

	# Returns: bit mask of GPIO states
	attach_function :gpioRead_Bits_32_53, [], :uint32 

	# Arg: bit mask of pins to clear (1 = clear, 0 = leave alone)
	attach_function :gpioWrite_Bits_0_31_Clear, [:uint32], :int 

	# Arg: bit mask of pins to clear (1 = clear, 0 = leave alone)
	attach_function :gpioWrite_Bits_32_53_Clear, [:uint32], :int 

	# Arg: bit mask of pins to clear (1 = set, 0 = leave alone)
	attach_function :gpioWrite_Bits_0_31_Set, [:uint32], :int 

	# Arg: bit mask of pins to clear (1 = set, 0 = leave alone)
	attach_function :gpioWrite_Bits_32_53_Set, [:uint32], :int 

	#
	# Observe/listen for changes on a GPIO.
	# NOTE: Use the last method defined in this section.
	#
	# Callback receives args: gpio, value, tick (microseconds since boot, 72 minute overflow)
  callback :alert_callback, [:uint, :uint, :uint], :void
  #
	# Args: gpio, callback as proc (nil to disable)
	attach_function :_gpioSetAlertFunc, :gpioSetAlertFunc, [:uint, :alert_callback], :int
	#
	# Call this one with a block.
	def self.gpioSetAlertFunc(gpio, &block)
		self._gpioSetAlertFunc(gpio, &block)
	end

	# gpioSetAlertFuncEx not mapped.

	#
	# Register a callback with one of the hardware timers (0-9).
	# NOTE: Use the last method defined in this section.
	# 
	# Callback receives no args.
  callback :alert_callback, [], :void
  #
	# Args: timer index, millisecond interval, callback as proc (nil to disable)
	attach_function :_gpioSetTimerFunc, :gpioSetTimerFunc, [:uint, :uint], :int
	#
	# Call this one with a block.
	def self.gpioSetTimerFunc(timer, millis, &block)
		self._gpioSetTimerFunc(gpio, millis, &block)
	end

	# gpioSetTimerFuncEx not mapped.
	# gpioStartThread 	 not mapped.
	# gpioStopThread  	 not mapped.
end
