module APIs
  module ARP
    class << self
    def phone_connected?
      Cachy.expire(:are_you_home) if are_you_home? # Fresh

      Cachy.cache_if(are_you_home?, :are_you_home, expires_in: 20.minutes) do
        are_you_home?
      end
    end 

     def are_you_home?
        `sudo arp-scan --localnet|grep -E '#{mac_addresses}'`.present?
     end

    def mac_addresses
      CONFIG["api"]["arp"]["home_mac_addresses"].join("|")
    end
    end
  end
end
