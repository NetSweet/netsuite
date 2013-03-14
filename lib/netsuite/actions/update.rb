module NetSuite
  module Actions
    class Update
      include Support::Requests

      def initialize(klass, attributes)
        @klass      = klass
        @attributes = attributes
      end

      def request
        connection.request :platformMsgs, :update do
          soap.namespaces['xmlns:platformMsgs']   = "urn:messages_#{NetSuite::Configuration.api_version}.platform.webservices.netsuite.com"
          soap.namespaces['xmlns:platformCore']   = "urn:core_#{NetSuite::Configuration.api_version}.platform.webservices.netsuite.com"
          soap.namespaces['xmlns:listRel']        = "urn:relationships_#{NetSuite::Configuration.api_version}.lists.webservices.netsuite.com"
          soap.namespaces['xmlns:tranSales']      = "urn:sales_#{NetSuite::Configuration.api_version}.transactions.webservices.netsuite.com"
          soap.namespaces['xmlns:platformCommon'] = "urn:common_#{NetSuite::Configuration.api_version}.platform.webservices.netsuite.com"
          soap.namespaces['xmlns:listAcct']       = "urn:accounting_#{NetSuite::Configuration.api_version}.lists.webservices.netsuite.com"
          soap.namespaces['xmlns:actSched']       = "urn:scheduling_#{NetSuite::Configuration.api_version}.activities.webservices.netsuite.com"
          soap.namespaces['xmlns:tranCust']       = "urn:customers_#{NetSuite::Configuration.api_version}.transactions.webservices.netsuite.com"
          soap.namespaces['xmlns:setupCustom']    = "urn:customization_#{NetSuite::Configuration.api_version}.setup.webservices.netsuite.com"
          soap.header = auth_header
          soap.body   = request_body
        end
      end

      # <platformMsgs:update>
      #   <platformMsgs:record internalId="980" xsi:type="listRel:Customer">
      #     <listRel:companyName>Shutter Fly Corporation</listRel:companyName>
      #   </platformMsgs:record>
      # </platformMsgs:update>
      def request_body
        hash = {
          'platformMsgs:record' => updated_record.to_record,
          :attributes! => {
            'platformMsgs:record' => {
              'xsi:type' => updated_record.record_type
            }
          }
        }
        if updated_record.respond_to?(:internal_id) && updated_record.internal_id
          hash[:attributes!]['platformMsgs:record']['platformMsgs:internalId'] = updated_record.internal_id
        end
        if updated_record.respond_to?(:external_id) && updated_record.external_id
          hash[:attributes!]['platformMsgs:record']['platformMsgs:externalId'] = updated_record.external_id
        end
        hash
      end

      def updated_record
        @updated_record ||= @klass.new(@attributes)
      end

      def success?
        @success ||= response_hash[:status][:@is_success] == 'true'
      end

      def response_body
        @response_body ||= response_hash[:base_ref]
      end

      def response_hash
        @response_hash ||= @response.to_hash[:update_response][:write_response]
      end

      module Support
        def update(options = {})
          options.merge!(:internal_id => internal_id) if respond_to?(:internal_id) && internal_id
          options.merge!(:external_id => external_id) if respond_to?(:external_id) && external_id
          response = NetSuite::Actions::Update.call(self.class, options)
          response.success?
        end
      end

    end
  end
end
