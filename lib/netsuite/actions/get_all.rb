# https://system.netsuite.com/help/helpcenter/en_US/Output/Help/SuiteCloudCustomizationScriptingWebServices/SuiteTalkWebServices/getAll.html
module NetSuite
  module Actions
    class GetAll
      include Support::Requests

      def initialize(klass)
        @klass   = klass
      end

      private

      def request(credentials={})
        NetSuite::Configuration.connection(
          { element_form_default: :unqualified }, credentials
        ).call(:get_all, message: request_body)
      end

      # <soap:Body>
      #   <platformMsgs:getAll>
      #     <record>
      #       <recordType>salesTaxItem</recordType>
      #     </record>
      #   </platformMsgs:getAll>
      # </soap:Body>
      def request_body
        type = @klass.to_s.split('::').last.sub(/[A-Z]/) { |m| m[0].downcase }

        {
          record: [
            record_type: type
          ]
        }
      end

      def success?
        @success ||= response_hash[:status][:@is_success] == 'true'
      end

      def response_body
        @response_body ||= array_wrap(response_hash[:record_list][:record])
      end

      def response_hash
        @response_hash ||= @response.body[:get_all_response][:get_all_result]
      end

      module Support

        def self.included(base)
          base.extend(ClassMethods)
        end

        module ClassMethods
          def get_all(credentials = {})
            response = NetSuite::Actions::GetAll.call([self], credentials)
            if response.success?
              response.body.map { |attr| new(attr) }
            else
              raise RecordNotFound, "#{self} with OPTIONS=#{options.inspect} could not be found"
            end
          end
        end
      end
    end
  end
end
