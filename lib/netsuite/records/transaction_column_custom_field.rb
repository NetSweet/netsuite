module NetSuite
  module Records
    class TransactionColumnCustomField
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Support::Actions
      include Namespaces::SetupCustom

      actions :get, :get_list, :add, :delete, :update, :upsert, :upsert_list

      # http://www.netsuite.com/help/helpcenter/en_US/srbrowser/Browser2017_1/schema/record/transactioncolumncustomfield.html
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
        :col_store_hidden,
        :col_journal,
        :col_expense_report,
        :col_time,
        :col_transfer_order,
        :col_item_receipt,
        :col_item_receipt_order,
        :col_item_fulfillment,
        :col_item_fulfillment_order,
        :col_print_flag,
        :col_picking_ticket,
        :col_packing_slip,
        :col_return_form,
        :col_store_with_groups,
        :col_group_on_invoices,
        :col_kit_item,
        :access_level,
        :search_level,
        :field_type,
        :script_id
      )

      record_refs :owner

      attr_reader :internal_id
      attr_accessor :external_id

      def initialize(attributes = {})
        @internal_id = attributes.delete(:internal_id) || attributes.delete(:@internal_id)
        @external_id = attributes.delete(:external_id) || attributes.delete(:@external_id)
        initialize_from_attributes_hash(attributes)
      end
    end
  end
end
