# https://system.netsuite.com/help/helpcenter/en_US/Output/Help/SuiteCloudCustomizationScriptingWebServices/SuiteTalkWebServices/updateList.html
module NetSuite
  module Actions
    class UpdateList
      include Support::Requests

      def initialize(*objects)
        @objects = objects
      end

      private

      def request(credentials={})
        NetSuite::Configuration.connection(
          { element_form_default: :unqualified }, credentials
        ).call(:update_list, message: request_body)
      end

      # <soap:Body>
      #   <updateList>
      #     <record xsi:type="listRel:Customer" externalId="ext1">
      #       <listRel:entityId>Shutter Fly</listRel:entityId>
      #       <listRel:companyName>Shutter Fly, Inc</listRel:companyName>
      #     </record>
      #     <record xsi:type="listRel:Customer" externalId="ext2">
      #       <listRel:entityId>Target</listRel:entityId>
      #       <listRel:companyName>Target</listRel:companyName>
      #     </record>
      #   </updateList>
      # </soap:Body>
      def request_body
        attrs = @objects.map do |o|
          hash = o.to_record.merge({
            '@xsi:type' => o.record_type
          })

          if o.respond_to?(:internal_id) && o.internal_id
            hash['@internalId'] = o.internal_id
          end

          if o.respond_to?(:external_id) && o.external_id
            hash['@externalId'] = o.external_id
          end

          hash
        end

        { 'record' => attrs }
      end

      def response_hash
        @response_hash ||= Array[@response.body[:update_list_response][:write_response_list][:write_response]].flatten
      end

      def response_body
        @response_body ||= response_hash.map { |h| h[:base_ref] }
      end

      def response_errors
        if response_hash.any? { |h| h[:status] && h[:status][:status_detail] }
          @response_errors ||= errors
        end
      end

      def errors
        errors = response_hash.select { |h| h[:status] && h[:status][:status_detail] }.map do |obj|
          error_obj = obj[:status][:status_detail]
          error_obj = [error_obj] if error_obj.class == Hash
          errors = error_obj.map do |error|
            NetSuite::Error.new(error)
          end

          [obj[:base_ref][:@internal_id], errors]
        end
        Hash[errors]
      end

      def success?
        @success ||= response_hash.all? { |h| h[:status][:@is_success] == 'true' }
      end

      module Support

        def self.included(base)
          base.extend(ClassMethods)
        end

        module ClassMethods
          def update_list(records, credentials = {})
            netsuite_records = records.map do |r|
              if r.kind_of?(self)
                r
              else
                self.new(r)
              end
            end
            response = NetSuite::Actions::UpdateList.call(netsuite_records, credentials)

            if response.success?
              netsuite_records
            else
              false
            end
          end
        end
      end
    end
  end
end
