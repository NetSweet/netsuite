module NetSuite
  module Records
    class InventoryAdjustmentInventoryList < Support::Sublist
      include Namespaces::TranInvt

      sublist :inventory, InventoryAdjustmentInventory
      
      def items
        self.item
      end
    end
  end
end
