module NetSuite
  module Records
    class ItemVendor
      include Support::Fields
      include Support::Records
      include Namespaces::ListAcct

      fields :vendor, :purchase_price, :preferred_vendor

      def initialize(attributes = {})
        initialize_from_attributes_hash(attributes)
      end
    end
  end
end
