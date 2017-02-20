# https://system.netsuite.com/help/helpcenter/en_US/Output/Help/SuiteCloudCustomizationScriptingWebServices/SuiteTalkWebServices/get.html
module NetSuite
  module Actions
    class Get
      include Support::Requests

      def initialize(klass, options = {})
        @klass   = klass
        @options = options
      end

      private

      def request(credentials = nil)
        credentials ||= NetSuite::Configuration
        credentials.connection.call(:get, message: request_body)
      end

      # TODO DRY up this pattern
      def soap_type
        @klass.to_s.split('::').last.lower_camelcase
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
