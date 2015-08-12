module NetSuite
  module Records
    class Employee < Support::Base
      include Support::Actions
      include Support::RecordRefs
      include Namespaces::ListEmp

      # https://system.netsuite.com/help/helpcenter/en_US/srbrowser/Browser2014_1/script/record/employee.html

      actions :get, :get_list, :add, :update, :upsert, :upsert_list, :delete, :search

      fields :phone, :first_name, :last_name, :is_inactive, :email, :give_access, :send_email, :is_support_rep,
             :birth_date, :hire_date, :last_review_date, :next_review_date, :title, :home_phone, :office_phone,
             :eligible_for_commission, :is_sales_rep, :klass, :middle_name, :account_number, :alien_number, :approval_limit,
             :bill_pay, :comments, :date_created, :direct_deposit, :entity_id, :password, :password2,
             :expense_limit, :fax, :is_job_resource, :job_description, :labor_cost, :last_modified_date, :mobile_phone, :pay_frequency,
             :phonetic_name, :purchase_order_approval_limit, :purchase_order_approver, :purchase_order_limit, :release_date,
             :resident_status, :salutation, :social_security_number, :visa_exp_date, :visa_type

      record_refs :currency, :department, :location, :subsidiary, :employee_type, :employee_status, :supervisor

      field :roles_list, RoleList

      attr_reader :internal_id
      attr_accessor :external_id

    end
  end
end
