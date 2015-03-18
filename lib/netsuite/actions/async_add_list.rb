# https://system.netsuite.com/help/helpcenter/en_US/Output/Help/SuiteCloudCustomizationScriptingWebServices/SuiteTalkWebServices/AsynchronousRequestProcessing.html
module NetSuite
  module Actions
    class AsyncAddList
      include Support::Requests

      def initialize(objects)
        @objects = objects
      end

      private

      def request(credentials={})
        NetSuite::Configuration.connection({element_form_default: :unqualified}, credentials).call(:async_add_list, message: request_body)
      end

      # <soap:Body>
      #   <asyncAddList>
      #     <record xsi:type="listRel:Customer" externalId="ext1">
      #       <listRel:entityId>Shutter Fly</listRel:entityId>
      #       <listRel:companyName>Shutter Fly, Inc</listRel:companyName>
      #     </record>
      #     <record xsi:type="listRel:Customer" externalId="ext2">
      #       <listRel:entityId>Target</listRel:entityId>
      #       <listRel:companyName>Target</listRel:companyName>
      #     </record>
      #   </asyncAddList>
      # </soap:Body>
      def request_body
        attrs = @objects.map do |o|
          hash = o.to_record.merge({
            '@xsi:type' => o.record_type
          })
          if o.respond_to?(:external_id) && o.external_id
            hash['@externalId'] = o.external_id
          end
          hash
        end
        { 'record' => attrs }
      end

      #<soapenv:Body>
      # <asyncAddListResponse xmlns="urn:messages_2_5.platform.webservices.netsuite.com">
      #   <asyncStatusResult xmlns="urn:core_2_5.platform.webservices.netsuite.com">
      #     <jobId>ASYNCWEBSERVICES_563214_053120061943428686160042948_4bee0685</jobId>
      #     <status>pending</status>
      #     <percentCompleted>0.0</percentCompleted>
      #     <estRemainingDuration>0.0</estRemainingDuration>
      #   </asyncStatusResult>
      # </asyncAddListResponse>
      #</soapenv:Body>
      def response_body
        @response_body ||= begin
          response_hash = @response.to_hash
          response_hash[:async_add_list_response] ? response_hash[:async_add_list_response][:async_status_result] : nil
        end
      end

      def success?
        !response_body.nil?
      end

      module Support

        def self.included(base)
          base.extend(ClassMethods)
        end

        module ClassMethods
          def async_add_list(objects = [], credentials = {})
            objects_list = objects.map do |object|
              object.kind_of?(self) ? object : self.new(object)
            end
            response = NetSuite::Actions::AsyncAddList.call([objects_list], credentials)
            response.success? ? NetSuite::Async::Status.new(response.body) : false
          end
        end
      end
    end
  end
end
