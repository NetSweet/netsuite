module NetSuite
  module Records
    class CustomerRefund
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Support::Actions
      include Namespaces::TranCust

      actions :get, :get_list, :initialize, :add, :delete, :update, :upsert, :search

      fields :address, :cc_approved, :cc_expire_date, :cc_name, :cc_number, :cc_street, :cc_zip_code, :charge_it,
        :created_date, :currency_name, :debit_card_issue_no, :exchange_rate, :last_modified_date, :memo, :pn_ref_num, :status,
        :to_be_printed, :tran_date, :tran_id, :valid_from

      field :custom_field_list, CustomFieldList
      field :apply_list,        CustomerRefundApplyList
      field :deposit_list,      CustomerRefundDepositList

      read_only_fields :balance, :total

      record_refs :account, :ar_acct, :credit_card, :credit_card_processor, :custom_form, :customer, :department, :klass,
        :location, :payment_method, :posting_period, :subsidiary, :void_journal, :currency, :payment_option

      attr_reader :internal_id
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
