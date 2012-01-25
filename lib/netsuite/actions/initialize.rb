module NetSuite
  module Actions
    class Initialize
      include Support::Requests

      def initialize(klass, object)
        @klass  = klass
        @object = object
      end

      def request
        connection.request :platformMsgs, :initialize do
          soap.namespaces['xmlns:platformMsgs']    = 'urn:messages_2011_2.platform.webservices.netsuite.com'
          soap.namespaces['xmlns:platformCore']    = 'urn:core_2011_2.platform.webservices.netsuite.com'
          soap.namespaces['xmlns:platformCoreTyp'] = 'urn:types.core_2011_2.platform.webservices.netsuite.com'
          soap.header = auth_header
          soap.body   = request_body
        end
      end

      # <platformMsgs:initializeRecord>
      #   <platformCore:type>invoice</platformCore:type>
      #   <platformCore:reference internalId="1513" type="salesOrder">
      #     <platformCore:name>1511</platformCore:name>
      #   </platformCore:reference>
      # </platformMsgs:initializeRecord>
      def request_body
        {
          'platformMsgs:initializeRecord' => {
            'platformCore:type'      => @klass.to_s.split('::').last.lower_camelcase,
            'platformCore:reference' => {},
            :attributes!             => {
              'platformCore:reference' => {
                'internalId' => @object.internal_id,
                :type        => @object.class.to_s.split('::').last.lower_camelcase
              }
            }
          }
        }
      end

      def response_hash
        @response_hash ||= @response.to_hash[:initialize_response][:read_response]
      end

      def success?
        @success ||= response_hash[:status][:@is_success] == 'true'
      end

      def response_body
        @response_body ||= response_hash[:record]
      end

      module Support
        def initialize(object)
          response = NetSuite::Actions::Initialize.call(self, object)
          if response.success?
            new(response.body)
          else
            raise InitializationError, "#{self}.initialize with #{object} failed."
          end
        end
      end

    end
  end
end
