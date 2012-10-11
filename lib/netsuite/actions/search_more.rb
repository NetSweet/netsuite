# TODO: Tests
# TODO: DBC
module NetSuite
	module Actions
		class SearchMore
      include Support::Requests

      def initialize(klass, options = { })
      	@klass = klass

      	@options = options
      end

      private

      def soap_type
        @klass.to_s.split('::').last.lower_camelcase
      end

      def request
        connection.request :search_more do
          soap.namespaces['xmlns:platformMsgs'] = "urn:messages_#{NetSuite::Configuration.api_version}.platform.webservices.netsuite.com"
          soap.namespaces['xmlns:platformCore'] = "urn:core_#{NetSuite::Configuration.api_version}.platform.webservices.netsuite.com"
          soap.namespaces['xmlns:listRel'] = "urn:relationships_#{NetSuite::Configuration.api_version}.lists.webservices.netsuite.com"
          soap.namespaces['xmlns:platformCommon'] = "urn:common_#{NetSuite::Configuration.api_version}.platform.webservices.netsuite.com"

          soap.header = auth_header
          
          soap.body = request_body
        end
      end

      # TODO: Consistent use of namespace qualifying
      def request_body
        buffer = ''

        xml = Builder::XmlMarkup.new(target: buffer)

        xml.platformMsgs(:page_index, @options[:page].present? ? @options[:page] : 2)

        buffer
      end

      def response_body
        @response_body ||= response_hash
      end

      def response_hash
        @response_hash = @response[:search_more_response][:search_result]
      end

      def success?
        @success ||= response_hash[:status][:@is_success] == 'true'
      end

      # TODO: Refactor
      def more?
        @more ||= response_hash[:page_index] < response_hash[:total_pages]
      end

      module Support
        def self.included(base)
          base.extend(ClassMethods)
        end

        module ClassMethods
          def search_more(options = { })
            response = NetSuite::Actions::SearchMore.call(self, options)
            
            if response.success?
              response_list = []

              response.body[:record_list][:record].each do |record|
                entity = new(record)

                response_list << entity
              end

              response_list
            else
              raise ArgumentError
            end
          end
        end
      end
    end
  end
end