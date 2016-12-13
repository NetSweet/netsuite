module NetSuite
  module Records
    class ItemVendorList < Support::Sublist
      include Namespaces::ListAcct

      sublist :item_vendor, ItemVendor

      alias :item_vendors :item_vendor
    end
  end
end
