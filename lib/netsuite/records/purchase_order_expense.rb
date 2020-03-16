module NetSuite
  module Records
    class PurchaseOrderExpense
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Namespaces::TranPurch

      fields :amount, :gross_amt, :is_billable, :is_closed, :line, :memo, :tax1_amt, :tax_amount, :tax_details_reference, :tax_rate1, :tax_rate2

      field :custom_field_list, CustomFieldList

      record_refs :account, :category, :klass, :created_from, :customer, :department, :linked_order_list, :location, :tax_code

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
