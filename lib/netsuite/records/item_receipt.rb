module NetSuite
  module Records
    class ItemReceipt
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Support::Actions
      include Namespaces::TranPurch

      actions :get, :get_deleted, :get_list, :add, :initialize, :delete, :update, :upsert, :search

      fields :created_date, :currency_name, :exchange_rate, :landed_cost_per_line,
             :last_modified_date, :memo, :tran_date, :tran_id


      record_refs :created_from, :currency, :custom_form, :entity, :landed_cost_method,
                  :partner, :posting_period, :subsidiary


      # TODO
      # :expense_list
      # :landed_costs_list

      field :item_list, ItemReceiptItemList
      field :custom_field_list, CustomFieldList

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
