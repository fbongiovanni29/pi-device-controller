module Home
  class << self
  def present?
    APIs::ARP.phone_connected? || chromecast.playing? || nest.home?
  end

  def bedtime?
    Time.current.between?(
       Time.current.midnight,
       Time.current.midnight + 8.hours
    ) || !APIs::ARP.phone_connected? || !chromecast.playing?
  end

  def chromecast
    Devices::GoogleCast::Chromecast.new
  end

  def nest
    Devices::Nest::Response.new('away').response
  end
  end
end
