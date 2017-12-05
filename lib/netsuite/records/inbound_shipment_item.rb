module NetSuite
  module Records
    class InboundShipmentItem
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Namespaces::TranPurch

      fields  :id, :shipment_item_description, :po_vendor, :quantity_received, :quantity_expected,
              :quantity_remaining, :po_rate, :expected_rate, :shipment_item_amount

      field :custom_field_list,   CustomFieldList

      record_refs  :purchase_order, :shipment_item, :receiving_location, :po_currency, :incoterm

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
