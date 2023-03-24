# https://system.netsuite.com/help/helpcenter/en_US/Output/Help/SuiteCloudCustomizationScriptingWebServices/SuiteTalkWebServices/upsert.html
require_relative 'abstract_action'

module NetSuite
  module Actions
    class Upsert < AbstractAction
      include Support::Requests

      attr_reader :response_hash

      def initialize(object = nil)
        @object = object
      end

      private

      # <soap:Body>
      #   <platformMsgs:upsert>
      #     <platformMsgs:record xsi:type="listRel:Customer">
      #       <listRel:entityId>Shutter Fly</listRel:entityId>
      #       <listRel:companyName>Shutter Fly, Inc</listRel:companyName>
      #     </platformMsgs:record>
      #   </platformMsgs:upsert>
      # </soap:Body>

      def request_body
        hash = {
          'platformMsgs:record' => {
            :content! => @object.to_record,
            '@xsi:type' => @object.record_type
          }
        }

        if @object.respond_to?(:external_id) && @object.external_id
          hash['platformMsgs:record']['@platformMsgs:externalId'] = @object.external_id
        end

        # setting the internal ID on upsert will result in `CANT_SET_INTERNALID`

        hash
      end

      def success?
        @success ||= response_hash[:status][:@is_success] == 'true'
      end

      def response_body
        @response_body ||= response_hash[:base_ref]
      end

      def response_errors
        if response_hash[:status] && response_hash[:status][:status_detail]
          @response_errors ||= errors
        end
      end

      def response_hash
        @response_hash ||= @response.to_hash[:upsert_response][:write_response]
      end

      def errors
        error_obj = response_hash[:status][:status_detail]
        error_obj = [error_obj] if error_obj.class == Hash
        error_obj.map do |error|
          NetSuite::Error.new(error)
        end
      end

      def request_options
        {}
      end

      def action_name
        :upsert
      end

      module Support
        def upsert(credentials={})
          response = NetSuite::Actions::Upsert.call([self], credentials)

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
