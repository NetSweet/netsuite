module NetSuite
  module Records
    class InboundShipment
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Support::Actions
      include Namespaces::TranPurch

      actions :get, :get_list, :add, :initialize, :delete, :update, :upsert, :upsert_list, :search, :update_list

      fields :shipment_number, :external_document_number, :shipment_status, :expected_shipping_date,
            :actual_shipping_date, :expected_delivery_date, :actual_delivery_date, :shipment_memo,
            :vessel_number, :bill_of_lading

      field :items_list,           InboundShipmentItemList
      field :custom_field_list,   CustomFieldList

      record_refs :custom_form

      attr_reader :internal_id
      attr_accessor :external_id

      def initialize(attributes = {})
        @internal_id = attributes.delete(:internal_id) || attributes.delete(:@internal_id)
        @external_id = attributes.delete(:external_id) || attributes.delete(:@external_id)
        initialize_from_attributes_hash(attributes)
      end

    end
  end
end
