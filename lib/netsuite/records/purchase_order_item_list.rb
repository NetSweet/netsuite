module NetSuite
  module Records
    class PurchaseOrderItemList < Support::Sublist
      include Namespaces::TranPurch

      sublist :item, PurchaseOrderItem

      alias :items :item
    end
  end
end
