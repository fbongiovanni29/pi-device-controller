module Devices
  class GoogleCast
    def initialize; end
 
    def response
      Cachy.cache(device.to_sym, expires_in: 1.minute) do
        HTTParty.get("http://#{my_ip}:#{config['port']}/device/#{config[device]['id']}")
      end
    end

    def my_ip
      `hostname -I`.strip.split(' ').first
    end

    def device
      self.class.to_s.split('::').last.downcase
    end

    def config
      Devices.config['google_cast']
    end
  end
end
