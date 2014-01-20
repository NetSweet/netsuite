module NetSuite
  class RecordNotFound < StandardError; end
  class InitializationError < StandardError; end
  class ConfigurationError < StandardError; end

  class Error
    attr_accessor :type, :code, :message

    def initialize(args = {})
      @type    = args[:@type]
      @code    = args[:code]
      @message = args[:message]
    end
  end
end
