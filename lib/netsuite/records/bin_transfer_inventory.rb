module NetSuite
  module Records
    class BinTransferInventory
      include Support::Records
      include Support::Fields
      include Support::RecordRefs
      include Namespaces::TranInvt

      fields :description, :from_bins, :item_units_label, :line, :preferred_bin, :quantity, :to_bins

      field :inventory_detail, InventoryDetail

      record_refs :item

      def initialize(attributes = {})
        initialize_from_attributes_hash(attributes)
      end
    end
  end
end
