module Devices
  module OilHeater
    def self.remote_control
      APIs::LIRC.new('oil_heater')
    end
  end
end
