class Temperature
  class << self
  def control!
    heaters = Devices::Heaters.all
    time_since_reset = 0.seconds
    heaters.each(&:calibrate!)

    loop do
      bm = Benchmark.measure do
        heaters.each(&:control!) 
        sleep (heaters.any?(&:power_status) ? 1 : 1).minutes
      end

      time_since_reset = bm.real.seconds + time_since_reset
      if time_since_reset > 1.hours
        heaters.each(&:reset_power!) 
        time_since_reset = 0.minutes
      end
    end
  end

  def current_outdoor_temperature
    weather_response['temp']
  end

  def weather_response
    OpenWeather::Current.geocode(*CONFIG['api']['open_weather']['coordinates'], CONFIG['api']['open_weather']['options'])['main']
  end
  end
end
