module NetSuite
  module Actions
    class Add
      include Support::Requests

      def initialize(object = nil)
        @object = object
      end

      private

      def request
        NetSuite::Configuration.connection(
          namespaces: {
            'xmlns:platformMsgs'   => "urn:core_#{NetSuite::Configuration.api_version}.platform.webservices.netsuite.com",
            'xmlns:platformCore'   => "urn:core_#{NetSuite::Configuration.api_version}.platform.webservices.netsuite.com",
            'xmlns:listRel'        => "urn:relationships_#{NetSuite::Configuration.api_version}.lists.webservices.netsuite.com",
            'xmlns:tranSales'      => "urn:sales_#{NetSuite::Configuration.api_version}.transactions.webservices.netsuite.com",
            'xmlns:platformCommon' => "urn:common_#{NetSuite::Configuration.api_version}.platform.webservices.netsuite.com",
            'xmlns:listAcct'       => "urn:accounting_#{NetSuite::Configuration.api_version}.lists.webservices.netsuite.com",
            'xmlns:actSched'       => "urn:scheduling_#{NetSuite::Configuration.api_version}.activities.webservices.netsuite.com",
            'xmlns:tranCust'       => "urn:customers_#{NetSuite::Configuration.api_version}.transactions.webservices.netsuite.com",
            'xmlns:setupCustom'    => "urn:customization_#{NetSuite::Configuration.api_version}.setup.webservices.netsuite.com",
            'xmlns:tranGeneral'    => "urn:general_#{NetSuite::Configuration.api_version}.transactions.webservices.netsuite.com",
            'xmlns:listSupport'    => "urn:support_#{NetSuite::Configuration.api_version}.lists.webservices.netsuite.com",
          },
        ).call :add, :message => request_body
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

          if response.success?
            @internal_id = response.body[:@internal_id]
            true
          else
            false
          end
        end
      end

    end
  end
end
