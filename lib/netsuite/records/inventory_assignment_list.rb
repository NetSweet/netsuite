module NetSuite
  module Records
    class InventoryAssignmentList
      include Support::Records
      include Support::Fields
      include Namespaces::TranInvt

      fields :replace_all, :inventory_assignment

      def initialize(attrs = {})
        initialize_from_attributes_hash(attrs)
      end

      def inventory_assignment=(items)
        case items
        when Hash
          self.inventory_assignment << InventoryAssignment.new(items)
        when Array
          items.each { |ref| self.inventory_assignment << InventoryAssignment.new(ref) }
        end
      end

      def inventory_assignment
        @inventory_assignment ||= []
      end

      def to_record
        rec = { "#{record_namespace}:inventoryAssignment" => inventory_assignment.map(&:to_record) }
        rec[:@replaceAll] = true if self.replace_all
        rec
      end
    end
  end
end
