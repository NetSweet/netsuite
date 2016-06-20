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

      def to_record
        {}.tap do |hash|
          Date::DAYNAMES.each do |day|
            day = day.downcase
            hash["#{record_namespace}:#{day}"] = self.attributes[day.to_sym].to_record if self.attributes[day.to_sym].present?
          end
        end
      end
    end
  end
end
