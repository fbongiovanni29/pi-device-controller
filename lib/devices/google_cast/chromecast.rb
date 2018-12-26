module Devices
  class GoogleCast
    class Chromecast < GoogleCast
      def playing?
        response['status']['status'] == 'PLAYING'
      end
    end
  end
end
