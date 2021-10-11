module NetSuite
  module Records
    class ItemReceiptItem
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Namespaces::TranPurch

      fields :bin_numbers, :currency, :description, :expiration_date, :is_drop_shipment,
             :item_name, :item_receive, :job_name, :line, :on_hand, :order_line,
             :quantity, :quantity_remaining, :rate, :restock, :serial_numbers,
             :unit_cost_override, :units_display

      record_refs :bill_variance_status, :item, :landed_cost,
                  :location

      field :options, CustomFieldList
      field :custom_field_list, CustomFieldList
      field :inventory_detail, InventoryDetail

      def initialize(attributes_or_record = {})
        case attributes_or_record
        when Hash
          initialize_from_attributes_hash(attributes_or_record)
        when self.class
          initialize_from_record(attributes_or_record)
        end
      end

      def initialize_from_record(record)
        self.attributes = record.send(:attributes)
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
