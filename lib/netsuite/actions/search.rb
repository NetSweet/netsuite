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

      def soap_record_type
        @klass.to_s.split('::').last
      end

      def request
        connection.request(:search) do
          soap.namespaces['xmlns:platformMsgs'] = "urn:messages_#{NetSuite::Configuration.api_version}.platform.webservices.netsuite.com"
          soap.namespaces['xmlns:platformCore'] = "urn:core_#{NetSuite::Configuration.api_version}.platform.webservices.netsuite.com"
          soap.namespaces['xmlns:platformCommon'] = "urn:common_#{NetSuite::Configuration.api_version}.platform.webservices.netsuite.com"
          soap.namespaces['xmlns:listRel'] = "urn:relationships_#{NetSuite::Configuration.api_version}.lists.webservices.netsuite.com"
          soap.namespaces['xmlns:tranSales'] = "urn:sales_#{NetSuite::Configuration.api_version}.transactions.webservices.netsuite.com"

          # https://system.netsuite.com/help/helpcenter/en_US/Output/Help/SuiteFlex/WebServices/STP_SettingSearchPreferences.html#N2028598271-3
          soap.header = auth_header.merge({
            'platformMsgs:searchPreferences' => {
              'pageSize' => 5,
              'bodyFieldsOnly' => true,
              'returnSearchColumns' => true   # default is true; only valid for advanced searches
            }
          })

          soap.body = request_body
        end
      end

      def request_body
        buffer = ''

        xml = Builder::XmlMarkup.new(target: buffer)

        @options[:criteria] ||= {}

        # TODO: When searching invoices allow for multiple basic search criteria to be set
        # TODO: Make setting of criteria and columns easier
        # xml.searchRecord('xsi:type' => @klass.custom_soap_advanced_search_record_type) do |search_record|
        #   search_record.criteria do |criteria|
        #     if @klass.respond_to?(:default_search_options)
        #       @options[:criteria].merge!(@klass.default_search_options)
        #     end

        #     @options[:criteria].each do |criteria_type, _criteria|
        #       criteria.method_missing(criteria_type) do |_criteria_type|
        #         _criteria.each do |criteria_name, criteria_options|
        #           criteria_hash = {
        #             'xsi:type' => criteria_options[:type]
        #           }

        #           if !!criteria_options[:operator] && !criteria_options[:operator].empty?
        #             criteria_hash.merge!({ operator: criteria_options[:operator] })
        #           end

        #           _criteria_type.method_missing(criteria_name, criteria_hash) do |_criteria_name|
        #             _criteria_name.platformCore(:searchValue, criteria_options[:value])
        #           end
        #         end
        #       end
        #     end
        #   end

        #   search_record.columns do |columns|
        #     @options[:columns].each do |result_type, result_columns|
        #       columns.method_missing(result_type) do |_result_type|
        #         result_columns.each do |result_column|
        #           _result_type.method_missing(result_column)
        #         end
        #       end
        #     end if !!@options[:columns] && !@options[:columns].empty?
        #   end
        # end

        # buffer

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

        # this is the hash that the above code needs to spit out
        # I don't want to have to create seperate objects for *everything*

        # criteria: {
        #   basic: {
        #     [
        #       {
        #         field: 'email'
        #         operator: 'is',
        #         value: 'Michael'
        #       }
        #     ]
        #   },
        # },

        example = @klass.new
        namespace = example.record_namespace
        class_name = @klass.to_s.split("::").last

        elements = {}
        attributes = {}

        @options[:criteria].each_pair do |condition_category, conditions|
          elements["#{namespace}:#{condition_category}"] = conditions.inject({}) do |h, condition|
            binding.pry
            h["platformCommon:#{condition[:field]}"] = {
              "platformCore:searchValue" => condition[:value]
            }

            h[:attributes!] ||= {}

            h[:attributes!]["platformCommon:#{condition[:field]}"] = {
              'operator' => condition[:operator],
              'xsi:type' => 'platformCore:SearchStringField'
            }

            h
          end

          if condition_category.to_s.include? 'Join'
            join_class = condition_category.to_s.split('Join').first.capitalize

            (elements[:attributes!] ||= {}).merge({
              "#{condition_category}" => {
                'xsi:type' => "#{namespace}:#{join_class}SearchBasic"
              }
            })

          end

        end

        binding.pry

        # customer search
        # https://webservices.netsuite.com/xsd/lists/v2012_2_0/relationships.xsd

        {
          'searchRecord' => elements,
          :attributes! => {
            'searchRecord' => {
              # ex: listRel:CustomerSearch
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

        # TODO: Rename page_index to page
        module ClassMethods
          # Preconditions
          # => options is a Hash with the following format:
          #      {
          #        criteria: {
          #          basic: {
          #            type: {
          #              type: 'platformCore:SearchEnumMultiSelectField',
          #              operator: 'anyOf',
          #              value: '_invoice'
          #            }
          #          },
          #          accountJoin: {
          #            type: {
          #              type: 'platformCore:SearchEnumMultiSelectField',
          #              operator: 'anyOf',
          #              value: '_accountsReceivable'
          #            }
          #          }
          #        },
          #        columns: {
          #          basic: ['internalId', 'total', 'dateCreated'],
          #          customerJoin: ['internalId']
          #        }
          #      }
          # Postconditions
          # => Hash with the following keys:
          #      * search_id which is a string
          #      * page_index which is an integer
          #      * total_pages which is an integer
          #      * search_results containing array of SearchResult's
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