require 'spec_helper'

describe NetSuite::Records::Job do
  let(:job) { NetSuite::Records::Job.new }

  #<element name="estimatedTimeOverride" type="platformCore:Duration" minOccurs="0"/>
  #<element name="emailPreference" type="listRelTyp:EmailPreference" minOccurs="0"/>
  #<element name="jobBillingType" type="listRelTyp:JobBillingType" minOccurs="0"/>
  #<element name="actualTime" type="platformCore:Duration" minOccurs="0"/>
  #<element name="timeRemaining" type="platformCore:Duration" minOccurs="0"/>
  #<element name="globalSubscriptionStatus" type="platformCommonTyp:GlobalSubscriptionStatus" minOccurs="0"/>
  #<element name="jobResourcesList" type="listRel:JobResourcesList" minOccurs="0"/>
  #<element name="addressbookList" type="listRel:JobAddressbookList" minOccurs="0"/>
  #<element name="milestonesList" type="listRel:JobMilestonesList" minOccurs="0"/>
  #<element name="creditCardsList" type="listRel:JobCreditCardsList" minOccurs="0"/>
  #<element name="customFieldList" type="platformCore:CustomFieldList" minOccurs="0"/>

  it 'has all the right fields' do
    [
      :account_number, :allocate_payroll_expenses, :allow_all_resources_for_tasks, :allow_expenses, :allow_time, :alt_name,
      :alt_phone, :bill_pay, :calculated_end_date, :calculated_end_date_baseline, :comments, :company_name, :date_created,
      :default_address, :email, :end_date, :entity_id, :estimated_cost, :estimated_gross_profit, :estimated_gross_profit_percent,
      :estimated_labor_cost, :estimated_labor_cost_baseline, :estimated_labor_revenue, :estimated_revenue, :estimated_time, :fax,
      :fx_rate, :include_crm_tasks_in_totals, :is_exempt_time, :is_inactive, :is_productive_time, :is_utilized_time, :job_price,
      :last_baseline_date, :last_modified_date, :limit_time_to_assignees, :materialize_time, :opening_balance,
      :opening_balance_account, :opening_balance_date, :percent_complete, :percent_time_complete, :phone, :phonetic_name,
      :projected_end_date, :projected_end_date_baseline, :start_date, :start_date_baseline
    ].each do |field|
      job.should have_field(field)
    end
  end

  it 'has all the right record refs' do
    [
      :billing_schedule, :category, :currency, :custom_form, :entity_status, :estimate_rev_rec_template, :job_item, :job_type, :language, :parent, :subsidiary, :workplace
    ].each do |record_ref|
      job.should have_record_ref(record_ref)
    end
  end

end
