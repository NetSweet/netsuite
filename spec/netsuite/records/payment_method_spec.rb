require 'spec_helper'

describe NetSuite::Records::PaymentMethod do
  let(:payment_method) { NetSuite::Records::PaymentMethod.new }

  it 'has all the right fields' do
    [
      :credit_card, :express_checkout_arrangement, :is_debit_card, :is_inactive, :is_online, :name, :pay_pal_email_address,
      :undep_funds, :use_express_checkout
    ].each do |field|
      expect(payment_method).to have_field(field)
    end
  end

  it 'has all thr right record refs' do
    [
      :account
    ].each do |record_ref|
      expect(payment_method).to have_record_ref(record_ref)
    end
  end

  describe '#merchant_accounts_list' do
    it 'can be set from attributes'
    it 'can be set from a RecordRefList object'
  end

  describe '.get' do
    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :is_debit_card => true }) }

      it 'returns an PaymentMethod instance populated with the data from the response object' do
        expect(NetSuite::Actions::Get).to receive(:call).with([NetSuite::Records::PaymentMethod, :external_id => 10], {}).and_return(response)
        payment_method = NetSuite::Records::PaymentMethod.get(:external_id => 10)
        expect(payment_method).to be_kind_of(NetSuite::Records::PaymentMethod)
        expect(payment_method.is_debit_card).to be_truthy
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'raises a RecordNotFound exception' do
        expect(NetSuite::Actions::Get).to receive(:call).with([NetSuite::Records::PaymentMethod, :external_id => 10], {}).and_return(response)
        expect {
          NetSuite::Records::PaymentMethod.get(:external_id => 10)
        }.to raise_error(NetSuite::RecordNotFound,
          /NetSuite::Records::PaymentMethod with OPTIONS=(.*) could not be found/)
      end
    end
  end

end
