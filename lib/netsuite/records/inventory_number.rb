module NetSuite
  module Records
    class InventoryNumber
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Support::Actions
      include Namespaces::ListAcct

      actions :get, :search, :update

      fields :expiration_date, :inventory_number, :isonhand, :memo, :status, :units, :location,
      :quantityavailable, :quantityintransit, :quantityonhand, :quantityonorder

      field :locations_list, InventoryNumberLocationsList
      field :custom_field_list, CustomFieldList

      record_refs :item

      attr_reader :internal_id
      attr_accessor :external_id

      def initialize(attributes = {})
        @internal_id = attributes.delete(:internal_id) || attributes.delete(:@internal_id)
        @external_id = attributes.delete(:external_id) || attributes.delete(:@external_id)
        initialize_from_attributes_hash(attributes)
      end

      def self.search_class_name
        "InventoryNumber"
      end
    end
  end
end
