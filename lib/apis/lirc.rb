module APIs
  class LIRC
    attr_reader :device

    def initialize(device)
      @device = device
    end

    def send_once(key_press)
      `irsend SEND_ONCE #{device} #{Devices.config[device]['keys'][key_press]}`
    end

    def method_missing(meth, *args, &block)
      options = args.first.to_h
      options[:times] = options[:times] || 1
      options[:delay] = options[:delay] || 0.15

      options[:times].times do
        send_once(meth.to_s.sub('click_', ''))
        sleep(options[:delay])
      end
    end
  end
end
