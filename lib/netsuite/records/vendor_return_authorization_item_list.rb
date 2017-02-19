module NetSuite
  module Records
    class VendorReturnAuthorizationItemList < Support::Sublist
      include Namespaces::TranPurch

      sublist :item, VendorReturnAuthorizationItem

      alias :items :item

    end
  end
end
