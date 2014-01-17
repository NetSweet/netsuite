module NetSuite
  class Response
    attr_accessor :header, :body, :error

    def initialize(attributes = {})
      @success = attributes[:success]
      @header  = attributes[:header]
      @body    = attributes[:body]
      @error   = attributes[:error]
    end

    def success!
      @success = true
    end

    def success?
      @success
    end

  end
end
