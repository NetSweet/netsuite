module NetSuite
  module Records
    class ReturnAuthorizationItemList < Support::Sublist
      include Namespaces::TranSales

      sublist :item, ReturnAuthorizationItem

      alias :items :item
    end
  end
end
