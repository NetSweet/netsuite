module NetSuite
  module Records
    class TransferOrderItem
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Namespaces::TranInvt

      fields :amount, :average_cost, :klass, :commit_inventory, :description,
             :expected_receipt_date, :expected_ship_date, :inventory_detail, :is_closed, :last_purchase_price,
             :line, :order_priority, :quantity, :quantity_available,
             :quantity_back_ordered, :quantity_committed, :quantity_fulfilled,
             :quantity_on_hand, :quantity_packed, :quantity_picked, :quantity_received,
             :rate, :serial_numbers

      field :options, CustomFieldList
      field :custom_field_list, CustomFieldList

      record_refs :department, :item, :units

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
