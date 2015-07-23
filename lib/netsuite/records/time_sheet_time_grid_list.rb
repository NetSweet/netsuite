module NetSuite
  module Records
    class TimeSheetTimeGridList
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Support::Actions
      include Namespaces::TranEmp

      field :replace_all

      def initialize(attributes = {})
        initialize_from_attributes_hash(attributes)

        binding.pry

        case attributes[:time_sheet_time_grid]
          when Hash
            time_sheet_time_grids << TimeSheetTimeGrid.new(attributes[:time_sheet_time_grid])
          when Array
            attributes[:time_sheet_time_grid].each { |time_sheet_time_grid| time_sheet_time_grids << TimeSheetTimeGrid.new(time_sheet_time_grid) }
        end
      end

      def time_sheet_time_grids
        @time_sheet_time_grids ||= []
      end

      # def to_record
      #   { "#{record_namespace}:timeSheet" => time_sheet_time_grids.map(&:to_record) }
      # end
    end
  end
end