module NetSuite
  module Records
    class Task
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Support::Actions
      include Namespaces::ActSched

       actions :get, :add, :delete, :update

       fields :title, :send_email, :message, :status, :access_level, :reminder_type, :reminder_minutes,
              :start_date, :end_date, :due_date, :timed_event

       record_refs :assigned, :owner

       # TODO add contactList

       def initialize(attrs = {})
         initialize_from_attributes_hash(attrs)
       end
  	end
  end
end
