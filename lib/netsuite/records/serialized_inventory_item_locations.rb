module NetSuite
  module Records
    class SerializedInventoryItemLocations
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Support::Actions
      include Namespaces::ListAcct

      actions :add, :delete, :get, :get_list, :get_select_value, :search,
        :update, :upsert

      fields :location, :quantity_available, :serial_numbers

      attr_reader :internal_id
      attr_accessor :external_id
      attr_accessor :search_joins

      def initialize(attributes = {})
        @internal_id = attributes.delete(:internal_id) || attributes.delete(:@internal_id)
        @external_id = attributes.delete(:external_id) || attributes.delete(:@external_id)
        initialize_from_attributes_hash(attributes)
      end

    end
  end
end
