module NetSuite
  module Records
    class ItemReceipt
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Support::Actions
      include Namespaces::TranPurch

      actions :get, :add, :delete, :update, :initialize

      fields :created_date, :last_modified_date, :exchange_rate, :currency_name,
        :tran_date, :tran_id, :memo, :landed_cost_method

      field :custom_field_list, CustomFieldList
      field :item_list, ItemReceiptItemList
      field :expense_list, ItemReceiptExpenseList
      field :landed_cost_list, PurchLandedCostList

      record_refs :custom_form, :entity, :subsidiary, :created_from, :partner,
        :posting_period, :currency

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


    end
  end
end
