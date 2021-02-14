module NetSuite
  module Support
    class SearchResult
      attr_accessor :response

      attr_reader :total_records
      attr_reader :total_pages
      attr_reader :current_page

      # header from a basic customer search:

      # <platformCore:searchResult xmlns:platformCore="urn:core_2012_1.platform.webservices.netsuite.com">
      #   <platformCore:status isSuccess="true"/>
      #   <platformCore:totalRecords>2770</platformCore:totalRecords>
      #   <platformCore:pageSize>5</platformCore:pageSize>
      #   <platformCore:totalPages>554</platformCore:totalPages>
      #   <platformCore:pageIndex>1</platformCore:pageIndex>
      #   <platformCore:searchId>WEBSERVICES_738944_SB2_03012013650784545962753432_28d96bd280</platformCore:searchId>

      def initialize(response, result_class, credentials)
        @result_class = result_class
        @response = response
        @credentials = credentials

        @total_records = response.body[:total_records].to_i
        @total_pages = response.body[:total_pages].to_i
        @current_page = response.body[:page_index].to_i

        if @total_records > 0
          if response.body.has_key?(:record_list)
            # basic search results

            #  `recordList` node can contain several nested `record` nodes, only one node or be empty
            #  so we have to handle all these cases:
            #    * { record_list: nil }
            #    * { record_list: { record: => {...} } }
            #    * { record_list: { record: => [{...}, {...}, ...] } }
            record_list = if response.body[:record_list].nil?
              []
            elsif response.body[:record_list][:record].is_a?(Array)
              response.body[:record_list][:record]
            else
              [response.body[:record_list][:record]]
            end

            record_list.each do |record|
              results << result_class.new(record)
            end
          elsif response.body.has_key? :search_row_list
            # advanced search results
            record_list = response.body[:search_row_list][:search_row]
            record_list = [record_list] unless record_list.is_a?(Array)

            record_list.each do |record|
              # TODO because of customFieldList we need to either make this recursive
              #      or handle the customFieldList as a special case

              record.each_pair do |search_group, search_data|
                # skip all attributes: look for :basic and all :xxx_join
                next if search_group.to_s.start_with?('@')

                # avoids `RuntimeError: can't add a new key into hash during iteration`
                record[search_group][:custom_field_list] ||= {custom_field: []}

                record[search_group].each_pair do |attr_name, search_result|
                  # example pair:
                  # {
                  #   :department=>{
                  #     :search_value=>{:@internal_id=>"113"},
                  #     :custom_label=>"Business Unit"
                  #   }
                  # }

                  # all return values are wrapped in a <SearchValue/>
                  # extract the value from <SearchValue/> to make results easier to work with

                  if search_result.is_a?(Hash) && search_result.has_key?(:search_value)
                    # Here's an example of a record ref and string response

                    # <platformCommon:entity>
                    #   <platformCore:searchValue internalId="446515"/>
                    # </platformCommon:entity>
                    # <platformCommon:status>
                    #   <platformCore:searchValue>open</platformCore:searchValue>
                    # </platformCommon:status>

                    # in both cases, header-level field's value should be set to the
                    # child `searchValue` result: if it's a record ref, the internalId
                    # attribute will be transitioned to the parent, and in the case
                    # of a string response the parent node's value will be to the string

                    if %i[internal_id external_id].include?(attr_name) || result_class.fields.include?(attr_name) || search_group != :basic
                      # this is a record field, it will be picked up when we
                      # intialize the `result_class`
                      record[search_group][attr_name] = search_result[:search_value]
                    else
                      # not a record field -- treat it as if it were a custom field
                      # otherwise it will be lost when we initialize
                      custom_fields = record[search_group][:custom_field_list][:custom_field]
                      custom_fields = [custom_fields] if custom_fields.is_a?(Hash)
                      custom_fields << search_result.merge(NetSuite::Records::CustomFieldList.reference_id_type => attr_name)
                      record[search_group][:custom_field_list][:custom_field] = custom_fields
                    end
                  else
                    # NOTE need to understand this case more, in testing, only the namespace definition hits this condition
                  end
                end
              end

              if record[:basic][:internal_id]
                record[:basic][:internal_id] = record[:basic][:internal_id][:@internal_id]
              end

              if record[:basic][:external_id]
                record[:basic][:external_id] = record[:basic][:external_id][:@external_id]
              end

              result_wrapper = result_class.new(record.delete(:basic))
              result_wrapper.search_joins = record
              results << result_wrapper
            end
          else
            raise "uncaught search result"
          end
        end
      end

      def results
        @results ||= []
      end

      def results_in_batches
        return if self.total_records.zero?

        while @response.body[:total_pages] != @response.body[:page_index]
          yield results

          next_search = @result_class.search(
            {
              search_id: @response.body[:search_id],
              page_index: @response.body[:page_index].to_i + 1
            },
            @credentials
          )

          @results = next_search.results
          @response = next_search.response
          @current_page = response.body[:page_index].to_i
        end

        yield results
      end

    end
  end
end
