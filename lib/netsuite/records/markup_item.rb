module NetSuite
  module Records
    class MarkupItem
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Support::Actions
      include Namespaces::ListAcct

      actions :get, :get_deleted, :get_list, :add, :delete, :search, :upsert, :update, :update_list

      fields :cost,
             :created_date,
             :display_name,
             :is_inactive,
             :item_id,
             :last_modified_date,
             :purchase_description

      record_refs :klass,
                  :department,
                  :account,
                  :location,
                  :tax_schedule

      field :custom_field_list, CustomFieldList

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
