module NetSuite
  module Records
    class VendorBillExpense
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Namespaces::TranPurch

      fields  :amount, :amortization_end_date, :amortiz_start_date, :amortization_residual, :gross_amt, :is_billable,
              :line, :memo, :order_doc, :order_line, :tax_1_amt, :tax_rate_1, :tax_rate_2

      field :custom_field_list,     CustomFieldList

      record_refs  :account, :amortization_sched, :klass, :category, :customer, :department, :location, :tax_code

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

