module Devices
  class Heater
    attr_reader :device
    attr_accessor :power_status, :temperature_set, :nest

    def initialize(device, temperature_set = nil, power_status = false , nest = nil)
      @device = device
      @temperature_set = temperature_set
      @power_status = power_status
      @nest = nest
    end

    def control!
      @nest = nil
      power(active_temperature_range? || forced_time_on?)
    end

    def calibrate!
      power(true)

      remote_control.click_lower_temperature(times: temperature_setting_gap) 
      remote_control.click_raise_temperature(times: (target_temperature_gap))

      power(active_temperature_range?)
    end

    def power(status)
      remote_control.click_power unless power_status == status
      @power_status = status
    end

    def reset_power!
      2.times { power(!power_status) }
    end

    def active_temperature_range?
      temperature_settings['degrees_on_above_nest'] >= nest.temperature_difference
    end

    def forced_time_on?
      return false if temperature_settings['forced_time_on'].blank?

      Time.current.between?(
        Time.current.midnight + temperature_settings['forced_time_on']['start'].hours,
        Time.current.midnight + temperature_settings['forced_time_on']['stop'].hours
      )
    end

    def target_temperature_gap
      nest.target_temperature + temperature_settings['degrees_on_above_nest'] +
        temperature_settings['offset_toggles'] - temperature_settings['lowest_degree']
    end

    def temperature_setting_gap
      temperature_settings['highest_degree'] - temperature_settings['lowest_degree'] + 1
    end

    def temperature_settings
      Devices.config[device]['temperature_settings']
    end

    def remote_control
      APIs::LIRC.new(device)
    end

    def nest
      Devices::Nest::Request.new('devices').response
    end
  end
end
