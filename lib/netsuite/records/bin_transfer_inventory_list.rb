module NetSuite
  module Records
    class BinTransferInventoryList < Support::Sublist
      include Namespaces::TranInvt

      sublist :inventory, BinTransferInventory

    end
  end
end
