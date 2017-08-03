module NetSuite
  module Records
    class Employee
      include Support::Records
      include Support::Fields
      include Support::Actions
      include Support::RecordRefs
      include Namespaces::ListEmp

      # https://system.netsuite.com/help/helpcenter/en_US/srbrowser/Browser2014_1/script/record/employee.html

      ACTIONS = %w{
        add
        delete
        get
        get_list
        search
        update
        upsert
        upsert_list
      }.map(&:to_sym).freeze

      actions *ACTIONS

      FIELDS = %w{
        account_number
        alien_number
        alt_name
        approval_limit
        bill_pay
        birth_date
        comments
        date_created
        direct_deposit
        eligible_for_commission
        email
        entity_id
        expense_limit
        fax
        first_name
        give_access
        hire_date
        home_phone
        is_inactive
        is_job_resource
        is_sales_rep
        is_support_rep
        job_description
        klass
        labor_cost
        last_modified_date
        last_name
        last_review_date
        middle_name
        mobile_phone
        next_review_date
        office_phone
        password
        password2
        pay_frequency
        phone
        phonetic_name
        purchase_order_approval_limit
        purchase_order_approver
        purchase_order_limit
        release_date
        resident_status
        salutation
        send_email
        social_security_number
        title
        visa_exp_date
        visa_type
      }.map(&:to_sym).freeze

      fields *FIELDS

      RECORD_REFS = %w{
        currency
        department
        employee_status
        employee_type
        location
        subsidiary
        supervisor
      }.map(&:to_sym).freeze

      record_refs *RECORD_REFS

      field :custom_field_list, CustomFieldList
      field :roles_list, RoleList

      attr_reader :internal_id
      attr_accessor :external_id

      def initialize(attributes = {})
        @internal_id = attributes.delete(:internal_id) || attributes.delete(:@internal_id)
        @external_id = attributes.delete(:external_id) || attributes.delete(:@external_id)
        initialize_from_attributes_hash(attributes)
      end

      def self.search_class_name
        'Employee'
      end

    end
  end
end
