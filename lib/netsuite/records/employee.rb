module NetSuite
  module Records
    class Employee < Support::Base
      include Support::RecordRefs
      include Support::Actions
      include Namespaces::ListEmp

      # https://system.netsuite.com/help/helpcenter/en_US/srbrowser/Browser2014_1/script/record/employee.html

      actions :get, :get_list, :add, :update, :upsert, :upsert_list, :delete, :search

      fields :account_number, :alien_number, :approval_limit, :bill_pay,
             :birth_date, :comments, :currency, :date_created, :direct_deposit,
             :eligible_for_commission, :email, :employee_status, :employee_type,
             :entity_id, :expense_limit, :fax, :first_name, :give_access,
             :hire_date, :home_phone, :is_inactive, :is_job_resource,
             :is_support_rep, :job_description, :labor_cost, :last_modified_date,
             :last_name, :last_review_date, :middle_name, :mobile_phone,
             :next_review_date, :office_phone, :pay_frequency, :phone,
             :phonetic_name, :purchase_order_approval_limit,
             :purchase_order_approver, :purchase_order_limit, :release_date,
             :resident_status, :salutation, :send_email, :social_security_number,
             :title, :visa_exp_date, :visa_type

      field :roles_list, RoleList

      record_refs :currency, :department, :location, :subsidiary

      attr_reader :internal_id
    end
  end
end
