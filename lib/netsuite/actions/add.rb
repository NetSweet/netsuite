# https://system.netsuite.com/help/helpcenter/en_US/Output/Help/SuiteCloudCustomizationScriptingWebServices/SuiteTalkWebServices/add.html
module NetSuite
  module Actions
    class Add
      include Support::Requests

      attr_reader :response_hash

      def initialize(object = nil)
        @object = object
      end

      private

      def request(credentials={})
        NetSuite::Configuration.connection({}, credentials).call(:add, :message => request_body)
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
          'platformMsgs:record' => {
            :content! => @object.to_record,
            '@xsi:type' => @object.record_type
          }
        }

        if @object.respond_to?(:internal_id) && @object.internal_id
          hash['platformMsgs:record']['@platformMsgs:internalId'] = @object.internal_id
        end

        if @object.respond_to?(:external_id) && @object.external_id
          hash['platformMsgs:record']['@platformMsgs:externalId'] = @object.external_id
        end

        hash
      end

      def success?
        @success ||= response_hash[:status][:@is_success] == 'true'
      end

      def response_body
        @response_body ||= if response_hash[:base_ref].is_a?(Nori::StringIOFile)
          { :@internal_id => Nokogiri::XML(@response.to_s).remove_namespaces!.at_xpath('//baseRef')[:internalId] }
        else
          response_hash[:base_ref]
        end
      end

      def response_errors
        if response_hash[:status] && response_hash[:status][:status_detail]
          @response_errors ||= errors
        end
      end

      def response_hash
        @response_hash ||= @response.to_hash[:add_response][:write_response]
      end

      def errors
        error_obj = response_hash[:status][:status_detail]
        error_obj = [error_obj] if error_obj.class == Hash
        error_obj.map do |error|
          next if error.keys == [:after_submit_failed]
          NetSuite::Error.new(error)
        end.compact
      end

      module Support
        def add(credentials={})
          response = NetSuite::Actions::Add.call([self], credentials)

          @errors = response.errors

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
