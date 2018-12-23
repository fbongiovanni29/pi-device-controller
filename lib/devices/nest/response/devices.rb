module Devices
  module Nest
    class Response
      class Devices
        attr_reader :response

        def initialize(response)
          @response = response
        end

        def body
          response[response.keys.first]
        end

        def temperature_difference
          current_temperature - target_temperature
        end
        
        def target_temperature
          body['target_temperature_f']
        end
 
        def current_temperature
          body['ambient_temperature_f']
        end
      end
    end
  end
end
