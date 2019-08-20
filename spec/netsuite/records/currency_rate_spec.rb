require 'spec_helper'

describe NetSuite::Records::CurrencyRate do
  let(:currency_rate) { NetSuite::Records::CurrencyRate.new }

  it 'has all the right fields' do
    [
      :effective_date, :exchange_rate
    ].each do |field|
      expect(currency_rate).to have_field(field)
    end
  end
  
  it 'has the right record_refs' do
    [
      :base_currency, :transaction_currency
    ].each do |record_ref|
      expect(currency_rate).to have_record_ref(record_ref)
    end
  end
  
  describe '.get' do
    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :exchange_rate => '1.0', :effective_date => DateTime.now }) }

      it 'returns an Invoice instance populated with the data from the response object' do
        expect(NetSuite::Actions::Get).to receive(:call).with([NetSuite::Records::CurrencyRate, {:internal_id => 1}], {}).and_return(response)
        currency_rate = NetSuite::Records::CurrencyRate.get(:internal_id => 1)
        expect(currency_rate).to be_kind_of(NetSuite::Records::CurrencyRate)
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'raises a RecordNotFound exception' do
        expect(NetSuite::Actions::Get).to receive(:call).with([NetSuite::Records::CurrencyRate, {:internal_id => 1}], {}).and_return(response)
        expect {
          NetSuite::Records::CurrencyRate.get(:internal_id => 1)
        }.to raise_error(NetSuite::RecordNotFound,
          /NetSuite::Records::CurrencyRate with OPTIONS=(.*) could not be found/)
      end
    end
  end
end
