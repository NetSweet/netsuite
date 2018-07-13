module NetSuite
  module Records
    class TransactionColumnCustomField
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Support::Actions
      include Namespaces::SetupCustom

      actions :get, :get_all, :get_list, :add, :initialize, :delete, :update, :upsert, :upsert_list

      fields(
        :label,
        :store_value,
        :display_type,
        :is_mandatory,
        :default_checked,
        :is_formula,
        :col_expense,
        :col_purchase,
        :col_sale,
        :col_opportunity,
        :col_store,
        :col_storeHidden,
        :col_journal,
        :col_expenseReport,
        :col_time,
        :col_transferOrder,
        :col_itemReceipt,
        :col_itemReceiptOrder,
        :col_itemFulfillment,
        :col_itemFulfillmentOrder,
        :col_printFlag,
        :col_pickingTicket,
        :col_packingSlip,
        :col_returnForm,
        :col_storeWithGroups,
        :col_groupOnInvoices,
        :col_kitItem,
        :access_level,
        :search_level,
        :field_type,
        :script_id
      )

      record_refs :owner

      attr_reader :internal_id
      attr_accessor :external_id
      attr_accessor :search_joins

      def initialize(attributes = {})
        @internal_id = attributes.delete(:internal_id) || attributes.delete(:@internal_id)
        @external_id = attributes.delete(:external_id) || attributes.delete(:@external_id)
        initialize_from_attributes_hash(attributes)
      end
    end
  end
end
