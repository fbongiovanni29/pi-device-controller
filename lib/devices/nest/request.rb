module Devices
  module Nest
    class Request
      attr_reader :endpoint

      def initialize(endpoint)
        @endpoint = endpoint
      end
      
      def response
        Response.new(endpoint).response
      end
    end
  end
end
