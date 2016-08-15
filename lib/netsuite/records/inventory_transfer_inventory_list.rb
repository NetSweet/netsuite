module NetSuite
  module Records
    class InventoryTransferInventoryList < Support::Sublist
      include Support::RecordRefs
      include Support::Records
      include Namespaces::TranInvt

      sublist :inventory, InventoryTransferInventory

    end
  end
end
