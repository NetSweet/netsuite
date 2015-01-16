module NetSuite
  module Records
    class DiscountItem
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Support::Actions
      include Namespaces::ListAcct

      actions :get, :get_list, :add, :delete, :upsert

      fields :available_to_partners, :created_date, :description, :display_name, :include_children, :is_inactive, :is_pretax,
        :item_id, :last_modified_date, :non_posting, :rate, :upc_code, :vendor_name

      record_refs :account, :custom_form, :deferred_revenue_account, :department, :expense_account,
        :income_account, :issue_product, :klass, :location, :parent, :rev_rec_schedule, :sales_tax_code,
        :subsidiary_list, :tax_schedule

      field :custom_field_list, CustomFieldList

      attr_reader   :internal_id
      attr_accessor :external_id

      def initialize(attributes = {})
        @internal_id = attributes.delete(:internal_id) || attributes.delete(:@internal_id)
        @external_id = attributes.delete(:external_id) || attributes.delete(:@external_id)
        initialize_from_attributes_hash(attributes)
      end

    end
  end
end
