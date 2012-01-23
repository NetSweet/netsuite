module NetSuite
  module Actions
    class Delete
      include Support::Requests

      def initialize(object = nil)
        @object = object
      end

      private

      def request
        connection.request :platformMsgs, :delete do
          soap.namespaces['xmlns:platformMsgs'] = 'urn:messages_2011_2.platform.webservices.netsuite.com'
          soap.namespaces['xmlns:platformCore'] = 'urn:core_2011_2.platform.webservices.netsuite.com'
          soap.header = auth_header
          soap.body   = request_body
        end
      end

      # <soap:Body>
      #   <platformMsgs:delete>
      #     <platformMsgs:baseRef internalId="980" type="customer" xsi:type="platformCore:RecordRef"/>
      #   </platformMsgs:delete>
      # </soap:Body>
      def request_body
        {
          'platformMsgs:baseRef' => {},
          :attributes! => {
            'platformMsgs:baseRef' => {
              'internalId' => @object.internal_id,
              'type'       => @object.class.to_s.split('::').last.lower_camelcase,
              'xsi:type'   => 'platformCore:RecordRef'
            }
          }
        }
      end

      def response_hash
        @response_hash ||= @response.to_hash[:delete_response][:write_response]
      end

      def success?
        @success ||= response_hash[:status][:@is_success] == 'true'
      end

      def response_body
        @response_body ||= response_hash[:base_ref]
      end

    end
  end
end
