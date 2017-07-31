module NetSuite
  module Records
    class Task
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Support::Actions
      include Namespaces::ActSched

      actions :get, :get_list, :add, :search, :delete, :update, :upsert

      fields :title, :send_email, :message, :status, :access_level, :reminder_type,
             :reminder_minutes, :start_date, :end_date, :due_date, :timed_event,
             :created_date, :last_modified_date, :priority

      field :contact_list, ContactList
      field :custom_field_list, CustomFieldList

      record_refs :assigned, :owner, :company, :contact, :transaction

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
