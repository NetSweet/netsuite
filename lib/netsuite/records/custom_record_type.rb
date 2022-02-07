module NetSuite
  module Records
    class CustomRecordType
      include Support::Fields
      include Support::RecordRefs
      include Support::Actions

      actions :get, :get_list, :add, :delete, :upsert

      fields :allow_attachments, :allow_inline_editing, :allow_numbering_override, :allow_quick_search, :description,
        :disclaimer, :enable_mail_merge, :enable_numbering, :include_name, :is_available_offline, :is_inactive,
        :is_numbering_updateable, :is_ordered, :numbering_current_number, :numbering_init, :numbering_min_digits,
        :numbering_prefix, :numbering_suffix, :record_name, :script_id, :show_creation_date, :show_creation_date_on_list,
        :show_id, :show_last_modified, :show_last_modified_on_list, :show_notes, :show_owner, :show_owner_allow_change,
        :show_owner_on_list, :use_permissions

      record_ref :owner
      record_ref :forms_list
      record_ref :permissions_list
      record_ref :custom_field_list

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
