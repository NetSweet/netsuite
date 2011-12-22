module NetSuite
  class Response
    attr_accessor :body

    def initialize(attributes = {})
      @success = attributes[:success]
      @body    = attributes[:body]
    end

    def success!
      @success = true
    end

    def success?
      @success
    end

  end
end
