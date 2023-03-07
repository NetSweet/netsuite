# https://system.netsuite.com/help/helpcenter/en_US/Output/Help/SuiteCloudCustomizationScriptingWebServices/SuiteTalkWebServices/asyncAddList.html
module NetSuite
  module Actions
    class AsyncAddList
      include Support::Requests

      def initialize(*objects)
        @objects = objects
      end

      private

      def request(credentials={})
        NetSuite::Configuration.connection(
          {}, credentials
        ).call(:async_add_list, message: request_body)
      end

      # <soap:Body>
      #   <platformMsgs:asyncAddList>
      #     <platformMsgs:record xsi:type="listRel:Customer">
      #       <listRel:entityId>Shutter Fly</listRel:entityId>
      #       <listRel:companyName>Shutter Fly, Inc</listRel:companyName>
      #     </platformMsgs:record>
      #     <platformMsgs:record xsi:type="listRel:Customer">
      #       <listRel:entityId>Target</listRel:entityId>
      #       <listRel:companyName>Target</listRel:companyName>
      #     </platformMsgs:record>
      #   </platformMsgs:asyncAddList>
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
        binding.pry
        @response_hash ||= Array[@response.body[:async_add_list_response][:async_status_result]]
      end

      def response_body
        @response_body ||= response_hash.map { |h| h[:job_id] }
      end

      def response_errors
        binding.pry
        if response_hash[0].any? { |h| h[:status] && h[:status][:status_detail] }
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

          [obj[:base_ref][:@external_id], errors]
        end
        Hash[errors]
      end

      def success?
        #binding.pry
        response_hash[0][:job_id]
      end

      module Support

        def self.included(base)
          base.extend(ClassMethods)
        end

        module ClassMethods
          def async_add_list(records, credentials = {})
            netsuite_records = records.map do |r|
              if r.kind_of?(self)
                r
              else
                self.new(r)
              end
            end

            response = NetSuite::Actions::AsyncAddList.call(netsuite_records, credentials)

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
