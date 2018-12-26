APP_PATH = '/home/pi/device_controller'
require "#{APP_PATH}/config/application.rb" 
CONFIG = YAML.load_file("#{APP_PATH}/config/config.yml")
CONFIG.deep_merge!(YAML.load_file("#{APP_PATH}/config/secrets.yml"))

options = { :namespace => "device_controller", :compress => true }
client = Dalli::Client.new('localhost:11211', options)

Cachy.cache_store = client

binding.pry if ARGV.last == 'debug'

ARGV.first.camelize.constantize.control!
