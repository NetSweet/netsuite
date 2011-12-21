# module NetSuite
#   class Customer
# 
#     def initialize(attributes = {})
#       @attributes = attributes
#     end
# 
#     def self.get(id)
#       response = Gateway.get(id)
#       if response.success?
#         new(response.attributes)
#       else
#         raise NetSuite::RecordNotFound
#       end
#     end
# 
#     def method_missing(m, *args, &block)
#       if @attributes.keys.include?(m.to_sym)
#         @attributes[m.to_sym]
#       else
#         super
#       end
#     end
# 
#     module Gateway
#       extend self
# 
#       def get
#         response = NetSuite::Configuration.connection.request :platformMsgs, :get do
#           soap.namespaces['xmlns:platformMsgs'] = 'urn:messages_2011_2.platform.webservices.netsuite.com'
#           soap.namespaces['xmlns:platformCore'] = 'urn:core_2011_2.platform.webservices.netsuite.com'
#           soap.header = NetSuite::Configuration.auth_header
#           soap.body = {
#             'platformMsgs:baseRef' => {},
#             :attributes! => {
#               'platformMsgs:baseRef' => {
#                 :internalId => id.to_s,
#                 :type       => 'customer',
#                 'xsi:type'  => 'platformCore:RecordRef'
#               }
#             }
#           }
#         end
#         response_hash = response.to_hash
#         if response_hash[:get_response][:read_response][:status][:@is_success] == 'true'
#           attributes = response_hash[:get_response][:read_response][:record]
#           new(attributes)
#         else
#           raise NetSuite::RecordNotFound, "#{self} with ID=#{id} could not be found"
#         end
#       end
# 
#     end
# 
#   end
# 
#   class RecordNotFound < StandardError
#   end
# end
