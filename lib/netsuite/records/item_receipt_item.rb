module NetSuite
  module Records
    class ItemReceiptItem
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Support::Actions
      include Namespaces::TranPurch

      actions :get, :add, :delete, :update


      attr_reader   :internal_id
      attr_accessor :external_id

      fields :item_receive, :job_name, :order_line, :line, :item_name, :description, :on_hand,
        :quantity_remaining, :quantity, :units_display, :unit_cost_override, :inventory_detail,
        :serial_numbers, :bin_numbers, :expiration_date, :rate, :currency, :restock,
        :bill_variance_status, :is_drop_shipment

      field :options, CustomFieldList
      field :custom_field_list, CustomFieldList

      record_refs :item, :location

      def initialize(attributes = {})
        @internal_id = attributes.delete(:internal_id) || attributes.delete(:@internal_id)
        @external_id = attributes.delete(:external_id) || attributes.delete(:@external_id)
        initialize_from_attributes_hash(attributes)
      end

      def to_record
        rec = super
        if rec["#{record_namespace}:customFieldList"]
          rec["#{record_namespace}:customFieldList!"] = rec.delete("#{record_namespace}:customFieldList")
        end
        rec
      end


    end
  end
end
