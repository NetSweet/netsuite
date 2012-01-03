module NetSuite
  module Actions
    class Add
      include SavonSupport

      def initialize(attributes = {})
        @attributes = attributes
      end

      private

      def request
        connection.request :platformMsgs, :add do
          soap.namespaces['xmlns:platformMsgs'] = 'urn:messages_2011_2.platform.webservices.netsuite.com'
          soap.namespaces['xmlns:platformCore'] = 'urn:core_2011_2.platform.webservices.netsuite.com'
          soap.namespaces['xmlns:listRel']      = 'urn:relationships_2011_2.lists.webservices.netsuite.com'
          soap.header = auth_header
          soap.body   = request_body
        end
      end

      # <soap:Body>
      #   <platformMsgs:add>
      #     <platformMsgs:record xsi:type="listRel:Customer">
      #       <listRel:entityId>Shutter Fly</listRel:entityId>
      #       <listRel:companyName>Shutter Fly, Inc</listRel:companyName>
      #     </platformMsgs:record>
      #   </platformMsgs:add>
      # </soap:Body>
      def request_body
        {
          'platformMsgs:record' => {
            'listRel:entityId'    => @attributes[:entity_id],
            'listRel:companyName' => @attributes[:company_name]
          },
          :attributes! => {
            'platformMsgs:record' => {
              'xsi:type' => 'listRel:Customer'
            }
          }
        }
      end

      def success?
        @success ||= response_hash[:status][:@is_success] == 'true'
      end

      def response_body
        @response_body ||= response_hash[:base_ref]
      end

      def response_hash
        @response_hash ||= @response.to_hash[:add_response][:write_response]
      end

    end
  end
end
