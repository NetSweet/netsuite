module NetSuite
  module Records
    class ItemOptionCustomField
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Support::Actions
      include Namespaces::SetupCustom

      actions :get, :get_list, :add, :delete, :update, :upsert, :upsert_list

      # http://www.netsuite.com/help/helpcenter/en_US/srbrowser/Browser2017_1/schema/record/ItemOptionCustomField.html
      fields(
        :access_level,
        :col_all_items,
        :col_kit_item,
        :col_opportunity,
        :col_option_label,
        :col_purchase,
        :col_sale,
        :col_store,
        :col_store_hidden,
        :col_transfer_order,
        :default_checked,
        :default_value,
        :description,
        :display_height,
        :display_width,
        :help,
        :is_formula,
        :is_mandatory,
        :label,
        :link_text,
        :max_length,
        :max_value,
        :min_value,
        :store_value
      )

      record_refs :owner, :source_list, :select_record_type, :source_filter_by, :source_from, :search_default, :search_compare_field, :insert_before, :default_selection

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
