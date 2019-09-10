module NetSuite
  module Records
    class ReturnAuthorizationItemList < Support::Sublist
      include Namespaces::TranCust

      sublist :item, ReturnAuthorizationItem

      alias :items :item
    end
  end
end
