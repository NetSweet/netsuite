module NetSuite
  module Records
    class VendorCredit
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Support::Actions
      include Namespaces::TranPurch

      actions :add, :get, :get_list, :update, :delete, :initialize, :search

      fields :created_date,  :un_applied, :last_modified_date,
             :auto_apply,    :applied,    :transaction_number,
             :tran_id,       :total,      :user_total,
             :currency_name, :tran_date,  :exchange_rate,
             :memo

      record_refs :custom_form, :account, :bill_address_list, :created_from, :entity, :currency, :post_period, :department, :klass, :location, :subsidiary

      field :billing_address,    Address
      field :expense_list,       VendorCreditExpenseList
      field :item_list,          VendorCreditItemList
      field :apply_list,         VendorCreditApplyList
      field :custom_field_list,  CustomFieldList
      field :null_field_list,    NullFieldList

      attr_reader :internal_id
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
