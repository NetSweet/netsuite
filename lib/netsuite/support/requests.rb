module NetSuite
  module Support
    module Requests

      def self.included(base)
        base.send(:extend, ClassMethods)
      end

      module ClassMethods

        def call(*args)
          new(*args).call
        end

      end

      def call
        @response = request
        build_response
      end

      private

      def request
        raise NotImplementedError, 'Please implement a #request method'
      end

      def build_response
        Response.new(success: success?, header: response_header, body: response_body, error: response_error)
      end

      def success?
        raise NotImplementedError, 'Please implement a #success? method'
      end

      # Only care about headers in Search class for now
      def response_header
        nil
      end

      def response_error
        nil
      end

      def response_body
        raise NotImplementedError, 'Please implement a #response_body method'
      end

    end
  end
end
