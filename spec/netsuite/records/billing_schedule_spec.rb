require 'spec_helper'

describe NetSuite::Records::BillingSchedule do
  let(:billing_schedule) { NetSuite::Records::BillingSchedule.new }

  it 'has all the right fields' do
    [
      :bill_for_actuals, :day_period, :frequency, :in_arrears, :initial_amount, :is_inactive,
      :is_public, :milestone_list, :month_dom, :month_dow, :month_dowim, :month_mode, :name,
      :number_remaining, :recurrence_dow_mask_list, :recurrence_list, :repeat_every, 
      :schedule_type, :series_start_date, :year_dom, :year_dow,
      :year_dowim, :year_dowim_month, :year_mode, :year_month
    ].each do |field|
      billing_schedule.should have_field(field)
    end
  end

  it 'has all the right record refs' do
    [
      :initial_terms, :project, :recurrence_terms, :transaction
    ].each do |record_ref|
      billing_schedule.should have_record_ref(record_ref)
    end
  end

  describe '.get' do
    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :name => 'Billing Scheduleing 1' }) }

      it 'returns a Billing Schedule instance populated with the data from the response object' do
        NetSuite::Actions::Get.should_receive(:call).with([NetSuite::Records::BillingSchedule, {:external_id => 1}], {}).and_return(response)
        billing_schedule = NetSuite::Records::BillingSchedule.get(:external_id => 1)
        billing_schedule.should be_kind_of(NetSuite::Records::BillingSchedule)
        billing_schedule.name.should eql('Billing Scheduleing 1')
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'raises a RecordNotFound exception' do
        NetSuite::Actions::Get.should_receive(:call).with([NetSuite::Records::BillingSchedule, {:external_id => 1}], {}).and_return(response)
        lambda {
          NetSuite::Records::BillingSchedule.get(:external_id => 1)
        }.should raise_error(NetSuite::RecordNotFound,
          /NetSuite::Records::BillingSchedule with OPTIONS=(.*) could not be found/)
      end
    end
  end

  describe ".search" do
    context 'when the response is successful' do

      it 'returns a Billing Schedule instance populated with the data from the response object' do
        body = {
          total_records: 2,
          record_list: {
            record: [
              {:bill_for_actuals => true},
              {:bill_for_actuals => false}
            ]
          }
        }

        allow(NetSuite::Actions::Search).to receive(:call).with(
          [NetSuite::Records::BillingSchedule, {:external_id => 1}], {}
        ).and_return(
          NetSuite::Response.new(:success => true, :body => body)
        )

        search_result = NetSuite::Records::BillingSchedule.search(:external_id => 1)

        expect(search_result).to be_a NetSuite::Support::SearchResult
        expect(search_result.total_records).to eq 2

        schd1, schd2 = search_result.results

        expect(schd1).to be_a NetSuite::Records::BillingSchedule
        expect(schd1.bill_for_actuals).to eq true

        expect(schd2).to be_a NetSuite::Records::BillingSchedule
        expect(schd2.bill_for_actuals).to eq false
      end
    end
  end

  describe '#add' do
    let(:test_data) { { :bill_for_actuals => true, :day_period => 7 } }

    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :internal_id => '1' }) }

      it 'returns true' do
        billing_schedule = NetSuite::Records::BillingSchedule.new(test_data)
        NetSuite::Actions::Add.should_receive(:call).
            with([billing_schedule], {}).
            and_return(response)
        billing_schedule.add.should be_truthy
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'returns false' do
        billing_schedule = NetSuite::Records::BillingSchedule.new(test_data)
        NetSuite::Actions::Add.should_receive(:call).
            with([billing_schedule], {}).
            and_return(response)
        billing_schedule.add.should be_falsey
      end
    end
  end

  describe '#delete' do
    let(:test_data) { { :internal_id => '1' } }

    context 'when the response is successful' do
      let(:response)  { NetSuite::Response.new(:success => true, :body => { :internal_id => '1' }) }

      it 'returns true' do
        billing_schedule = NetSuite::Records::BillingSchedule.new(test_data)
        NetSuite::Actions::Delete.should_receive(:call).
            with([billing_schedule], {}).
            and_return(response)
        billing_schedule.delete.should be_truthy
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'returns false' do
        billing_schedule = NetSuite::Records::BillingSchedule.new(test_data)
        NetSuite::Actions::Delete.should_receive(:call).
            with([billing_schedule], {}).
            and_return(response)
        billing_schedule.delete.should be_falsey
      end
    end
  end
end
