require 'spec_helper'

describe NetSuite::Records::Job do
  let(:job) { NetSuite::Records::Job.new }

  it 'has all the right fields' do
    [
      :account_number, :allocate_payroll_expenses, :allow_all_resources_for_tasks, :allow_expenses, :allow_time, :alt_name,
      :alt_phone, :bill_pay, :calculated_end_date, :calculated_end_date_baseline, :comments, :company_name, :date_created,
      :default_address, :email, :email_preference, :end_date, :entity_id, :estimated_cost, :estimated_gross_profit,
      :estimated_gross_profit_percent, :estimated_labor_cost, :estimated_labor_cost_baseline, :estimated_labor_revenue,
      :estimated_revenue, :estimated_time, :fax, :fx_rate, :global_subscription_status, :include_crm_tasks_in_totals,
      :is_exempt_time, :is_inactive, :is_productive_time, :is_utilized_time, :job_billing_type, :job_price, :last_baseline_date,
      :last_modified_date, :limit_time_to_assignees, :materialize_time, :opening_balance, :opening_balance_account,
      :opening_balance_date, :percent_complete, :percent_time_complete, :phone, :phonetic_name, :projected_end_date,
      :projected_end_date_baseline, :start_date, :start_date_baseline
    ].each do |field|
      expect(job).to have_field(field)
    end
  end

  it 'has all the right record refs' do
    [
      :billing_schedule, :category, :currency, :custom_form, :entity_status, :estimate_rev_rec_template, :job_item, :job_type, :language, :parent, :subsidiary, :workplace
    ].each do |record_ref|
      expect(job).to have_record_ref(record_ref)
    end
  end

  describe '#estimated_time_override' do
    it 'can be set from attributes' do
      attributes = {
        :time_span => 10
      }
      job.estimated_time_override = attributes
      expect(job.estimated_time_override).to be_kind_of(NetSuite::Records::Duration)
      expect(job.estimated_time_override.time_span).to eql(10)
    end

    it 'can be set from a Duration object' do
      duration = NetSuite::Records::Duration.new
      job.estimated_time_override = duration
      expect(job.estimated_time_override).to eql(duration)
    end
  end

  describe '#actual_time' do
    it 'can be set from attributes' do
      attributes = {
        :time_span => 20
      }
      job.actual_time = attributes
      expect(job.actual_time).to be_kind_of(NetSuite::Records::Duration)
      expect(job.actual_time.time_span).to eql(20)
    end

    it 'can be set from a Duration object' do
      duration = NetSuite::Records::Duration.new
      job.actual_time = duration
      expect(job.actual_time).to eql(duration)
    end
  end

  describe '#time_remaining' do
    it 'can be set from attributes' do
      attributes = {
        :time_span => 30
      }
      job.time_remaining = attributes
      expect(job.time_remaining).to be_kind_of(NetSuite::Records::Duration)
      expect(job.time_remaining.time_span).to eql(30)
    end

    it 'can be set from a Duration object' do
      duration = NetSuite::Records::Duration.new
      job.time_remaining = duration
      expect(job.time_remaining).to eql(duration)
    end
  end

  describe '#job_resources_list' do
    it 'can be set from attributes'
    it 'can be set from a JobResourcesList object'
  end

  describe '#addressbook_list' do
    it 'can be set from attributes'
    it 'can be set from a JobAddressbookList object'
  end

  describe '#milestones_list' do
    it 'can be set from attributes'
    it 'can be set from a JobMilestonesList object'
  end

  describe '#credit_cards_list' do
    it 'can be set from attributes'
    it 'can be set from a JobCreditCardsList object'
  end

  describe '#custom_field_list' do
    it 'can be set from attributes'
    it 'can be set from a CustomFieldList object'
  end

  describe '.get' do
    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :account_number => 7 }) }

      it 'returns a Job instance populated with the data from the response object' do
        expect(NetSuite::Actions::Get).to receive(:call).with([NetSuite::Records::Job, {:external_id => 1}], {}).and_return(response)
        job = NetSuite::Records::Job.get(:external_id => 1)
        expect(job).to be_kind_of(NetSuite::Records::Job)
        expect(job.account_number).to be_truthy
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'raises a RecordNotFound exception' do
        expect(NetSuite::Actions::Get).to receive(:call).with([NetSuite::Records::Job, {:external_id => 1}], {}).and_return(response)
        expect {
          NetSuite::Records::Job.get(:external_id => 1)
        }.to raise_error(NetSuite::RecordNotFound,
          /NetSuite::Records::Job with OPTIONS=(.*) could not be found/)
      end
    end
  end

  describe '#add' do
    let(:job) { NetSuite::Records::Job.new(:account_number => 7, :job_price => 10) }

    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :internal_id => '1' }) }

      it 'returns true' do
        expect(NetSuite::Actions::Add).to receive(:call).
            with([job], {}).
            and_return(response)
        expect(job.add).to be_truthy
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'returns false' do
        expect(NetSuite::Actions::Add).to receive(:call).
            with([job], {}).
            and_return(response)
        expect(job.add).to be_falsey
      end
    end
  end

  describe '#delete' do
    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :internal_id => '1' }) }

      it 'returns true' do
        expect(NetSuite::Actions::Delete).to receive(:call).
            with([job], {}).
            and_return(response)
        expect(job.delete).to be_truthy
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'returns false' do
        expect(NetSuite::Actions::Delete).to receive(:call).
            with([job], {}).
            and_return(response)
        expect(job.delete).to be_falsey
      end
    end
  end

  describe '.update' do
    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :account_number => 7 }) }

      it 'returns true' do
        expect(NetSuite::Actions::Update).to receive(:call).with([NetSuite::Records::Job, {:external_id => 1, :account_number => 7}], {}).and_return(response)
        job = NetSuite::Records::Job.new(:external_id => 1)
        expect(job.update(:account_number => 7)).to be_truthy
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'raises a RecordNotFound exception' do
        expect(NetSuite::Actions::Update).to receive(:call).with([NetSuite::Records::Job, {:internal_id => 1, :account_number => 7}], {}).and_return(response)
        job = NetSuite::Records::Job.new(:internal_id => 1)
        expect(job.update(:account_number => 7)).to be_falsey
      end
    end
  end

  describe '.search' do
    it 'searches'
  end

  describe '#to_record' do
    let(:job) { NetSuite::Records::Job.new(:entity_id => 'TEST JOB', :account_number => 7) }

    it 'returns a hash of attributes that can be used in a SOAP request' do
      expect(job.to_record).to eql({
        'listRel:entityId'      => 'TEST JOB',
        'listRel:accountNumber' => 7
      })
    end
  end

  describe '#record_type' do
    it 'returns a string type for the record to be used in a SOAP request' do
      expect(job.record_type).to eql('listRel:Job')
    end
  end

end
