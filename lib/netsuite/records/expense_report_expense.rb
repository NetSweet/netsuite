module NetSuite
  module Records
    class ExpenseReportExpense
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Namespaces::TranEmp

      fields :amount, :exchange_rate, :expense_date, :foreign_amount, :gross_amt, :is_billable, :is_non_reimburable, :line, :memo, :quantity, :rate, :receipt, :ref_number, :tax1_amt, :tax_rate1, :tax_rate2

      field :custom_field_list, CustomFieldList

      record_refs :category, :klass, :currency, :customer, :department, :location, :tax_code, :exp_media_item

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
