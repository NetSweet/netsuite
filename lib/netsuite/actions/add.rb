module NetSuite
  module Actions
    class Add
      include Support::Requests

      def initialize(obj = nil)
        @obj = obj
      end

      private

      def request
        connection.request :platformMsgs, :add do
          soap.namespaces['xmlns:platformMsgs']   = 'urn:messages_2011_2.platform.webservices.netsuite.com'
          soap.namespaces['xmlns:platformCore']   = 'urn:core_2011_2.platform.webservices.netsuite.com'
          soap.namespaces['xmlns:listRel']        = 'urn:relationships_2011_2.lists.webservices.netsuite.com'
          soap.namespaces['xmlns:tranSales']      = 'urn:sales_2011_2.transactions.webservices.netsuite.com'
          soap.namespaces['xmlns:platformCommon'] = 'urn:common_2011_2.platform.webservices.netsuite.com'
          soap.namespaces['xmlns:listAcct']       = 'urn:accounting_2011_2.lists.webservices.netsuite.com'
          soap.namespaces['xmlns:tranCust']       = 'urn:customers_2011_2.transactions.webservices.netsuite.com'
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
        hash = {
          'platformMsgs:record' => @obj.to_record,
          :attributes! => {
            'platformMsgs:record' => {
              'xsi:type' => @obj.record_type
            }
          }
        }
        if @obj.respond_to?(:internal_id) && @obj.internal_id
          hash[:attributes!]['platformMsgs:record']['platformMsgs:internalId'] = @obj.internal_id
        end
        if @obj.respond_to?(:external_id) && @obj.external_id
          hash[:attributes!]['platformMsgs:record']['platformMsgs:externalId'] = @obj.external_id
        end
        hash
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
