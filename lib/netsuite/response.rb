module NetSuite
  class Response
    attr_accessor :header, :body, :errors

    def initialize(attributes = {})
      @success  = attributes[:success]
      @header   = attributes[:header]
      @body     = attributes[:body]
      @errors   = attributes[:errors] || []

      validate_response
    end

    def success!
      @success = true
    end

    def success?
      @success
    end

    def validate_response
      raise NetSuite::InvalidResponseError unless @body.is_a?(Hash)
    end
  end
end
