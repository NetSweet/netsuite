require 'spec_helper'

describe NetSuite::Records::Job do
  let(:job) { NetSuite::Records::Job.new }

  #<element name="emailPreference" type="listRelTyp:EmailPreference" minOccurs="0"/>
  #<element name="jobBillingType" type="listRelTyp:JobBillingType" minOccurs="0"/>
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

  describe '#estimated_time_override' do
    it 'can be set from attributes' do
      attributes = {
        :time_span => 10
      }
      job.estimated_time_override = attributes
      job.estimated_time_override.should be_kind_of(NetSuite::Records::Duration)
      job.estimated_time_override.time_span.should eql(10)
    end

    it 'can be set from a Duration object' do
      duration = NetSuite::Records::Duration.new
      job.estimated_time_override = duration
      job.estimated_time_override.should eql(duration)
    end
  end

  describe '#actual_time' do
    it 'can be set from attributes' do
      attributes = {
        :time_span => 20
      }
      job.actual_time = attributes
      job.actual_time.should be_kind_of(NetSuite::Records::Duration)
      job.actual_time.time_span.should eql(20)
    end

    it 'can be set from a Duration object' do
      duration = NetSuite::Records::Duration.new
      job.actual_time = duration
      job.actual_time.should eql(duration)
    end
  end

  describe '#time_remaining' do
    it 'can be set from attributes' do
      attributes = {
        :time_span => 30
      }
      job.time_remaining = attributes
      job.time_remaining.should be_kind_of(NetSuite::Records::Duration)
      job.time_remaining.time_span.should eql(30)
    end

    it 'can be set from a Duration object' do
      duration = NetSuite::Records::Duration.new
      job.time_remaining = duration
      job.time_remaining.should eql(duration)
    end
  end

end
