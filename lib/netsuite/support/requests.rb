module NetSuite
  module Support
    module Requests

      def self.included(base)
        base.send(:extend, ClassMethods)
      end

      module ClassMethods

        def call(options, configuration = nil)
          raise ArgumentError, "options should be an array" unless options.is_a?(Array)
          # TODO detect invalid configuration type
          new(*options).call(configuration)
        end

      end

      def call(configuration = nil)
        @response = request(configuration)
        build_response
      end

      private

      def request
        raise NotImplementedError, 'Please implement a #request method'
      end

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

      # TODO DRY this up -- pretty sure this pattern is used elsewhere in the codebase
      def array_wrap(object)
        if object.is_a?(Array)
          return object
        end

        [ object ]
      end

    end
  end
end
