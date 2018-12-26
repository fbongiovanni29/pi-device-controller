module Devices
  class Mirror
    attr_accessor :brightness

    def initialize(brightness = nil)
      @brightness = brightness
    end

    def power(state)
      state ? cec_control.power_on : cec_control.power_off
    end

    def set_brightness(level)
      return if brightness == level

      go_to_brightness
      calibrate!
      remote_control.click_right(times: level)

      @brightness = level
    end

    def calibrate!
     remote_control.click_left(times: 100) 
    end

    def go_to_brightness
      remote_control.click_setup
      remote_control.click_right
      remote_control.click_down
      remote_control.click_right
    end

    def remote_control
      APIs::LIRC.new('magic_mirror')
    end

    def cec_control
      APIs::CEC.new('magic_mirror') 
    end
  end
end
