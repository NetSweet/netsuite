module NetSuite
  class RecordNotFound < StandardError; end
  class InitializationError < StandardError; end
  class ConfigurationError < StandardError; end
  class PermissionError < StandardError; end

  # NOTE not an exception, used as a wrapped around NetSuite SOAP error
  class Error
    attr_accessor :type, :code, :message

    def initialize(args = {})
      @type    = args[:@type]
      @code    = args[:code]
      @message = args[:message]
    end

    alias_method :to_s, :inspect
  end
end
