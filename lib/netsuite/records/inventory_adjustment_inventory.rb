module NetSuite
  module Records
    class InventoryAdjustmentInventory
      include Support::Records
      include Support::Fields
      include Support::RecordRefs
      include Namespaces::TranInvt

      fields :adjust_qty_by, :description, :bin_numbers, :line,
        :quantity_on_hand, :serial_numbers, :unit_cost

      field :inventory_detail, InventoryDetail

      record_refs :item, :units, :location, :department, :klass

      def initialize(attributes = {})
        initialize_from_attributes_hash(attributes)
      end
    end
  end
end
