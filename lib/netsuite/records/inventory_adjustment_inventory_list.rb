module NetSuite
  module Records
    class InventoryAdjustmentInventoryList < Support::Sublist
      include Support::RecordRefs
      include Support::Records
      include Namespaces::TranInvt

      sublist :inventory, InventoryAdjustmentInventory

    end
  end
end
