module NetSuite
  module Support
    class SearchResult
      attr_accessor :response
      attr_reader :total_records

      # header from a basic customer search:

      # <platformCore:searchResult xmlns:platformCore="urn:core_2012_1.platform.webservices.netsuite.com">
      #   <platformCore:status isSuccess="true"/>
      #   <platformCore:totalRecords>2770</platformCore:totalRecords>
      #   <platformCore:pageSize>5</platformCore:pageSize>
      #   <platformCore:totalPages>554</platformCore:totalPages>
      #   <platformCore:pageIndex>1</platformCore:pageIndex>
      #   <platformCore:searchId>WEBSERVICES_738944_SB2_03012013650784545962753432_28d96bd280</platformCore:searchId>

      def initialize(response, result_class)
        @response = response
        @total_records = response.body[:total_records].to_i

        if @total_records > 0
          if @total_records == 1
            [response.body[:record_list][:record]]
          else
            response.body[:record_list][:record]
          end.each do |record|
            results << result_class.new(record)
          end
        end

        # search_results = []

        # if !!response.body[:search_row_list] && !response.body[:search_row_list].empty?
        #   response.body[:search_row_list][:search_row].each do |record|
        #     search_result = NetSuite::Support::SearchResult.new(record)

        #     search_results << search_result
        #   end
        # end

        # search_id = response.header[:ns_id]
        # page_index = response.body[:page_index]
        # total_pages = response.body[:total_pages]

        # response_hash[:search_id] = search_id
        # response_hash[:page_index] = page_index
        # response_hash[:total_pages] = total_pages
        # response_hash[:search_results] = search_results
        # puts response.body
        # response_hash
      end

      def results
        @results ||= []
      end

      def next_page
        
      end

      def all_pages
        
      end

    end
  end
end