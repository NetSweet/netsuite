module NetSuite
  module Support
    module Requests

      def self.included(base)
        base.send(:extend, ClassMethods)
      end

      module ClassMethods

        def call(options, credentials={})
          raise ArgumentError, "options should be an array" unless options.is_a?(Array)
          new(*options).call(credentials)
        end

      end

      def call(credentials={})
        @response = request(credentials)
        build_response
      end

      private

      def build_response
        Response.new(success: success?, header: response_header, body: response_body, errors: response_errors)
      end

      def success?
        raise NotImplementedError, 'Please implement a #success? method'
      end

      # Only care about headers in Search class for now
      def response_header
        nil
      end

      def response_errors
        nil
      end

      def response_body
        raise NotImplementedError, 'Please implement a #response_body method'
      end

      def array_wrap(object)
        if object.is_a?(Array)
          return object
        end

        [ object ]
      end

    end
  end
end
