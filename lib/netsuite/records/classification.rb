module NetSuite
  module Records
    class Classification
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Support::Actions
      include Namespaces::ListAcct

      actions :add, :get, :get_list, :delete, :upsert, :search

      fields :name, :include_children, :is_inactive, :class_translation_list, :custom_field_list, :parent

      field :subsidiary_list, RecordRefList

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
