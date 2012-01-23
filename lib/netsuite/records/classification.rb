module NetSuite
  module Records
    class Classification
      include Support::Fields
      include Support::Actions

      actions :get

      fields :name, :include_children, :is_inactive, :class_translation_list, :subsidiary_list, :custom_field_list

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
