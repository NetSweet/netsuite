module NetSuite
  class Response
    attr_accessor :header, :body, :errors

    def initialize(attributes = {})
      @success  = attributes[:success]
      @header   = attributes[:header]
      @body     = attributes[:body]
      @errors   = attributes[:errors] || []

      raise_on_response_errors
    end

    def success!
      @success = true
    end

    def success?
      @success
    end

    private

    def status_detail
      @body &&
        @body.is_a?(Hash) &&
        @body[:status] &&
        @body[:status][:status_detail]
    end

    def response_error_code
      if success?
        nil
      else
        status_detail &&
          status_detail[:code]
      end
    end

    def raise_on_response_errors
      case response_error_code
      when 'INSUFFICIENT_PERMISSION'
        raise NetSuite::PermissionError, status_detail[:message]
      end
    end
  end
end
