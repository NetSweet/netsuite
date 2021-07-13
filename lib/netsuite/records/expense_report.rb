module NetSuite
  module Records
    class ExpenseReport
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Support::Actions
      include Namespaces::TranEmp

      actions :add, :get, :search, :update

      fields :accounting_approval, :advance, :amount, :complete, :created_date, :due_date, :last_modified_date, :memo, :status, :supervisor_approval, :tax1_amt, :tax2_amt, :total, :tran_date, :tran_id, :use_multi_currency

      # todo
      # field :accounting_book_detail_list,  AccountingBookDetailList
      field :custom_field_list,   CustomFieldList
      field :expense_list,        ExpenseReportExpenseList
      field :null_field_list,     NullFieldList

      record_refs :account, :approval_status, :klass, :custom_form, :department, :entity, :location, :next_approver, :posting_period, :subsidiary

      attr_reader   :internal_id
      attr_accessor :external_id
      attr_accessor :search_joins

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

      def self.search_class_name
        "Transaction"
      end

      def self.search_class_namespace
        'tranEmp'
      end

    end
  end
end
