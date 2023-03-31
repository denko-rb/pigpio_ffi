module PiGPIO
	extend FFI::Library
	ffi_lib 'pigpio'
  
  #
	# Struct for holding a single pulse. Given as a hash in Ruby.
	# gpioOn and gpioOff are bitmasks 32 bits long, NOT GPIO numbers.
  class WavePulse < FFI::Struct
    layout  :gpioOn, :uint32,
            :gpioOff, :uint32,
            :usDelay, :uint32
  end

	attach_function :gpioWaveClear, [], :int
	attach_function :gpioWaveAddNew, [], :int
	
	#
	# Don't call this directly.
	attach_function :_gpioWaveAddGeneric, :gpioWaveAddGeneric, [:uint, :pointer], :int
	#
	# Call this instead. No length arg like C function.
	# Args: array of pulse hashes.
	def self.gpioWaveAddGeneric(pulses=[])
		pulses_pointer = FFI::MemoryPointer.new(WavePulse, pulses.length)
		pulse_structs = pulses.length.times.collect do |i|
			WavePulse.new(pulses_pointer + i * WavePulse.size)
		end
		pulses.each_with_index do |hash, i|
			pulse_structs[i][:gpioOn]  = hash[:gpioOn]
			pulse_structs[i][:gpioOff] = hash[:gpioOff]
			pulse_structs[i][:usDelay] = hash[:usDelay] 
		end
	  self._gpioWaveAddGeneric(pulses.length, pulses_pointer)
	end
	
	# gpioWaveAddSerial not mapped.

	# Returns: wave_id        
	attach_function :gpioWaveCreate, [], :int

	# gpioWaveCreatePad not mapped.

	# Args: wave_id 
	attach_function :gpioWaveDelete, [:uint], :int

	# Args: wave_id, mode (0 = oneshot, 1 = repeat, 2 = oneshot sync, 3 = repeat sync)
	attach_function :gpioWaveTxSend, [:uint, :uint], :int
	
	#
	# Don't call this directly.
	attach_function :_gpioWaveChain, :gpioWaveChain, [:pointer, :uint], :int
	#
	# Call this instead. No length arg like C function.
	# Args: array of wave_ids to send in order.
	def self.gpioWaveChain(wave_id_array=[])
    # NOTE: Should add validation here? Each array element should be a byte.
    # Maximum number of bytes should be 600.

    # Just pack the byte array into a string. Gets mapped to char * in C.
    string = wave_id_array.pack('C*')
	  self._gpioWaveChain(string, wave_id_array.length)
	end
  
	# Returns: wave_id of wave being transmitted
	attach_function :gpioWaveTxAt, [], :int

	# Returns: 1 if transmitting, 0 otherwise
	attach_function :gpioWaveTxBusy, [], :int

	# Returns: 0 if OK
	attach_function :gpioWaveTxStop, [], :int

	# Returns: length (in microseconds) of current wave
	attach_function :gpioWaveGetMicros, [], :int

	# Returns: length of longest wave since initialise (in terms of microseconds)
	attach_function :gpioWaveGetHighMicros, [], :int

	# Returns: length of longest wave possible (in terms of microseconds)
	attach_function :gpioWaveGetMaxMicros, [], :int

	# Returns: length (in pulses) of current wave
	attach_function :gpioWaveGetPulses, [], :int

	# Returns: length of longest wave since initialise (in terms of pulses)
	attach_function :gpioWaveGetHighPulses, [], :int

	# Returns: length of longest wave possible (in terms of pulses)
	attach_function :gpioWaveGetMaxPulses, [], :int

	# Returns: length of longest wave since initialise (in terms of DMA control blocks)
	attach_function :gpioWaveGetCbs, [], :int

	# Returns: length of longest wave possible (in terms of DMA control blocks)
	attach_function :gpioWaveGetHighCbs, [], :int

	# Returns: length of longest wave possible (in terms of DMA control blocks)
	attach_function :gpioWaveGetMaxCbs, [], :int
end
