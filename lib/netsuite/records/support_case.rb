module NetSuite
  module Records
    class SupportCase
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Support::Actions
      include Namespaces::ListSupport

      actions :get, :get_list, :add, :delete, :update, :upsert, :search

      fields :end_date, :incoming_message, :outgoing_message, :search_solution, :email_form, 
             :internal_only, :title, :case_number, :start_date, :email, :phone, :inbound_email, 
             :is_inactive, :help_desk
      
      field :custom_field_list, CustomFieldList

      read_only_fields :created_date, :last_modified_date, :last_message_date

      record_refs :custom_form, :company, :contact, :issue, :status, :priority, :origin, :category, :assigned

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
