module NetSuite
  module Records
    class CashSaleItemList < Support::Sublist
      include Namespaces::TranSales

      sublist :item, CashSaleItem

      alias :items :item

    end
  end
end

