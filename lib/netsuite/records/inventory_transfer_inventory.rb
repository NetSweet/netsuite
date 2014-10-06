module NetSuite
  module Records
    class InventoryTransferInventory
      include Support::Records
      include Support::Fields
      include Support::RecordRefs
      include Namespaces::TranInvt

      fields :adjust_qty_by, :description, :from_bin_numbers, :line,
        :quantity_on_hand, :serial_numbers, :to_bin_numbers

      field :inventory_detail, InventoryDetail

      record_refs :item, :units

      def initialize(attributes = {})
        initialize_from_attributes_hash(attributes)
      end
    end
  end
end
