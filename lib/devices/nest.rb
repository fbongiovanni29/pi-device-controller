module Devices
  module Nest
    def self.call(endpoint)
      Gateway.call(endpoint)
    end

    def self.config
      Devices.config['nest']
    end
  end
end
