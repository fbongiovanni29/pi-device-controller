APP_PATH = '/home/pi/device_controller'
require "#{APP_PATH}/config/application.rb" 
CONFIG = YAML.load_file("#{APP_PATH}/config/config.yml")
CONFIG.deep_merge!(YAML.load_file("#{APP_PATH}/config/secrets.yml"))
binding.pry if ARGV.first == 'debug'

log = false

if log
  LOGR = Logger.new('./log/heater_log.json')
  LOGR.level = Logger::INFO

  LOGR.formatter = Ruby::JSONFormatter::Base.new
end

Temperature.control!
