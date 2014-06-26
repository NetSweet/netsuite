require 'spec_helper'

describe NetSuite::Records::AccountingPeriod do
  let(:accounting_period) { NetSuite::Records::AccountingPeriod.new }

  it 'has all the right fields' do
    [
      :allow_non_gl_changes, :end_date, :is_adjust, :is_quarter, :is_year, :period_name, :start_date
    ].each do |field|
      expect(accounting_period).to have_field(field)
    end
  end

  it 'has all the right record refs' do
    [
      :parent
    ].each do |record_ref|
      expect(accounting_period).to have_record_ref(record_ref)
    end
  end

  describe '.get' do
    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :period_name => 'Accounting Period 1' }) }

      it 'returns a Account instance populated with the data from the response object' do
        expect(NetSuite::Actions::Get).to receive(:call).with([NetSuite::Records::AccountingPeriod, {:external_id => 1}], {}).and_return(response)
        accounting_period = NetSuite::Records::AccountingPeriod.get(:external_id => 1)
        expect(accounting_period).to be_kind_of(NetSuite::Records::AccountingPeriod)
        expect(accounting_period.period_name).to eql('Accounting Period 1')
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'raises a RecordNotFound exception' do
        expect(NetSuite::Actions::Get).to receive(:call).with([NetSuite::Records::AccountingPeriod, {:external_id => 1}], {}).and_return(response)
        expect {
          NetSuite::Records::AccountingPeriod.get(:external_id => 1)
        }.to raise_error(NetSuite::RecordNotFound,
          /NetSuite::Records::AccountingPeriod with OPTIONS=(.*) could not be found/)
      end
    end
  end

  describe '#add' do
    let(:test_data) { { :acct_name => 'Test Accounting Period', :description => 'An example accounting period' } }

    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :internal_id => '1' }) }

      it 'returns true' do
        accounting_period = NetSuite::Records::AccountingPeriod.new(test_data)
        expect(NetSuite::Actions::Add).to receive(:call).
            with([accounting_period], {}).
            and_return(response)
        expect(accounting_period.add).to be_truthy
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'returns false' do
        accounting_period = NetSuite::Records::AccountingPeriod.new(test_data)
        expect(NetSuite::Actions::Add).to receive(:call).
            with([accounting_period], {}).
            and_return(response)
        expect(accounting_period.add).to be_falsey
      end
    end
  end

  describe '#delete' do
    let(:test_data) { { :internal_id => '1' } }

    context 'when the response is successful' do
      let(:response)  { NetSuite::Response.new(:success => true, :body => { :internal_id => '1' }) }

      it 'returns true' do
        accounting_period = NetSuite::Records::AccountingPeriod.new(test_data)
        expect(NetSuite::Actions::Delete).to receive(:call).
            with([accounting_period], {}).
            and_return(response)
        expect(accounting_period.delete).to be_truthy
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'returns false' do
        accounting_period = NetSuite::Records::AccountingPeriod.new(test_data)
        expect(NetSuite::Actions::Delete).to receive(:call).
            with([accounting_period], {}).
            and_return(response)
        expect(accounting_period.delete).to be_falsey
      end
    end
  end

end
