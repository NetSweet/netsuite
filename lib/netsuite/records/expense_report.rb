module NetSuite
  module Records
    class ExpenseReport
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Support::Actions
      include Namespaces::TranEmp

      actions :get, :get_list, :add, :delete, :search, :update, :upsert

      fields :accounting_approval, :advance, :complete, :created_date, :due_date, :last_modified_date, :memo, :status,
        :supervisor_approval, :tax_1_amt, :tax_2_amt, :tran_date, :tran_id, :use_multi_currency, :klass

      read_only_fields :amount, :total

      record_refs :account, :approval_status, :custom_form, :department, :entity, :location, :next_approver, :posting_period, :subsidiary

      field :custom_field_list,   CustomFieldList
      field :expense_list,        ExpenseReportExpenseList

      attr_reader   :internal_id
      attr_accessor :external_id

      def initialize(attributes = {})
        @internal_id = attributes.delete(:internal_id) || attributes.delete(:@internal_id)
        @external_id = attributes.delete(:external_id) || attributes.delete(:@external_id)
        initialize_from_attributes_hash(attributes)
      end

      def self.search_class_name
        "Transaction"
      end

      def self.search_class_namespace
        "tranSales"
      end

    end
  end
end
