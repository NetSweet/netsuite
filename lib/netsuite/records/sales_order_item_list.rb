module NetSuite
  module Records
    class SalesOrderItemList < Support::Sublist
      include Namespaces::TranSales

      sublist :item, SalesOrderItem

      alias :items :item
    end
  end
end
