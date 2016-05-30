module NetSuite
  module Records
    class ItemReceiptItemList < Support::Sublist
      include Namespaces::TranPurch

      sublist :item, ItemReceiptItem

      alias :items :item
    end
  end
end
