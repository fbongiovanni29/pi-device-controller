class Weather
  attr_reader :response

  def initialize
    @time ||= Time.current
    bust_cache if Time.current - 15.minutes > @time 
    @response ||= response
  end

  def bust_cache
    @response = nil
    @time = nil
  end

  def response
    OpenWeather::Current.geocode(
      *CONFIG['api']['open_weather']['coordinates'],
      CONFIG['api']['open_weather']['options']
    )
  end
end
