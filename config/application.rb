require 'yaml'
require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)

require 'active_support/all'
require 'open_weather'

(Dir["#{APP_PATH}/lib/**/*.rb"] + Dir["#{APP_PATH}/app/**/*.rb"]).each{ |file| require file }
