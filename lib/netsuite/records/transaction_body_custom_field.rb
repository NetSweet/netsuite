module NetSuite
  module Records
    class TransactionBodyCustomField
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Support::Actions
      include Namespaces::SetupCustom

      actions :get, :get_list, :add, :delete, :update, :upsert, :upsert_list

      # http://www.netsuite.com/help/helpcenter/en_US/srbrowser/Browser2017_1/schema/record/transactionbodycustomfield.html
      fields(
        :label,
        :store_value,
        :display_type,
        :is_mandatory,
        :default_checked,
        :is_formula,
        :body_assembly_build,
        :body_bom,
        :body_b_tegata,
        :body_customer_payment,
        :body_deposit,
        :body_expense_report,
        :body_inventory_adjustment,
        :body_item_fulfillment,
        :body_item_fulfillment_order,
        :body_item__receipt,
        :body_item__receipt_order,
        :body_journal,
        :body_opportunity,
        :body_other_transaction,
        :body_picking_ticket,
        :body_print_flag,
        :body_print_packing_slip,
        :body_print_statement,
        :body_purchase,
        :body_sale,
        :body_store,
        :body_transfer_order,
        :body_vendor_payment,
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
