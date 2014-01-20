module NetSuite
  class Response
    attr_accessor :header, :body, :errors

    def initialize(attributes = {})
      @success  = attributes[:success]
      @header   = attributes[:header]
      @body     = attributes[:body]
      @errors   = attributes[:errors]
    end

    def success!
      @success = true
    end

    def success?
      @success
    end

  end
end
