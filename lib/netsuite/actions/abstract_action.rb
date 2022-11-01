module NetSuite
  module Actions
    class AbstractAction
      def request(credentials={})
        NetSuite::Configuration.connection(request_options_hash, credentials).call(soap_method, message: request_body)
      end

      protected

      def initialize
        raise NotImplementedError, 'Not implemented on abstract class'
      end

      def request_body
        raise NotImplementedError, 'Not implemented on abstract class'
      end

      def soap_method
        raise NotImplementedError, 'Not implemented on abstract class'
      end

      def request_options_hash
        raise NotImplementedError, 'Not implemented on abstract class'
      end
    end
  end
end
  