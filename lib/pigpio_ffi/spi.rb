module PiGPIO
  extend FFI::Library
  ffi_lib 'pigpio'

  #
  # Open a handle for SPI device on the bus
  # 
  # Args: spiChan, baud, spiFlags (see pigpio docs)
  #       spiFlags control mode, chip select, LSB/MSB etc.
  #    
  # Returns: handle as integer
  attach_function :spiOpen, [:uint, :uint32, :uint32], :int

  #
  # Close an SPI device handle.
  # 
  # Args: handle
  attach_function :i2cClose, [:uint], :int

  # 
  # Read length bytes from the given SPI handle.
  #
  # Don't call this directly.
  # Args: handle, buffer, count
  attach_function :_spiRead, :spiRead, [:uint, :pointer, :uint], :int
  #
  # Call this instead.
  def self.spiRead(handle, length)
    # Limited to word sizes of 8 bits.
    buffer_pointer = FFI::MemoryPointer.new(:uint8, length)

    # Read it and convert it to a Ruby array.
    self._spiRead(handle, buffer_pointer, length)
    bytes = buffer_pointer.read_array_of_type(:uint8, length)
  end

  # 
  # Write bytes to the given SPI handle.
  #
  # Don't call this directly.
  attach_function :_spiWrite, :spiWrite, [:uint, :pointer, :uint], :int
  #
  # Call this instead.
  def self.spiWrite(handle, byte_array)
    # Do some validation.
    byte_array.each do |element|
      raise ArgumentError, "Byte values must be within 0x00 and 0xFF" if (element > 0xFF || element < 0x00)
    end

    # Copy the array to the pointer location.
    buffer_pointer = FFI::MemoryPointer.new(:uint8, byte_array.length)
    buffer_pointer.write_array_of_type(:uint8, byte_array)

    # Write it.
    self._spiWrite(handle, buffer_pointer, buffer_pointer.length)
  end

  # 
  # Xfer bytes from the SPI handle. Reads as many bytes as the legnth of the tx_buffer.
  #
  # Don't call this directly.
  attach_function :_spiXfer, :spiXfer, [:uint, :pointer, :pointer, :uint], :int
  #
  # Call this instead.
  def self.spiXfer(handle, tx_array)
    tx_array.each do |element|
      raise ArgumentError, "Byte values must be within 0x00 and 0xFF" if (element > 0xFF || element < 0x00)
    end

    # Copy the tx array to the pointer location.
    tx_pointer = FFI::MemoryPointer.new(:uint8, tx_array.length)
    tx_pointer.write_array_of_type(:uint8, tx_array)

    # Make pointer for the receive buffer.
    rx_pointer = FFI::MemoryPointer.new(:uint8, tx_array.length)

    # Transfer.
    self._spiWrite(handle, buffer_pointer, buffer_pointer.length)

    # Read bytes from the rx pointer.
    rx_bytes = rx_pointer.read_array_of_type(:uint8, tx_array.length)
  end

  # bbSPIOpen  not mapped.
  # bbSPIClose not mapped.
  # bbSPIXfer  not mapped.
end
