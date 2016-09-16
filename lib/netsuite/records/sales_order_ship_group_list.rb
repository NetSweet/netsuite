module NetSuite
  module Records
    class SalesOrderShipGroupList < Support::Sublist
      include Namespaces::TranSales

      sublist :ship_group, TransactionShipGroup

      alias :ship_groups :ship_group
    end
  end
end
