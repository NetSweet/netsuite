module NetSuite
  module Records
    class InventoryNumberLocations
      include Support::Fields
      include Support::Records
      include Namespaces::ListAcct

      fields :location, :quantity_available, :quantity_in_transit,
      :quantity_on_hand, :quantity_on_order

      def initialize(attributes = {})
        initialize_from_attributes_hash(attributes)
      end
    end
  end
end
