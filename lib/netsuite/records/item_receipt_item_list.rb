module NetSuite
  module Records
    class ItemReceiptItemList < Support::Sublist
      include Namespaces::TranPurch

      sublist :item, ItemReceiptItem

      def items
        self.item
      end

    end
  end
end
