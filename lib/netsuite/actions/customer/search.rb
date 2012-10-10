module NetSuite
	module Actions
		module Customer
			class Search
				attr_accessor :fields

				def initialize(fields = {})
					@fields = fields
				end

				def self.call(fields)
					new(fields).call
				end

				def call
					response = NetSuite::Configuration.connection.request :search do
						soap.header = NetSuite::Configuration.auth_header
						soap.body = fields
					end
				end
			end
		end
	end
end