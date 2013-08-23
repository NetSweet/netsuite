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
        # https://system.netsuite.com/help/helpcenter/en_US/Output/Help/SuiteCloudCustomizationScriptingWebServices/SuiteTalkWebServices/SettingSearchPreferences.html
        # https://webservices.netsuite.com/xsd/platform/v2012_2_0/messages.xsd
        
        preferences = NetSuite::Configuration.auth_header
        preferences = preferences.merge(
          (@options[:preferences] || {}).inject({'platformMsgs:SearchPreferences' => {}}) do |h, (k, v)|
            h['platformMsgs:SearchPreferences'][k.to_s.lower_camelcase] = v
            h
          end
        )

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
        # only use :criteria when specifying search options (:page_size, etc)
        criteria = @options[:criteria] || @options

        # TODO find cleaner solution. We need the namespace of the record, which is a instance method
        example_instance = @klass.new
        namespace = example_instance.record_namespace

        # extract the class name
        class_name = @klass.to_s.split("::").last

        search_record = {}

        criteria.each_pair do |condition_category, conditions|
          # TODO a bit hacky, but this works for what I need now for saved search
          if condition_category == :saved
            return {
              'searchRecord' => {
                '@savedSearchId' => conditions,
                '@xsi:type' => "#{namespace}:#{class_name}SearchAdvanced"
              }
            }
          end

          search_record["#{namespace}:#{condition_category}"] = conditions.inject({}) do |h, condition|
            element_name = "platformCommon:#{condition[:field]}"

            case condition[:field]
            when 'recType'
              # TODO this seems a bit brittle, look into a way to handle this better
              h[element_name] = {
                :@internalId => condition[:value].internal_id
              }
            when 'customFieldList'
              # there isn't a clean way to do lists of the same element
              # Gyoku doesn't seem support the nice :@attribute and :content! syntax for lists of elements of the same name
              # https://github.com/savonrb/gyoku/issues/18#issuecomment-17825848

              custom_field_list = condition[:value].map do |h|
                if h[:value].is_a?(Array) && h[:value].first.respond_to?(:to_record)
                  {
                    "platformCore:searchValue" => h[:value].map(&:to_record),
                    :attributes! => {
                      'platformCore:searchValue' => {
                        'internalId' => h[:value].map(&:internal_id)
                      }
                    }
                  }
                elsif h[:value].respond_to?(:to_record)
                  {
                    "platformCore:searchValue" => {
                      :content! => h[:value].to_record,
                      :@internalId => h[:value].internal_id
                    }
                  }
                else
                  { "platformCore:searchValue" => h[:value] }
                end
              end

              h[element_name] = {
                'platformCore:customField' => custom_field_list,
                :attributes! => {
                  'platformCore:customField' => {
                    'internalId' => condition[:value].map { |h| h[:field] },
                    'operator' => condition[:value].map { |h| h[:operator] },
                    'xsi:type' => condition[:value].map { |h| "platformCore:#{h[:type]}" }
                  }
                }
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