# https://system.netsuite.com/help/helpcenter/en_US/Output/Help/SuiteCloudCustomizationScriptingWebServices/SuiteTalkWebServices/get.html
require_relative 'abstract_action'

module NetSuite
  module Actions
    class Get < AbstractAction
      include Support::Requests

      def initialize(klass, options = {})
        @klass   = klass
        @options = options
      end

      private

      def soap_type
        NetSuite::Support::Records.netsuite_type(@klass)
      end

      # <soap:Body>
      #   <platformMsgs:get>
      #     <platformMsgs:baseRef internalId="983" type="customer" xsi:type="platformCore:RecordRef">
      #       <platformCore:name/>
      #     </platformMsgs:baseRef>
      #   </platformMsgs:get>
      # </soap:Body>
      def request_body
        body = {
          'platformMsgs:baseRef' => {
            '@xsi:type'  => (@options[:custom] ? 'platformCore:CustomRecordRef' : 'platformCore:RecordRef')
          }
        }
        body['platformMsgs:baseRef']['@externalId'] = @options[:external_id] if @options[:external_id]
        body['platformMsgs:baseRef']['@internalId'] = @options[:internal_id] if @options[:internal_id]
        body['platformMsgs:baseRef']['@typeId']     = @options[:type_id]     if @options[:type_id]
        body['platformMsgs:baseRef']['@type']       = soap_type              unless @options[:custom]
        body
      end

      def success?
        @success ||= response_hash[:status][:@is_success] == 'true'
      end

      def response_body
        @response_body ||= response_hash[:record]
      end

      def response_hash
        @response_hash = @response.body[:get_response][:read_response]
      end

      def request_options_hash
        # delete this??
        {namespaces: {
          'xmlns:platformMsgs' => "urn:messages_#{NetSuite::Configuration.api_version}.platform.webservices.netsuite.com",
          'xmlns:platformCore' => "urn:core_#{NetSuite::Configuration.api_version}.platform.webservices.netsuite.com"
        }}
      end

      def action_name
        :get
      end

      module Support

        def self.included(base)
          base.extend(ClassMethods)
        end

        module ClassMethods

          def get(options = {}, credentials = {})
            options = { :internal_id => options } unless options.is_a?(Hash)

            response = NetSuite::Actions::Get.call([self, options], credentials)
            if response.success?
             new(response.body)
            else
             raise RecordNotFound, "#{self} with OPTIONS=#{options.inspect} could not be found"
            end
          end

        end
      end

    end
  end
end
