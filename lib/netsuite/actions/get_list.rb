module NetSuite
  module Actions
    class GetList
      include Support::Requests

      def initialize(klass, options = { })
        @klass = klass
        @options = options
      end

      private

      def request(credentials={})
        NetSuite::Configuration.connection({}, credentials).call(:get_list, :message => request_body)
      end

      def request_body
        # list of all netsuite types; useful for debugging
        # https://webservices.netsuite.com/xsd/platform/v2014_1_0/coreTypes.xsd

        list = @options.is_a?(Hash) ? @options[:list] : @options
        id_ref = @options[:use_external_id] ? '@externalId' : '@internalId'
        formatted_list = if @options[:type_id]
          type = @options[:type_id]
          record_type = 'platformCore:CustomRecordRef'

          list.map do |internal_id|
            {
              id_ref => internal_id,
              '@typeId' => type,
              '@xsi:type' => record_type
            }
          end
        else
          type = @klass.to_s.split('::').last.lower_camelcase
          record_type = 'platformCore:RecordRef'

          list.map do |internal_id|
            {
              id_ref => internal_id,
              '@type' => type,
              '@xsi:type' => record_type
            }
          end
        end

        {
          baseRef: formatted_list
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
        # each returned record has its own status; 
        if @options[:allow_incomplete] 
          @success ||= !response_body.detect { |r| r[:status][:@is_success] == 'true' }.nil?
        else
          @success ||= response_body.detect { |r| r[:status][:@is_success] != 'true' }.nil?
        end
      end

      module Support
        def self.included(base)
          base.extend(ClassMethods)
        end

        module ClassMethods
          def get_list(options = { }, credentials={})
            response = NetSuite::Actions::GetList.call([self, options], credentials)

            if response.success?
              response.body.inject([]) do |arr, record|
                arr << new(record[:record]) unless record[:status][:@is_success] != 'true'
                arr
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