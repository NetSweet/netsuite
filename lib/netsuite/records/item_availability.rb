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

      def self.get_for_inventory_items(items)
        ref_list = NetSuite::Records::RecordRefList.new(
          record_ref: items.map do |item|
            {internal_id: item.internal_id}
          end
        )

        response = NetSuite::Configuration.connection.call :get_item_availability, message: {
          "platformMsgs:itemAvailabilityFilter" => {
            "platformCore:item" => ref_list.to_record
          }
        }

        if response.success?
          response.body[:get_item_availability_response][:get_item_availability_result][:item_availability_list][:item_availability].map do |row|
            NetSuite::Records::ItemAvailability.new(row)
          end
        else
          false
        end
      end
    end
  end
end
