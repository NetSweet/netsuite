module NetSuite
  module Records
    class InventoryAdjustmentInventoryList < Support::Sublist
      include Namespaces::TranInvt

      sublist :inventory, InventoryAdjustmentInventory

    end
  end
end
