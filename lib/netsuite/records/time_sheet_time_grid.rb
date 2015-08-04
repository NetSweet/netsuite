module NetSuite
  module Records
    class TimeSheetTimeGrid
      include Support::Fields
      include Namespaces::TranEmp

      Date::DAYNAMES.each do |day|
        field day.downcase,   TimeEntry
      end

      def initialize(attributes = {})
        @internal_id = attributes.delete(:internal_id) || attributes.delete(:@internal_id)
        @external_id = attributes.delete(:external_id) || attributes.delete(:@external_id)
        initialize_from_attributes_hash(attributes)
      end
    end
  end
end
