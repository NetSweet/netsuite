# TODO: Tests
# TODO: DBC
module NetSuite
	module Actions
		class Search
      include Support::Requests

			def initialize(klass, options = {})
				@klass = klass
        @options = options
			end

      private

      def soap_type
        @klass.to_s.split('::').last.lower_camelcase
      end

      def request
        connection.request :search do
          soap.namespaces['xmlns:platformMsgs'] = "urn:messages_#{NetSuite::Configuration.api_version}.platform.webservices.netsuite.com"
          soap.namespaces['xmlns:platformCore'] = "urn:core_#{NetSuite::Configuration.api_version}.platform.webservices.netsuite.com"
          soap.namespaces['xmlns:listRel'] = "urn:relationships_#{NetSuite::Configuration.api_version}.lists.webservices.netsuite.com"
          soap.namespaces['xmlns:platformCommon'] = "urn:common_#{NetSuite::Configuration.api_version}.platform.webservices.netsuite.com"

          soap.header = auth_header
          
          soap.body = request_body
        end
      end

      def request_body
        buffer = ''

        record_type = soap_type

        xml = Builder::XmlMarkup.new(target: buffer)

        # TODO: Add ability to use other record types
        xml.searchRecord('xsi:type' => 'listRel:CustomerSearch') do |search_record|
          search_record.basic('xsi:type' => 'platformCommon:CustomerSearchBasic') do |basic|
            @options.each do |field_name, field_value|
            	# TODO: Add ability to use other operators
            	# TODO: Add ability to use other field types
              basic.method_missing(field_name, {
                operator: 'contains',
                'xsi:type' => 'platformCore:SearchStringField'
              }) do |_field_name|
                _field_name.platformCore :searchValue, field_value
              end
            end
          end
        end

        buffer
      end

      def success?
        @success ||= response_hash[:status][:@is_success] == 'true'
      end

      def response_body
        @response_body ||= response_hash
      end

      def response_hash
        @response_hash = @response[:search_response][:search_result]
      end

      module Support
        def self.included(base)
          base.extend(ClassMethods)
        end

        module ClassMethods
          def search(options = { })
            response = NetSuite::Actions::Search.call(self, options)
            
            if response.success?
              response_list = []

              response.body[:record_list][:record].each do |record|
                entity = new(record)

                response_list << entity
              end

              response_list
            else
              raise RecordNotFound
            end
          end
        end
      end
		end
	end
end