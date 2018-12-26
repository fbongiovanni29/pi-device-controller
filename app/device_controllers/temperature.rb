class Temperature
  class << self
  def control!
    heaters = Devices::Heaters.all
    time_since_reset = 0.seconds
    heaters.each(&:calibrate!)

    loop do
      heaters.each(&:control!) 
      sleep (heaters.any?(&:power_status) ? 10 : 2).minutes

      if last_reset > Time.current.hour
        heaters.each(&:reset_power!) 
        last_reset =  Time.current.hour
      end
    end
  end
  end
end
