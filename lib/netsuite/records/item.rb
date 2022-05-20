module NetSuite
  module Records
    class Item
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Support::Actions
      include Namespaces::ListAcct

      actions :search

      fields :created_date,
             :last_modified_date,
             :purchase_description,
             :expense_account,
             :item_id,
             :display_name,
             :include_children,
             :is_inactive,
             :tax_schedule,
             :deferral_account,
             :is_fulfillable,
             :generate_accruals,
             :currency

      field :custom_field_list,    CustomFieldList

      attr_reader   :internal_id
      attr_accessor :external_id

      def initialize(attributes = {})
        @internal_id = attributes.delete(:internal_id) || attributes.delete(:@internal_id)
        @external_id = attributes.delete(:external_id) || attributes.delete(:@external_id)
        @xsi_type = attributes.delete(:"xsi:type") || attributes.delete(:"@xsi:type")
        @item_type = determin_item_type(attributes) if @xsi_type
        initialize_from_attributes_hash(attributes)
      end

      def determin_item_type(attributes)
        @xsi_type.split(":").last
      end

    end
  end
end
