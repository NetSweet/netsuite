module NetSuite
  module Records
    class Deposit
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Support::Actions
      include Namespaces::TranBank

      actions :get, :get_list, :add, :delete, :upsert, :update, :search

      fields :created_date, :last_modified_date, :currency_name, :exchange_rate, :tran_id, :total, :tran_date, :memo, :to_be_printed

      record_refs :custom_form, :account, :posting_period, :subsidiary, :department, :klass, :location

      field :payment_list,      DepositPaymentList
      field :other_list,        DepositOtherList
      field :cash_back_list,    DepositCashBackList
      field :custom_field_list, CustomFieldList

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
        'tranSales'
      end

    end
  end
end
