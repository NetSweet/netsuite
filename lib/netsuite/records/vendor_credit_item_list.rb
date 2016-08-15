module NetSuite
  module Records
    class VendorCreditItemList < Support::Sublist
      include Namespaces::TranPurch

      sublist :item, VendorCreditItem

      alias :items :item

    end
  end
end
