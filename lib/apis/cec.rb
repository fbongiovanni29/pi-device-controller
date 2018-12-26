module APIs
  class CEC
    attr_reader :device

    def initialize(device)
      @device = device
    end

    def method_missing(meth)
      `echo '#{Devices.config[device]['cec_controls'][meth.to_s]}' | cec-client -s RPI`
    end
  end
end
