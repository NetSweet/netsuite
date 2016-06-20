module NetSuite
  module Records
    class ExpenseReportExpense
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Support::Actions
      include Namespaces::TranEmp

      actions :get, :get_list, :add, :delete, :update, :upsert

      fields :amount, :exchange_rate, :expense_date, :foreign_amount, :gross_amt, :is_billable, :is_non_reimbursable, :line, :memo,
        :quantity, :rate, :receipt, :ref_number, :tax_1_amt, :tax_rate_1, :tax_rate_2, :klass

      record_refs :category, :currency, :customer, :department, :location

      field :custom_field_list,     CustomFieldList

      attr_reader   :internal_id
      attr_accessor :external_id

      def initialize(attributes = {})
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
