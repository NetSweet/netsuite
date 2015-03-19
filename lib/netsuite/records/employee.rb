module NetSuite
  module Records
    class Employee < Support::Base
      include Support::Actions
      include Support::RecordRefs
      include Namespaces::ListEmp

      # https://system.netsuite.com/help/helpcenter/en_US/srbrowser/Browser2014_1/script/record/employee.html

      actions :get, :get_list, :add, :update, :upsert, :upsert_list, :delete, :search

      fields :phone, :first_name, :last_name, :is_inactive, :email, :give_access, :send_email,
             :is_support_rep, :birth_date, :hire_date, :last_review_date, :next_review_date, :title,
             :home_phone, :office_phone, :eligible_for_commission, :is_sales_rep, :klass, :middle_name

      record_refs :location

      field :roles_list, RoleList

      attr_reader :internal_id
    end
  end
end
