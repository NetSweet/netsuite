module NetSuite
  module Records
    class VendorBill
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Support::Actions
      include Namespaces::TranPurch

      actions :add, :delete, :get, :get_list, :get_select_value, :initialize, :search, :update, :upsert, :upsert_list

      fields :created_date, :credit_limit, :currency_name, :discount_amount, :discount_date, :due_date, :exchange_rate,
             :landed_costs_list, :landed_cost_method, :landed_cost_per_line, :last_modified_date, :memo, :tax_total,
             :tax_2_total, :transaction_number, :tran_date, :tran_id, :user_total, :vat_reg_num, :payment_hold, :amount_remaining

      field :custom_field_list,   CustomFieldList
      field :expense_list,        VendorBillExpenseList
      field :item_list,           VendorBillItemList
      field :purchase_order_list, RecordRefList

      read_only_fields :status

      record_refs :custom_form, :account, :entity, :subsidiary, :approval_status, :next_approver, :posting_period, :terms,
                  :currency, :klass, :department, :location

      attr_reader   :internal_id
      attr_accessor :external_id

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
        'tranSales'
      end

    end
  end
end
