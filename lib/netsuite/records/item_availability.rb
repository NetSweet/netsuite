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

      def self.get_item_availability(ref_list, credentials={})
        connection = NetSuite::Configuration.connection({}, credentials)
        response = connection.call :get_item_availability, message: {
          "platformMsgs:itemAvailabilityFilter" => {
            "platformCore:item" => ref_list.to_record
          }
        }
        return false unless response.success?

        result = response.body[:get_item_availability_response][:get_item_availability_result]
        unless result[:status][:@is_success] == "true"
          return false
        end
        if result[:item_availability_list]
          result[:item_availability_list][:item_availability].map do |row|
            NetSuite::Records::ItemAvailability.new(row)
          end
        else
          []
        end
      end

      def initialize(attributes = {})
        initialize_from_attributes_hash(attributes)
      end
    end
  end
end
