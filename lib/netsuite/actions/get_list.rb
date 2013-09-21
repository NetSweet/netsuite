module NetSuite
  module Actions
    class GetList
      include Support::Requests

      def initialize(klass, options = { })
        @klass = klass
        @options = options
      end

      private

      def request
        NetSuite::Configuration.connection.call :get_list, :message => request_body
      end

      def request_body
        if @options[:type_id]
          type = @options[:type_id]
          record_type = 'platformCore:CustomRecordRef'
        else
          type = @klass.to_s.split('::').last.lower_camelcase
          record_type = 'platformCore:RecordRef'
        end

        list = @options.is_a?(Hash) ? @options[:list] : @options

        {
          baseRef: list.map do |internal_id|
            {
              '@internalId' => internal_id,
              '@typeId' => type,
              '@xsi:type' => record_type
            }
          end
        }
      end

      def response_header
        @response_header ||= response_header_hash
      end

      def response_header_hash
        @response_header_hash = @response.header[:document_info]
      end

      def response_body
        @response_body ||= @response.body[:get_list_response][:read_response_list][:read_response]
      end

      def success?
        # each returned record has its own status; for now if one fails, the entire operation has failed
        @success ||= response_body.detect { |r| r[:status][:@is_success] != 'true' }.nil?
      end

      module Support
        def self.included(base)
          base.extend(ClassMethods)
        end

        module ClassMethods
          def get_list(options = { })
            response = NetSuite::Actions::GetList.call(self, options)

            if response.success?
              response.body.map do |record|
                new(record[:record])
              end
            else
              false
            end
          end
        end
      end
    end
  end
end