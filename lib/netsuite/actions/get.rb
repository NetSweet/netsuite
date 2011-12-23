module NetSuite
  module Actions
    class Get

      def initialize(id)
        @id = id
      end

      def self.call(id)
        new(id).call
      end

      def call
        @response = request
        build_response
      end

      private

      def request
        connection.request :platformMsgs, :get do
          soap.namespaces['xmlns:platformMsgs'] = 'urn:messages_2011_2.platform.webservices.netsuite.com'
          soap.namespaces['xmlns:platformCore'] = 'urn:core_2011_2.platform.webservices.netsuite.com'
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
      #   <platformMsgs:get>
      #     <platformMsgs:baseRef internalId="983" type="customer" xsi:type="platformCore:RecordRef">
      #       <platformCore:name/>
      #     </platformMsgs:baseRef>
      #   </platformMsgs:get>
      # </soap:Body>
      def request_body
        {
          'platformMsgs:baseRef' => {},
          :attributes! => {
            'platformMsgs:baseRef' => {
              :internalId => @id,
              :type       => 'customer',
              'xsi:type'  => 'platformCore:RecordRef'
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
        @response_body ||= response_hash[:record]
      end

      def response_hash
        @response_hash = @response[:get_response][:read_response]
      end

    end
  end
end
