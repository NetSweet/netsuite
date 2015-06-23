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

      def initialize(response, result_class)
        @result_class = result_class
        @response = response
        
        @total_records = response.body[:total_records].to_i
        @total_pages = response.body[:total_pages].to_i
        @current_page = response.body[:page_index].to_i

        if @total_records > 0
          if response.body.has_key?(:record_list)
            # basic search results
            record_list = response.body[:record_list][:record]
            record_list = [record_list] if @total_records == 1

            record_list.each do |record|
              results << result_class.new(record)
            end
          elsif response.body.has_key? :search_row_list
            # advanced search results
            record_list = response.body[:search_row_list][:search_row]
            record_list = [record_list] if @total_records == 1

            record_list.each do |record|
              # TODO because of customFieldList we need to either make this recursive
              #      or handle the customFieldList as a special case

              record.each_pair do |search_group, search_data|
                # skip all attributes: look for :basic and all :xxx_join
                next if search_group.to_s.start_with?('@')

                record[search_group].each_pair do |k, v|
                  # all return values are wrapped in a <SearchValue/>
                  # extract the value from <SearchValue/> to make results easier to work with

                  if v.is_a?(Hash) && v.has_key?(:search_value)
                    # search return values that are just internalIds are stored as attributes on the searchValue element
                    if v[:search_value].is_a?(Hash) && v[:search_value].has_key?(:'@internal_id')
                      record[search_group][k] = v[:search_value][:'@internal_id']
                    else
                      record[search_group][k] = v[:search_value]
                    end
                  end
                end
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

      def results_in_batches(credentials = {})
        return if self.total_records.zero?

        while @response.body[:total_pages] != @response.body[:page_index]
          yield results

          next_search = @result_class.search({
            search_id: @response.body[:search_id],
            page_index: @response.body[:page_index].to_i + 1
          }, credentials)

          @results = next_search.results
          @response = next_search.response
          @current_page = response.body[:page_index].to_i
        end

        yield results
      end

    end
  end
end