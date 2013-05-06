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
        # https://system.netsuite.com/help/helpcenter/en_US/Output/Help/SuiteFlex/WebServices/STP_SettingSearchPreferences.html#N2028598271-3
        preferences = NetSuite::Configuration.auth_header
        preferences = preferences.merge((@options[:preferences] || {}).inject({}) do |h, (k, v)|
          h[k.to_s.lower_camelcase] = v
          h
        end)

        api_version = NetSuite::Configuration.api_version

        NetSuite::Configuration.connection(
          namespaces: {
            'xmlns:platformMsgs' => "urn:messages_#{api_version}.platform.webservices.netsuite.com",
            'xmlns:platformCore' => "urn:core_#{api_version}.platform.webservices.netsuite.com",
            'xmlns:platformCommon' => "urn:common_#{api_version}.platform.webservices.netsuite.com",
            'xmlns:listRel' => "urn:relationships_#{api_version}.lists.webservices.netsuite.com",
            'xmlns:tranSales' => "urn:sales_#{api_version}.transactions.webservices.netsuite.com",
            'xmlns:setupCustom' => "urn:customization_#{api_version}.setup.webservices.netsuite.com"
          },
          soap_header: preferences
        ).call :search, :message => request_body
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
            element_name = "platformCommon:#{condition[:field]}"

            case condition[:field]
            when 'recType'
              # TODO this seems a bit brittle, look into a way to handle this better
              h[element_name] = {
                :@internalId => condition[:value].internal_id
              }
            else
              h[element_name] = {
                "platformCore:searchValue" => condition[:value]
              }

              (h[:attributes!] ||= {}).merge!({
                element_name => {
                  'operator' => condition[:operator]
                }
              })
            end

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
        @search_result = @response.body[:search_response][:search_result]
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