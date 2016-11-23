module NetSuite
  module Actions
    class Attach
      include Support::Requests

      attr_reader :response_hash

      def initialize(object, object_to_attach)
        @object = object
        @object_to_attach = object_to_attach
      end

      private

      def request(credentials = {})
        NetSuite::Configuration.connection({}, credentials).call(:attach, :message => request_body)
      end

      # <soap:Body>
      #   <platformMsgs:attach>
      #      <platformMsgs:attachReference xsi:type="s0:AttachContactReference">
      #         <s0:attachTo xsi:type="s0:RecordRef" internalId="9044" type="customer" />
      #         <s0:contact internalId="9045" />
      #         <s0:contactRole internalId="-10" />
      #      </platformMsgs:attachReference>
      #   </platformMsgs:attach>
      # </soap:Body>

      def request_body
        base_xml = {
          'platformMsgs:attachReference' => {
            :content! => @object.to_record,
            '@xsi:type' => @object.record_type
          }
        }

        base_xml.tap do |body|
          if @object_to_attach.respond_to?(:to_attachment)
            @object_to_attach.to_attachment.each do |key, value|
              body["platformMsgs:attachReference"][:content!][key] = {}
              body["platformMsgs:attachReference"][:content!][:attributes!][key] = value
            end
          end
        end
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
        @response_hash ||= @response.to_hash[:attach_response][:write_response]
      end

      def errors
        error_obj = response_hash[:status][:status_detail]
        error_obj = [error_obj] if error_obj.class == Hash
        error_obj.map do |error|
          NetSuite::Error.new(error)
        end
      end

      module Support
        def attach(object_to_attach, credentials = {})
          response = NetSuite::Actions::Attach.call([self, object_to_attach], credentials)
          @errors = response.errors
          response.success?
        end
      end
    end
  end
end
