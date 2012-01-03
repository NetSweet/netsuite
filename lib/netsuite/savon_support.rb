module NetSuite
  module Actions
    module SavonSupport

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
        NetSuite::Configuration.connection
      end

      def auth_header
        NetSuite::Configuration.auth_header
      end

      def build_response
        NetSuite::Response.new(:success => success?, :body => response_body)
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
