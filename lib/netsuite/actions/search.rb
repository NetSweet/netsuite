# TODO: Tests
module NetSuite
  module Actions
    class Search
      include Support::Requests

      def initialize(klass, options = { })
        @klass = klass
        @options = options
      end

      private

      def request
        # need to do this outside the block below because of variable scoping
        preferences = (@options[:preferences] || {}).inject({}) do |h, (k, v)|
          h[k.to_s.lower_camelcase] = v
          h
        end

        connection.request(:search) do
          soap.namespaces['xmlns:platformMsgs'] = "urn:messages_#{NetSuite::Configuration.api_version}.platform.webservices.netsuite.com"
          soap.namespaces['xmlns:platformCore'] = "urn:core_#{NetSuite::Configuration.api_version}.platform.webservices.netsuite.com"
          soap.namespaces['xmlns:platformCommon'] = "urn:common_#{NetSuite::Configuration.api_version}.platform.webservices.netsuite.com"
          soap.namespaces['xmlns:listRel'] = "urn:relationships_#{NetSuite::Configuration.api_version}.lists.webservices.netsuite.com"
          soap.namespaces['xmlns:tranSales'] = "urn:sales_#{NetSuite::Configuration.api_version}.transactions.webservices.netsuite.com"

          # https://system.netsuite.com/help/helpcenter/en_US/Output/Help/SuiteFlex/WebServices/STP_SettingSearchPreferences.html#N2028598271-3
          soap.header = auth_header.merge(preferences.empty? ? {} : { 'platformMsgs:searchPreferences' => preferences })

          soap.body = request_body
        end
      end

      # basic search XML

      # <soap:Body>
      # <platformMsgs:search>
      # <searchRecord xsi:type="ContactSearch">
      #   <customerJoin xsi:type="CustomerSearchBasic">
      #     <email operator="contains" xsi:type="platformCore:SearchStringField">
      #     <platformCore:searchValue>shutterfly.com</platformCore:searchValue>
      #     <email>
      #   <customerJoin>
      # </searchRecord>
      # </search>
      # </soap:Body>

      def request_body
        criteria = @options[:criteria] || @options

        # TODO wish there was a cleaner way to do this: we need the namespace of the record
        example_instance = @klass.new
        namespace = example_instance.record_namespace

        # extract the class name without the module
        class_name = @klass.to_s.split("::").last

        search_record = {}

        criteria.each_pair do |condition_category, conditions|
          search_record["#{namespace}:#{condition_category}"] = conditions.inject({}) do |h, condition|
            h["platformCommon:#{condition[:field]}"] = {
              "platformCore:searchValue" => condition[:value]
            }

            (h[:attributes!] ||= {}).merge!({
              "platformCommon:#{condition[:field]}" => {
                'operator' => condition[:operator]
              }
            })

            h
          end
        end

        {
          'searchRecord' => search_record,
          :attributes! => {
            'searchRecord' => {
              'xsi:type' => "#{namespace}:#{class_name}Search"
            },
          }
        }
      end

      def response_header
        @response_header ||= response_header_hash
      end

      def response_header_hash
        @response_header_hash = @response.header[:document_info]
      end

      def response_body
        @response_body ||= search_result
      end

      def search_result
        @search_result = @response[:search_response][:search_result]
      end

      def success?
        @success ||= search_result[:status][:@is_success] == 'true'
      end

      module Support
        def self.included(base)
          base.extend(ClassMethods)
        end

        module ClassMethods
          def search(options = { })
            response = NetSuite::Actions::Search.call(self, options)

            if response.success?
              NetSuite::Support::SearchResult.new(response, self)
            else
              false
            end
          end
        end
      end
    end
  end
end