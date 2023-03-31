# pigpio_ffi

This gem uses [FFI](https://github.com/ffi/ffi) to provide Ruby method bindings for the [pigpio](https://abyz.me.uk/rpi/pigpio/index.html) C library. This makes the GPIO pins of the Rasperry Pi single-board-computers (not the Pi Pico) usable in Ruby.

## Installation

Make sure pigpio is installed first with:
```shell
  sudo apt-get install pigpio
```

Install this gem:
```shell
  sudo gem install pigpio_ffi
```

Ruby scripts need to be run as root:
```shell
  sudo ruby my_script.rb
```

## Example

Example script:
```ruby
  require 'pigpio_ffi'

  PiGPIO.gpioInitialise
  PiGPIO.gpioSetMode(4, 1)

  10.times do
    PiGPIO.gpioWrite(4, 1)
    sleep 0.5
    PiGPIO.gpioWrite(4, 0)
    sleep 0.5
  end

  # This must be called or the script will block forever.
  PiGPIO.gpioTerminate
```
This will blink an LED attached to GPIO 4, every half second, for 10 seconds total.

## Mapped Features

  - Basic GPIO (set mode, read, write, alert on change)
  - PWM (bitbang)
  - Servo (bitbang)
  - Waves (infrared and other protocols)
  - I2C (still untested)
  - SPI (still untested)

## Documentation

As much as possible, the class methods of `PiGPIO` follow the function names and argument formats of the pigpio C functions. These can be found in its documentation, located [here](https://abyz.me.uk/rpi/pigpio/download.html)

The exceptions are:

  - Functions where one argument is a callback function. These translate to Ruby methods that take a block.
  - Functions that take arrays and their length as separate arguments. These translate to Ruby methods where the length argument is omitted.
  - Not all functions are mapped. I left out anything Ruby (or an existing gem) can do better anyway, or any complex data processing that would be easier in Ruby anyway.

TODO: List methods with different interfaces, and unmapped methods here.
