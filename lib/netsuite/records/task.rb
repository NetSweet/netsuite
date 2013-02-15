module NetSuite
  module Records
    class Task
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Support::Actions
      include Namespaces::ActSched

       actions :get, :add, :delete, :update

       fields :title, :send_email

       record_refs :assigned


  	end

  end
end
