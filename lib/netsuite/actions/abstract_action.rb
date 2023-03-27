module NetSuite
  module Actions
    class AbstractAction
      def request(credentials={})
        NetSuite::Configuration.connection(request_options, credentials, soap_header_extra_info).call(action_name, message: request_body)
      end

      protected

      def action_name
        raise NotImplementedError, 'Not implemented on abstract class'
      end

      def initialize
        raise NotImplementedError, 'Not implemented on abstract class'
      end

      def request_body
        raise NotImplementedError, 'Not implemented on abstract class'
      end

      def request_options
        {}
      end

      def soap_header_extra_info
        {}
      end
    end
  end
end
  