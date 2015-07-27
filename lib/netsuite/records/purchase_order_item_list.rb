module NetSuite
  module Records
    class PurchaseOrderItemList < Support::Sublist
      include Namespaces::TranPurch

      sublist :item, PurchaseOrderItem
      
      def items
        self.item
      end
    end
  end
end
