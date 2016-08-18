module NetSuite
  module Support
    class SearchResult
      attr_accessor :response

      attr_reader :total_records
      attr_reader :total_pages
      attr_reader :current_page
      attr_reader :response
      attr_reader :result_class

      # header from a basic customer search:

      # <platformCore:searchResult xmlns:platformCore="urn:core_2012_1.platform.webservices.netsuite.com">
      #   <platformCore:status isSuccess="true"/>
      #   <platformCore:totalRecords>2770</platformCore:totalRecords>
      #   <platformCore:pageSize>5</platformCore:pageSize>
      #   <platformCore:totalPages>554</platformCore:totalPages>
      #   <platformCore:pageIndex>1</platformCore:pageIndex>
      #   <platformCore:searchId>WEBSERVICES_738944_SB2_03012013650784545962753432_28d96bd280</platformCore:searchId>

      def initialize(response, result_class)
        @result_class  = result_class
        @response      = response
        @total_records = response.body[:total_records].to_i
        @total_pages   = response.body[:total_pages].to_i
        @current_page  = response.body[:page_index].to_i

        return unless @total_records > 0
        return results_from_basic_search    if response.body.key? :record_list
        return results_from_advanced_search if response.body.key? :search_row_list
        raise "uncaught search result"
      end

      def results
        @results ||= []
      end

      def results_in_batches
        return if self.total_records.zero?

        while @response.body[:total_pages] != @response.body[:page_index]
          yield results

          next_search = @result_class.search(
            search_id: @response.body[:search_id],
            page_index: @response.body[:page_index].to_i + 1
          )

          @results = next_search.results
          @response = next_search.response
          @current_page = response.body[:page_index].to_i
        end

        yield results
      end

      private

      # remove the useless :search_value from a hash recursively.
      # turns this: {:amount_remaining=>{:search_value=>"6030.0"}}
      # into this: {:amount_remaining=>"6030.0"}
      # regardless of how deep it is in the hash hierarchy.
      def remove_search_value(hash)
        return hash unless hash.is_a? Hash
        return hash[:search_value] if hash.key? :search_value
        hash.each { |k, v| hash[k] = remove_search_value(v) }
      end

      # brings the internal_id to the surface
      # turns this: {:internal_id=>{:@internal_id=>"5"}}
      # into this: {:internal_id=>"5"}
      # regardless of how deep it is in the hash hierarchy.
      def bring_up_internal_id(hash)
        return hash unless hash.is_a? Hash
        if hash.key?(:internal_id) && hash[:internal_id].is_a?(Hash)
          hash[:internal_id] = hash[:internal_id].values[0]
          return hash
        end
        hash.each { |k, v| hash[k] = bring_up_internal_id(v) }
      end

      def cleanup_record(record)
        # TODO because of customFieldList we need to either make this recursive
        #      or handle the customFieldList as a special case

        search_value_removed_record = remove_search_value(record)
        bring_up_internal_id(search_value_removed_record)
      end

      def results_from_basic_search
        record_list = response.body[:record_list][:record]
        record_list = [record_list] unless record_list.is_a?(Array)

        record_list.each do |record|
          results << result_class.new(record)
        end
      end

      def results_from_advanced_search
        record_list = response.body[:search_row_list][:search_row]
        record_list = [record_list] unless record_list.is_a?(Array)

        record_list.each do |record|
          clean_record = cleanup_record(record)
          result_wrapper = result_class.new(clean_record.delete(:basic))
          result_wrapper.search_joins = clean_record
          results << result_wrapper
        end
      end

    end
  end
end
