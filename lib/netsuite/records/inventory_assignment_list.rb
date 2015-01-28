module NetSuite
  module Records
    class InventoryAssignmentList
      include Namespaces::PlatformCommon

      attr_accessor :replace_all

      def initialize(attributes = {})
        case attributes[:assignment]
        when Hash
          assignments << InventoryAssignment.new(attributes[:assignment])
        when Array
          attributes[:assignment].each do |item| 
            assignments << InventoryAssignment.new(item)
          end
        end
      end

      def assignments
        @assignments ||= []
      end

      def to_record
        rec = {
          "#{record_namespace}:inventoryAssignment" => assignments.map(&:to_record),
        }
        rec[:@replaceAll] = true if @replace_all
        rec
      end
    end
  end
end
