module NetSuite
  module Records
    class VendorBillItemList < Support::Sublist
      include Namespaces::TranPurch

      sublist :item, VendorBillItem

      alias :items :item

    end
  end
end
