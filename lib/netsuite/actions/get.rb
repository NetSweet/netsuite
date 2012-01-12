module NetSuite
  module Actions
    class Get
      include Support::Requests

      def initialize(id, klass)
        @id    = id
        @klass = klass
      end

      private

      def request
        connection.request :platformMsgs, :get do
          soap.namespaces['xmlns:platformMsgs'] = 'urn:messages_2011_2.platform.webservices.netsuite.com'
          soap.namespaces['xmlns:platformCore'] = 'urn:core_2011_2.platform.webservices.netsuite.com'
          soap.header = auth_header
          soap.body   = request_body
        end
      end

      def soap_type
        @klass.to_s.split('::').last.lower_camelcase
      end

      # <soap:Body>
      #   <platformMsgs:get>
      #     <platformMsgs:baseRef internalId="983" type="customer" xsi:type="platformCore:RecordRef">
      #       <platformCore:name/>
      #     </platformMsgs:baseRef>
      #   </platformMsgs:get>
      # </soap:Body>
      def request_body
        {
          'platformMsgs:baseRef' => {},
          :attributes! => {
            'platformMsgs:baseRef' => {
              :externalId => @id,
              :type       => soap_type,
              'xsi:type'  => 'platformCore:RecordRef'
            }
          }
        }
      end

      def success?
        @success ||= response_hash[:status][:@is_success] == 'true'
      end

      def response_body
        @response_body ||= response_hash[:record]
      end

      def response_hash
        @response_hash = @response[:get_response][:read_response]
      end

    end
  end
end
