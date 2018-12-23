module Devices
  module Nest
    class Response
      attr_reader :endpoint

      def initialize(endpoint)
        @endpoint = endpoint
      end

      def response
        "#{self.class}::#{endpoint.camelize}".constantize.new(Nest.call(endpoint))
      end
    end
  end
end
