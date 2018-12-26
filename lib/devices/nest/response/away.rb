module Devices
  module Nest
    class Response
      class Away
        attr_reader :response

        def initialize(response)
          @response = response
        end 

        def body
          Cachy.cache(:nest_away, expires_in: 2.minutes) { response }
        end

        def home?
          body['away'] == 'home'
        end
      end
    end
  end
end
