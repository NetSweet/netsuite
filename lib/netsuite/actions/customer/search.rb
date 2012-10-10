# TODO: Tests
# TODO: DBC
# TODO: Integrate with rest of gem
module NetSuite
	module Actions
		module Customer
			class Search
				def initialize(fields = {})
					@fields = fields
				end

				def self.call(fields)
					new(fields).call
				end

				def call
					response = NetSuite::Configuration.connection.request :search do
						soap.namespaces['xmlns:platformMsgs'] = "urn:messages_#{NetSuite::Configuration.api_version}.platform.webservices.netsuite.com"
						soap.namespaces['xmlns:platformCore'] = "urn:core_#{NetSuite::Configuration.api_version}.platform.webservices.netsuite.com"
						soap.namespaces['xmlns:listRel'] = "urn:relationships_#{NetSuite::Configuration.api_version}.lists.webservices.netsuite.com"

						soap.header = NetSuite::Configuration.auth_header
						
						soap.body = request_body
					end
				end

				private

				def soap_type
        	self.class.to_s.split('::').last.lower_camelcase
      	end

	      def request_body
          buffer = ''

          record_type = soap_type

          xml = Builder::XmlMarkup.new(target: buffer)

          xml.searchRecord('xsi:type' => 'CustomerSearch') do |search_record|
            search_record.basic('xsi:type' => 'CustomerSearchBasic') do |basic|
              @fields.each do |field_name, field_value|
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
			end
		end
	end
end