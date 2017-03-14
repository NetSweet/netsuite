module NetSuite
  module Records
    class ItemFulfillmentItemList < Support::Sublist
      include Namespaces::TranSales

      sublist :item, ItemFulfillmentItem

      def items
        self.item
      end

    end
  end
end
