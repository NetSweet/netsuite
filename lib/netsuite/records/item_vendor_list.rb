module NetSuite
  module Records
    class ItemVendorList
      def initialize(attributes = {})
        @item_vendor = attributes[:item_vendor] if attributes[:item_vendor]
      end

      def item_vendor
        @item_vendor ||= nil
      end
    end
  end
end
