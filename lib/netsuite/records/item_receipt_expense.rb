module NetSuite
  module Records
    class ItemReceiptExpense
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Namespaces::TranPurch

      fields :account, :amount, :line, :mark_received, :memo, :order_line

      field :options, CustomFieldList
      field :custom_field_list, CustomFieldList

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
