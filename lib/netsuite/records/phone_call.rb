module NetSuite
  module Records
    class PhoneCall
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Support::Actions
      include Namespaces::ActSched

      actions :get, :get_list, :add, :delete, :update, :upsert

      fields :title, :message, :phone, :status, :priority, :start_date, :end_date,
        :start_time, :end_time, :completed_date, :timed_event, :access_level

      field :contact_list, ContactList

      record_refs :assigned, :owner, :company, :contact

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
