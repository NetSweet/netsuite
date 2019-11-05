module NetSuite
  module Actions
    class Attach
      include Support::Requests

      attr_reader :response_hash

      def initialize(object=nil)
        @object = object
      end

      private

      def request(credentials={})
        NetSuite::Configuration.connection({}, credentials).call(:attach, :message => request_body)
      end
      
      #please note, reference is spelled referece and is documented that way in NetSuite's documentation
      # <soap:Body>
      #   <platformMsgs:attach>
      #     <platformMsgs:attachReferece xsi:type="platformCore:AttachBasicReference">
      #       <platformCore:attachTo internalId="443" type="vendorBill" xsi:type="platformCore:RecordRef"/>
      #       <platformCore:attachedRecord type="file" internalId="353" xsi:type="platformCore:RecordRef"/>
      #     </platformMsgs:attachReferece>
      #   </platformMsgs:attach>
      # </soap:Body>
      
      def request_body
        hash = {
          'platformMsgs:attachReferece' => {
            :content! => @object.to_record,
            '@xsi:type' => @object.record_type
          }
        }
        #not crazy about this solution but not sure how else to get the 'xsi:type' var in the hash
        hash["platformMsgs:attachReferece"][:content!][:attributes!]["platformCore:attachTo"]["xsi:type"] = "platformCore:RecordRef"
        hash["platformMsgs:attachReferece"][:content!][:attributes!]["platformCore:attachedRecord"]["xsi:type"] = "platformCore:RecordRef"

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
        def attach(credentials={})
          response = NetSuite::Actions::Attach.call([self], credentials)

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
