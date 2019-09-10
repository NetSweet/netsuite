module NetSuite
  module Records
    class CashRefundItemList < Support::Sublist
      include Namespaces::TranCust

      sublist :item, CashRefundItem

      alias :items :item

    end
  end
end

