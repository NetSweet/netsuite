module NetSuite
  module Records
    class TransferOrderItemList < Support::Sublist
      include Namespaces::TranInvt

      sublist :item, TransferOrderItem

      alias :items :item
    end
  end
end
