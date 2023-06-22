module NetSuite
  module Records
    class DepositApplication
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Support::Actions
      include Namespaces::TranCust

      actions :get, :get_list, :initialize, :add, :delete, :update, :upsert, :search

      fields :applied,
        :created_date,
        :dep_date,
        :exchange_rate,
        :last_modified_date,
        :memo,
        :status,
        :total,
        :tran_date,
        :tran_id,
        :unapplied

      record_refs :ar_acct,
        :klass,
        :currency,
        :customer,
        :department,
        :deposit,
        :location,
        :posting_period,
        :subsidiary

      # :accounting_book_detail_list	AccountingBookDetailList	0..1
      field :apply_list,        CustomerPaymentApplyList
      field :custom_field_list, CustomFieldList

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
