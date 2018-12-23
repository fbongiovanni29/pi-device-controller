module Devices
  module Nest
    module Gateway
      def self.call(endpoint)
        HTTParty.get(
          Nest.config['endpoint'][endpoint],
          headers: Nest.config['headers']
         )
      end
    end
  end
end
