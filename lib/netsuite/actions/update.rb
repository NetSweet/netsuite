module NetSuite
  module Actions
    class Update
      include Support::Requests

      def initialize(klass, attributes)
        @klass      = klass
        @attributes = attributes
      end

      def request
        api_version = NetSuite::Configuration.api_version
        
        NetSuite::Configuration.connection(
          namespaces: {
            'xmlns:platformMsgs'   => "urn:messages_#{api_version}.platform.webservices.netsuite.com",
            'xmlns:platformCore'   => "urn:core_#{api_version}.platform.webservices.netsuite.com",
            'xmlns:listRel'        => "urn:relationships_#{api_version}.lists.webservices.netsuite.com",
            'xmlns:tranSales'      => "urn:sales_#{api_version}.transactions.webservices.netsuite.com",
            'xmlns:platformCommon' => "urn:common_#{api_version}.platform.webservices.netsuite.com",
            'xmlns:listAcct'       => "urn:accounting_#{api_version}.lists.webservices.netsuite.com",
            'xmlns:actSched'       => "urn:scheduling_#{api_version}.activities.webservices.netsuite.com",
            'xmlns:tranCust'       => "urn:customers_#{api_version}.transactions.webservices.netsuite.com",
            'xmlns:setupCustom'    => "urn:customization_#{api_version}.setup.webservices.netsuite.com",
          },
        ).call :update, :message => request_body
      end

      # <platformMsgs:update>
      #   <platformMsgs:record internalId="980" xsi:type="listRel:Customer">
      #     <listRel:companyName>Shutter Fly Corporation</listRel:companyName>
      #   </platformMsgs:record>
      # </platformMsgs:update>
      def request_body
        hash = {
          'platformMsgs:record' => {
            :content! => updated_record.to_record,
            '@xsi:type' => updated_record.record_type
          }
        }

        if updated_record.respond_to?(:internal_id) && updated_record.internal_id
          hash['platformMsgs:record']['@platformMsgs:internalId'] = updated_record.internal_id
        end

        if updated_record.respond_to?(:external_id) && updated_record.external_id
          hash['platformMsgs:record']['@platformMsgs:externalId'] = updated_record.external_id
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
