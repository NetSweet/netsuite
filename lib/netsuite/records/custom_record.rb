module NetSuite
  module Records
    class CustomRecord
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Support::Actions
      include Namespaces::SetupCustom

      actions :get, :update, :get_list, :add, :delete, :search, :upsert

      fields :allow_attachments, :allow_inline_editing, :allow_numbering_override, :allow_quick_search, :alt_name, :auto_name,
        :created, :custom_record_id, :description, :disclaimer, :enabl_email_merge, :enable_numbering, :include_name,
        :is_available_offline, :is_inactive, :is_numbering_updateable, :is_ordered, :last_modified, :name,
        :numbering_current_number, :numbering_init, :numbering_min_digits, :numbering_prefix, :numbering_suffix,
        :record_name, :script_id, :show_creation_date, :show_creation_date_on_list, :show_id, :show_last_modified_on_list,
        :show_last_modified, :show_notes, :show_owner, :show_owner_allow_change, :show_owner_on_list, :use_permissions

      field :custom_field_list, CustomFieldList
      field :translations_list, TranslationList

      record_refs :custom_form, :owner, :rec_type, :parent

      attr_reader :internal_id
      attr_accessor :external_id

      def initialize(attributes = {})
        @internal_id = attributes.delete(:internal_id) || attributes.delete(:@internal_id)
        @external_id = attributes.delete(:external_id) || attributes.delete(:@external_id)
        initialize_from_attributes_hash(attributes)
      end

      def self.get(options = {})
        options.merge!(:type_id => type_id) unless options[:type_id]
        super(options.merge(:custom => true))
      end

      def delete
        super(:custom => true)
      end

      def self.type_id(id = nil)
        if id
          @type_id = id
        end

        @type_id
      end

      def record_type
        "#{record_namespace}:CustomRecord"
      end

    end
  end
end
