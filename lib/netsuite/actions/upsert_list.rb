# https://system.netsuite.com/help/helpcenter/en_US/Output/Help/SuiteCloudCustomizationScriptingWebServices/SuiteTalkWebServices/upsertList.html
module NetSuite
  module Actions
    class UpsertList
      include Support::Requests

      def initialize(*objects)
        @objects = objects
      end

      private

      def request(credentials={})
        NetSuite::Configuration.connection(
          { element_form_default: :unqualified }, credentials
        ).call(:upsert_list, message: request_body)
      end

      # <soap:Body>
      #   <upsertList>
      #     <record xsi:type="listRel:Customer" externalId="ext1">
      #       <listRel:entityId>Shutter Fly</listRel:entityId>
      #       <listRel:companyName>Shutter Fly, Inc</listRel:companyName>
      #     </record>
      #     <record xsi:type="listRel:Customer" externalId="ext2">
      #       <listRel:entityId>Target</listRel:entityId>
      #       <listRel:companyName>Target</listRel:companyName>
      #     </record>
      #   </upsertList>
      # </soap:Body>
      def request_body
        @objects.map do |o|
          hash = {
            'record' => {
              :content! => o.to_record,
              '@xsi:type' => o.record_type
            }
          }

          if o.respond_to?(:external_id) && o.external_id
            hash['record']['@externalId'] = o.external_id
          end

          hash
        end
      end

      def response_hash
        @response_hash ||= Array[@response.body[:upsert_list_response][:write_response_list][:write_response]].flatten
      end

      def response_body
        @response_body ||= response_hash.map { |h| h[:base_ref] }
      end

      def success?
        @success ||= response_hash.all? { |h| h[:status][:@is_success] == 'true' }
      end

      module Support

        def self.included(base)
          base.extend(ClassMethods)
        end

        module ClassMethods
          def upsert_list(records, credentials = {})
            netsuite_records = records.map do |r|
              if r.kind_of?(self)
                r
              else
                self.new(r)
              end
            end

            response = NetSuite::Actions::UpsertList.call(netsuite_records, credentials)

            if response.success?
              response.body.map do |attr|
                record = netsuite_records.find do |r|
                  r.external_id == attr[:@external_id]
                end

                record.instance_variable_set('@internal_id', attr[:@internal_id])
              end

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
