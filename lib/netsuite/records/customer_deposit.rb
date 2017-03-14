module NetSuite
  module Records

    # https://system.netsuite.com/help/helpcenter/en_US/srbrowser/Browser2014_1/schema/record/customerdeposit.html

    class CustomerDeposit
      include Support::Actions
      include Support::RecordRefs
      include Support::Fields
      include Support::Records
      include Namespaces::TranCust

      actions :get, :get_list, :initialize, :add, :delete, :update, :upsert, :search

      fields :created_date, :last_modified_date, :status, :payment, :tran_date, :exchange_rate, :undep_funds, :memo,
             :check_num, :klass, :currency_name, :is_recurring_payment, :charge_it

      field :custom_field_list, CustomFieldList

      record_refs :customer, :sales_order, :account, :department, :payment_method,
                  :custom_form, :currency, :posting_period, :subsidiary,

                  # only available in an advanced search result
                  :deposit_transaction

      attr_reader :internal_id
      attr_accessor :external_id
      attr_accessor :search_joins

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
