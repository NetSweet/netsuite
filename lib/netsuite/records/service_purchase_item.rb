module NetSuite
  module Records
    class ServicePurchaseItem
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Support::Actions
      include Namespaces::ListAcct

      actions :get, :get_list, :add, :delete, :search, :upsert

      fields :amortization_period, :available_to_partners, :cost, :cost_units, :created_date, :currency, :display_name, :generate_accrurals, :include_children, :is_fulfillable, :is_inactive, :is_taxable, :item_id, :last_modified_date, :manufacturing_charge_item, :purchase_description, :purchase_order_amount, :purchase_order_quantity, :purchase_order_quantity_diff, :receipt_amount, :receipt_quantity, :receipt_quantity_diff, :residual, :upc_code, :vendor_name

      record_refs :klass, :cost_category, :custom_form, :department, :expense_account, :issue_product, :location, :parent, :purchase_tax_code, :sales_tax_code, :tax_schedule, :units_type

      field :custom_field_list, CustomFieldList
      field :subsidiary_list, RecordRefList


      attr_reader   :internal_id
      attr_accessor :external_id

      def initialize(attributes = {})
        @internal_id = attributes.delete(:internal_id) || attributes.delete(:@internal_id)
        @external_id = attributes.delete(:external_id) || attributes.delete(:@external_id)
        initialize_from_attributes_hash(attributes)
      end

      def self.search_class_name
        "Item"
      end
    end
  end
end
