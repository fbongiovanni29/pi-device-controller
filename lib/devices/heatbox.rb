module Devices
  module Heatbox
    def self.remote_control
      APIs::LIRC.new('heatbox')
    end
  end
end
