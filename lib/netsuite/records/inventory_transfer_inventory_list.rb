module NetSuite
  module Records
    class InventoryTransferInventoryList < Support::Sublist
      include Namespaces::TranInvt

      sublist :inventory, InventoryTransferInventory

    end
  end
end
