# TODO: Tests
# TODO: DBC
module NetSuite
	module Actions
		class Search
      include Support::Requests

      PAGE_SIZE = 500

			def initialize(klass, options = { })
				@klass = klass

        @options = options
			end

      private

      def soap_record_type
        @klass.to_s.split('::').last
      end

      def request
        connection.request :search do
          soap.namespaces['xmlns:platformMsgs'] = "urn:messages_#{NetSuite::Configuration.api_version}.platform.webservices.netsuite.com"
          soap.namespaces['xmlns:platformCore'] = "urn:core_#{NetSuite::Configuration.api_version}.platform.webservices.netsuite.com"
          soap.namespaces['xmlns:platformCommon'] = "urn:common_#{NetSuite::Configuration.api_version}.platform.webservices.netsuite.com"
          soap.namespaces['xmlns:listRel'] = "urn:relationships_#{NetSuite::Configuration.api_version}.lists.webservices.netsuite.com"
          soap.namespaces['xmlns:tranSales'] = "urn:sales_#{NetSuite::Configuration.api_version}.transactions.webservices.netsuite.com"

          soap.header = auth_header.merge({
            search_preferences: {
              body_fields_only: false,
              page_size: PAGE_SIZE
            }
          })
          
          soap.body = request_body
        end
      end

      def request_body
        buffer = ''

        xml = Builder::XmlMarkup.new(target: buffer)

        # TODO: Consistent use of namespace qualifying
        # TODO: Allow for joins
        xml.searchRecord('xsi:type' => @klass.custom_soap_search_record_type) do |search_record|
          search_record.basic('xsi:type' => "platformCommon:#{@klass.respond_to?(:custom_soap_basic_search_record_type) ? @klass.custom_soap_basic_search_record_type : soap_record_type}SearchBasic") do |basic|
            if @klass.respond_to?(:default_search_options)
              @options.merge!(@klass.default_search_options)
            end

            @options.each do |field_name, field_options|
              field_hash = {
                operator: field_options[:operator],
                'xsi:type' => field_options[:type] || 'platformCore:SearchStringField'
              }

              basic.method_missing(field_name, field_hash) do |_field_name|
                _field_name.platformCore :searchValue, field_options[:value]
              end
            end
          end
        end

        buffer
      end

      def response_header
        @response_header ||= response_header_hash
      end

      def response_header_hash
        @response_header_hash = @response.header[:document_info]
      end

      def response_body
        @response_body ||= response_body_hash
      end

      def response_body_hash
        @response_body_hash = @response[:search_response][:search_result]
      end

      def success?
        @success ||= response_body_hash[:status][:@is_success] == 'true'
      end

      module Support
        def self.included(base)
          base.extend(ClassMethods)
        end

        module ClassMethods
          def search(options = { })
            response = NetSuite::Actions::Search.call(self, options)
            
            response_hash = { }

            if response.success?
              response_list = []

              response.body[:record_list][:record].each do |record|
                entity = new(record)

                response_list << entity
              end

              search_id = response.header[:ns_id]
              page_index = response.body[:page_index]
              total_pages = response.body[:total_pages]

              response_hash[:search_id] = search_id
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