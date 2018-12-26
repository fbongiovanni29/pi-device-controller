module Weather
  def self.response
    Cachy.cache(:weather, expires_in: 10.minutes) do
      OpenWeather::Current.geocode(
        *CONFIG['api']['open_weather']['coordinates'],
        CONFIG['api']['open_weather']['options']
      )
    end
  end
end
