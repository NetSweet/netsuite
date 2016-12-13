module NetSuite
  module Records
    class DescriptionItem
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Support::Actions
      include Namespaces::ListAcct

      actions :get, :get_list, :add, :delete, :search, :update, :upsert

      fields :available_to_partners, :created_date, :description, :include_children, :is_inactive, :item_id, :last_modified_date

      record_refs :custom_form, :department, :issue_product, :klass, :location
      
      field :custom_field_list, CustomFieldList
      field :subsidiary_list, RecordRefList
      # TODO field :translations_list, TranslationList

      attr_reader :internal_id
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
		