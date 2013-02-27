module NetSuite
  module Records
    class Task
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Support::Actions
      include Namespaces::ActSched

      actions :get, :add, :delete, :update

      fields :title, :send_email, :message, :status, :access_level, :reminder_type,
             :reminder_minutes, :start_date, :end_date, :due_date, :timed_event

      field :contact_list, ContactList

      record_refs :assigned, :owner

      attr_reader   :internal_id
      attr_accessor :external_id

      def initialize(attrs = {})
        @internal_id = attributes.delete(:internal_id) || attributes.delete(:@internal_id)
        @external_id = attributes.delete(:external_id) || attributes.delete(:@external_id)
        initialize_from_attributes_hash(attrs)
      end
    end
  end
end
