module NetSuite
  module Records
    class ItemAvailability
      include Support::Fields
      include Support::RecordRefs
      include Support::Records

      field :item, InventoryItem
      field :location_id, Location
      alias_method :location, :location_id

      field :quantity_on_hand
      field :on_hand_value_mli
      field :reorder_point
      field :quantity_on_order
      field :quantity_committed
      field :quantity_available

      def initialize(attributes = {})
        initialize_from_attributes_hash(attributes)
      end
    end
  end
end
