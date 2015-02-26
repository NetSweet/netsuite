module NetSuite
  module Records
    class Employee < Support::Base
      include Support::Fields
      include Support::Actions
      include Support::RecordRefs
      include Namespaces::ListEmp

      # https://system.netsuite.com/help/helpcenter/en_US/srbrowser/Browser2014_1/script/record/employee.html

      actions :get, :get_list, :add, :update, :upsert, :upsert_list, :delete, :search

      fields :email, :first_name, :give_access, :is_inactive, :is_sales_rep,
             :klass, :last_name, :middle_name, :phone, :send_email

      record_refs :location

      field :roles_list, RoleList

      attr_reader :internal_id
    end
  end
end
