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
        raise NotImplementedError
      end

      def connection
        Configuration.connection
      end

      def auth_header
        Configuration.auth_header
      end

      def build_response
        Response.new(:success => success?, :body => response_body)
      end

      def success?
        raise NotImplementedError
      end

      def response_body
        raise NotImplementedError
      end

    end
  end
end
