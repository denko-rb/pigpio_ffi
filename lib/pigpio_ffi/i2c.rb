module PiGPIO
  extend FFI::Library
  ffi_lib 'pigpio'

  #
  # Open a handle for I2C device at specified address (0-127).
  # 
  # Args:    i2cBus, i2cAddr, i2cFlags (set to 0)
  # Returns: handle as integer
  attach_function :i2cOpen, [:uint, :uint, :uint], :int

  #
  # Close an I2C device handle.
  # 
  # Args: handle
  attach_function :i2cClose, [:uint], :int

  # i2cWriteQuick not mapped.

  # Args: handle, byte
  attach_function :i2cWriteByte, [:uint, :uint8], :int

  # Args: handle
  attach_function :i2cReadByte, [:uint], :int

  # i2cWriteByteData    not mapped.
  # i2cWriteWordData    not mapped.
  # i2cReadByteData     not mapped.
  # i2cReadWordData     not mapped.
  # i2cProcessCall      not mapped.
  # i2cWriteBlockData   not mapped.
  # i2cReadBlockData    not mapped.
  # i2cBlockProcessCall not mapped.

  # 
  # Read up to 32 bytes from a given I2C address (as handle), and start register.
  #
  # Don't call this directly.
  attach_function :_i2cReadI2CBlockData, :i2cReadI2CBlockData, [:uint, :uint, :pointer], :int
  #
  # Call this instead.
  def self.i2cReadI2CBlockData(handle, start_register, length)
    raise ArgumentError, "Cannot read more than 32 I2C bytes" if length > 32
    buffer_pointer = FFI::MemoryPointer.new(:uint8, length)

    # Read it and convert it to a Ruby array.
    self._i2cReadI2CBlockData(handle, start_register, buffer_pointer)
    bytes = buffer_pointer.read_array_of_type(:uint8, length)
  end

  # 
  # Write up to 32 bytes to a given I2C address (as handle), and start register.
  #
  # Don't call this directly.
  attach_function :_i2cWriteI2CBlockData, :i2cWriteI2CBlockData, [:uint, :uint, :pointer], :int
  #
  # Call this instead.
  def self.i2cWriteI2CBlockData(handle, start_register, byte_array)
    # Do some validation.
    raise ArgumentError, "Cannot write more than 32 I2C bytes" if byte_array > 32
    byte_array.each do |element|
      raise ArgumentError, "Byte values must be within 0x00 and 0xFF" if (element > 0xFF || element < 0x00)
    end

    # Copy the array to the pointer location.
    buffer_pointer = FFI::MemoryPointer.new(:uint8, byte_array.length)
    buffer_pointer.write_array_of_type(:uint8, byte_array)

    # Write it.
    self._i2cReadI2CBlockData(handle, start_register, buffer_pointer)
  end
  
  # i2cReadDevice   not mapped.
  # i2cWriteDevice  not mapped.

  #
  # When enabled, this sends repeated start bits instead of stop.
  # 
  # Args: setting (0=off, 1=on)
  attach_function :i2cSwitchCombined, [:uint], :void

  # i2cSegments not mapped.
  # i2cZip      not mapped.
  # bbI2COpen   not mapped yet.
  # bbI2CClose  not mapped yet.
  # bbI2CZip    not mapped yet.
end
