module Mirror
  class << self
  def control!
    device = Devices::Mirror.new
 
    loop do
      device.power(Home.present?)
      sleep 10
      device.set_brightness(brightness_level) if Home.present?
    end
  end
  
  def brightness_level
    time = Time.current.utc.strftime('%H%M').to_i

    brightness_levels.each_cons(2) do |levels|
      return levels.first['level'] if time.between?(*levels.map { |level| level['after'] })
    end
    
    return brightness_levels.last['level']
  end

  def brightness_levels
    Devices.config['magic_mirror']['brightness_levels'].sort_by { |level| level[:after] }
  end
  end
end
