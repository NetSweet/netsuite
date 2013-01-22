module NetSuite
  module Actions
    class Add
      include Support::Requests

      def initialize(object = nil)
        @object = object
      end

      private

      def request
        connection.request :platformMsgs, :add do
          soap.namespaces['xmlns:platformMsgs']   = "urn:messages_#{NetSuite::Configuration.api_version}.platform.webservices.netsuite.com"
          soap.namespaces['xmlns:platformCore']   = "urn:core_#{NetSuite::Configuration.api_version}.platform.webservices.netsuite.com"
          soap.namespaces['xmlns:listRel']        = "urn:relationships_#{NetSuite::Configuration.api_version}.lists.webservices.netsuite.com"
          soap.namespaces['xmlns:tranSales']      = "urn:sales_#{NetSuite::Configuration.api_version}.transactions.webservices.netsuite.com"
          soap.namespaces['xmlns:platformCommon'] = "urn:common_#{NetSuite::Configuration.api_version}.platform.webservices.netsuite.com"
          soap.namespaces['xmlns:listAcct']       = "urn:accounting_#{NetSuite::Configuration.api_version}.lists.webservices.netsuite.com"
          soap.namespaces['xmlns:tranCust']       = "urn:customers_#{NetSuite::Configuration.api_version}.transactions.webservices.netsuite.com"
          soap.namespaces['xmlns:setupCustom']    = "urn:customization_#{NetSuite::Configuration.api_version}.setup.webservices.netsuite.com"
          soap.namespaces['xmlns:tranGeneral']    = "urn:general_#{NetSuite::Configuration.api_version}.transactions.webservices.netsuite.com"
          soap.namespaces['xmlns:tranInvt']       = "urn:inventory_#{NetSuite::Configuration.api_version}.transactions.webservices.netsuite.com"
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
          'platformMsgs:record' => @object.to_record,
          :attributes! => {
            'platformMsgs:record' => {
              'xsi:type' => @object.record_type
            }
          }
        }
        if @object.respond_to?(:internal_id) && @object.internal_id
          hash[:attributes!]['platformMsgs:record']['platformMsgs:internalId'] = @object.internal_id
        end
        if @object.respond_to?(:external_id) && @object.external_id
          hash[:attributes!]['platformMsgs:record']['platformMsgs:externalId'] = @object.external_id
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

      module Support
        def add
          response = NetSuite::Actions::Add.call(self)
          response.success?
        end
      end

    end
  end
end
