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

      def to_record
        rec = { "#{record_namespace}:timeSheetTimeGrid" => time_sheet_time_grids.map(&:to_record) }

        if !replace_all.nil?
          rec["#{record_namespace}:replaceAll"] = replace_all
        end

        rec
      end
    end
  end
end