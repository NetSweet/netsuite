module NetSuite
  module Records
    class Job
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Support::Actions
      include Namespaces::ListRel

      actions :get, :get_list, :add, :delete, :search, :update, :upsert

      fields :account_number, :allocate_payroll_expenses, :allow_all_resources_for_tasks, :allow_expenses, :allow_time,
        :alt_name, :alt_phone, :bill_pay, :calculated_end_date, :calculated_end_date_baseline, :comments, :company_name,
        :date_created, :default_address, :email, :email_preference, :end_date, :entity_id, :estimated_cost,
        :estimated_gross_profit, :estimated_gross_profit_percent, :estimated_labor_cost, :estimated_labor_cost_baseline,
        :estimated_labor_revenue, :estimated_revenue, :estimated_time, :fax, :fx_rate, :global_subscription_status,
        :include_crm_tasks_in_totals, :is_exempt_time, :is_inactive, :is_productive_time, :is_utilized_time, :job_billing_type,
        :job_price, :last_baseline_date, :last_modified_date, :limit_time_to_assignees, :materialize_time, :opening_balance,
        :opening_balance_account, :opening_balance_date, :percent_complete, :percent_time_complete, :phone, :phonetic_name,
        :projected_end_date, :projected_end_date_baseline, :start_date, :start_date_baseline

      field :estimated_time_override, Duration
      field :actual_time,             Duration
      field :time_remaining,          Duration
      field :custom_field_list,       CustomFieldList

      record_refs :billing_schedule, :category, :currency, :custom_form, :entity_status, :estimate_rev_rec_template, :job_item,
        :job_type, :language, :parent, :subsidiary, :workplace, :customer

      attr_reader :internal_id
      attr_accessor :external_id

      def initialize(attributes = {})
        @internal_id = attributes.delete(:internal_id) || attributes.delete(:@internal_id)
        @external_id = attributes.delete(:external_id) || attributes.delete(:@external_id)
        initialize_from_attributes_hash(attributes)
      end

    end
  end
end
