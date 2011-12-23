module NetSuite
  module Actions
    class Add

      def initialize(attributes = {})
        @attributes = attributes
      end

      def self.call(attributes = {})
        new(attributes).call
      end

      def call
        @response = request
        build_response
      end

      private

      def request
        connection.request :platformMsgs, :add do
          soap.namespaces['xmlns:platformMsgs'] = 'urn:messages_2011_2.platform.webservices.netsuite.com'
          soap.namespaces['xmlns:platformCore'] = 'urn:core_2011_2.platform.webservices.netsuite.com'
          soap.namespaces['xmlns:listRel']      = 'urn:relationships_2011_2.lists.webservices.netsuite.com'
          soap.header = auth_header
          soap.body   = request_body
        end
      end

      def connection
        NetSuite::Configuration.connection
      end

      def auth_header
        NetSuite::Configuration.auth_header
      end

      # <soap:Body>
      #   <platformMsgs:add>
      #     <platformMsgs:record xsi:type="listRel:Customer">
      #       <listRel:entityId>Shutter Fly</listRel:entityId>
      #       <listRel:companyName>Shutter Fly, Inc</listRel:companyName>
      #     </platformMsgs:record>
      #   </platformMsgs:add>
      # </soap:Body>
      def request_body
        {
          'platformMsgs:record' => {
            'listRel:entityId'    => @attributes[:entity_id],
            'listRel:companyName' => @attributes[:company_name]
          },
          :attributes! => {
            'platformMsgs:record' => {
              'xsi:type' => 'listRel:Customer'
            }
          }
        }
      end

      def build_response
        NetSuite::Response.new(:success => success?, :body => response_body)
      end

      def success?
        @success ||= response_hash[:status][:@is_success] == 'true'
      end

      def response_body
        @response_body ||= response_hash[:base_ref]
      end

      def response_hash
        @response_hash ||= @response.to_hash[:add_response][:write_response]
      end

    end
  end
end
