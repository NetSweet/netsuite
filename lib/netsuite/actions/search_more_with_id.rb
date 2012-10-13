# TODO: Tests
# TODO: DBC
module NetSuite
	module Actions
		class SearchMoreWithId
      include Support::Requests

      def initialize(klass, options = { })
      	@klass = klass

      	@options = options
      end

      private
      
      def request
        connection.request :search_more_with_id do
          soap.namespaces['xmlns:platformMsgs'] = "urn:messages_#{NetSuite::Configuration.api_version}.platform.webservices.netsuite.com"
          soap.namespaces['xmlns:platformCore'] = "urn:core_#{NetSuite::Configuration.api_version}.platform.webservices.netsuite.com"
          soap.namespaces['xmlns:platformCommon'] = "urn:common_#{NetSuite::Configuration.api_version}.platform.webservices.netsuite.com"
          soap.namespaces['xmlns:listRel'] = "urn:relationships_#{NetSuite::Configuration.api_version}.lists.webservices.netsuite.com"
          soap.namespaces['xmlns:tranSales'] = "urn:sales_#{NetSuite::Configuration.api_version}.transactions.webservices.netsuite.com"

          soap.header = auth_header
          
          soap.body = request_body
        end
      end

      # TODO: Consistent use of namespace qualifying
      def request_body
        buffer = ''

        xml = Builder::XmlMarkup.new(target: buffer)

        xml.platformMsgs(:searchId, @options[:search_id])
        xml.platformMsgs(:pageIndex, @options[:page].present? ? @options[:page] : 2)

        buffer
      end

      def response_body
        @response_body ||= response_body_hash
      end

      def response_body_hash
        @response_body_hash = @response[:search_more_with_id_response][:search_result]
      end

      def success?
        @success ||= response_body_hash[:status][:@is_success] == 'true'
      end

      # TODO: Refactor
      def more?
        @more ||= response_body_hash[:page_index] < response_body_hash[:total_pages]
      end

      module Support
        def self.included(base)
          base.extend(ClassMethods)
        end

        # TODO: Rename page_index to page
        module ClassMethods
          def search_more_with_id(options = { })
            response = NetSuite::Actions::SearchMoreWithId.call(self, options)
            
            response_hash = { }

            if response.success?
              response_list = []

              if response.body[:record_list]
                response.body[:record_list][:record].each do |record|
                  entity = new(record)

                  response_list << entity
                end
              end

              page_index = response.body[:page_index]
              total_pages = response.body[:total_pages]

              response_hash[:page_index] = page_index
              response_hash[:total_pages] = total_pages
              response_hash[:entities] = response_list

              response_hash
            else
              raise ArgumentError
            end
          end
        end
      end
    end
  end
end