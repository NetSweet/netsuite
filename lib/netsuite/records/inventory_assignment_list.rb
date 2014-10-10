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
        assignments.map do |item|
          { "#{record_namespace}:inventoryAssignment" => item.to_record }
        end
      end

    end
  end
end
