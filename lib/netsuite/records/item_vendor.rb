module NetSuite
  module Records
    class ItemVendor
      include Support::Fields
      include Support::Records
      include Namespaces::ListAcct

      fields :vendor, :purchase_price, :preferred_vendor

      attr_reader :internal_id

      def initialize(attributes = {})
        @internal_id = attributes.delete(:internal_id) || attributes.delete(:@internal_id)
        initialize_from_attributes_hash(attributes)
      end
    end
  end
end
