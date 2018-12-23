gems = ['httparty', 'yaml', 'pry', 'active_support', 'active_support/all', 'open_weather', 'log_formatter', 'log_formatter/ruby_json_formatter']

(Dir["#{APP_PATH}/lib/**/*.rb"] + Dir["#{APP_PATH}/app/**/*.rb"] + gems).each{ |file| require file }
