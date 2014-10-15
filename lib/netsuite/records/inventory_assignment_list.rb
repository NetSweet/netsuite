module NetSuite
  module Records
    class InventoryAssignmentList
      include Namespaces::PlatformCommon

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
        { "#{record_namespace}:inventoryAssignment" => assignments.map(&:to_record) }
      end
    end
  end
end
