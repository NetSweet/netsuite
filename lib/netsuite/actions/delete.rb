module NetSuite
  module Actions
    class Delete
      include Support::Requests

      def initialize(object = nil, options = {})
        @object  = object
        @options = options
      end

      private

      def request
        NetSuite::Configuration.connection(
          namespaces: {
            'xmlns:platformMsgs' => "urn:messages_#{NetSuite::Configuration.api_version}.platform.webservices.netsuite.com",
            'xmlns:platformCore' => "urn:core_#{NetSuite::Configuration.api_version}.platform.webservices.netsuite.com"
          },
        ).call :delete, :message => request_body
      end

      def soap_type
        @object.class.to_s.split('::').last.lower_camelcase
      end

      # <soap:Body>
      #   <platformMsgs:delete>
      #     <platformMsgs:baseRef internalId="980" type="customer" xsi:type="platformCore:RecordRef"/>
      #   </platformMsgs:delete>
      # </soap:Body>
      def request_body
        body = {
          'platformMsgs:baseRef' => {},
          :attributes! => {
            'platformMsgs:baseRef' => {
              'xsi:type'   => (@options[:custom] ? 'platformCore:CustomRecordRef' : 'platformCore:RecordRef')
            }
          }
        }

        if @object.respond_to?(:external_id) && @object.external_id
          body[:attributes!]['platformMsgs:baseRef']['externalId'] = @object.external_id
        end

        if @object.respond_to?(:internal_id) && @object.internal_id
          body[:attributes!]['platformMsgs:baseRef']['internalId'] = @object.internal_id
        end

        if @object.class.respond_to?(:type_id) && @object.class.type_id
          body[:attributes!]['platformMsgs:baseRef']['typeId'] = @object.class.type_id
        end

        body[:attributes!]['platformMsgs:baseRef']['type'] = soap_type unless @options[:custom]

        body
      end

      def response_hash
        @response_hash ||= @response.to_hash[:delete_response][:write_response]
      end

      def success?
        @success ||= response_hash[:status][:@is_success] == 'true'
      end

      def response_body
        @response_body ||= response_hash[:base_ref]
      end

      module Support
        def delete(options = {})
          response =  if options.empty?
                        NetSuite::Actions::Delete.call(self)
                      else
                        NetSuite::Actions::Delete.call(self, options)
                      end
          response.success?
        end
      end

    end
  end
end
