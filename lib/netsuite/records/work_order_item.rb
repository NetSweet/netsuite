module NetSuite
  module Records
    class WorkOrderItem
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Namespaces::TranInvt

      fields :average_cost, :bom_quantity, :commit, :component_yield,
        :contribution, :create_po, :create_wo, :description, :inventory_detail,
        :last_purchase_price, :line, :order_priority, :percent_complete,
        :po_rate, :quantity, :quantity_available, :quantity_back_ordered,
        :quantity_committed, :quantity_on_hand, :serial_numbers

      field :custom_field_list, CustomFieldList
      field :options,           CustomFieldList

      record_refs :department, :item, :location, :po_vender, :units

      attr_reader   :internal_id
      attr_accessor :external_id

      def initialize(attributes = {})
        @internal_id = attributes.delete(:internal_id) || attributes.delete(:@internal_id)
        @external_id = attributes.delete(:external_id) || attributes.delete(:@external_id)
        initialize_from_attributes_hash(attributes)
      end
    end
  end
end
