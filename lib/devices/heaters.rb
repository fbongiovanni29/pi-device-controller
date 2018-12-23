module Devices
  module Heaters
    def self.all
      ['heatbox', 'oil_heater'].map { |heater| Heater.new(heater) }
    end
  end
end
