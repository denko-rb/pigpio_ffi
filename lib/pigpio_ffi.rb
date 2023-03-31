require 'ffi'

#
# Each file adds methods to the PiGPIO module, corresponding to a named
# section of the pigpgio C interface docs, located here:
# https://abyz.me.uk/rpi/pigpio/cif.html
# 
# NOTE: nothing from the following sections is mapped:
# Custom, Events, Files, Scripts, Serial, I2C/SPI Slave, Expert
#
require_relative 'pigpio_ffi/version'
require_relative 'pigpio_ffi/essential'
require_relative 'pigpio_ffi/basic'
require_relative 'pigpio_ffi/pwm'
require_relative 'pigpio_ffi/servo'
require_relative 'pigpio_ffi/intermediate'
require_relative 'pigpio_ffi/advanced'
require_relative 'pigpio_ffi/i2c'
require_relative 'pigpio_ffi/spi'
require_relative 'pigpio_ffi/waves'
require_relative 'pigpio_ffi/utilities'
require_relative 'pigpio_ffi/configuration'

#
# Additional convenience and helper methods added here.
# 
module PiGPIO
	extend FFI::Library
	ffi_lib 'pigpio'

  # Helper to handle systick integer rollover calculation.
  def self.gpioTicksSince(old_time)
    current_time = gpioTick
    if current_time < old_time
      (0xFFFF - old_time) + current_time
    else
      current_time - old_time
    end
  end
end
