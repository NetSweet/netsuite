require 'spec_helper'

describe NetSuite::Records::PaymentMethod do
  let(:payment_method) { NetSuite::Records::PaymentMethod.new }

  it 'has all the right fields' do
    [
      :credit_card, :express_checkout_arrangement, :is_debit_card, :is_inactive, :is_online, :name, :pay_pal_email_address,
      :undep_funds, :use_express_checkout
    ].each do |field|
      payment_method.should have_field(field)
    end
  end

  it 'has all thr right record refs' do
    [
      :account
    ].each do |record_ref|
      payment_method.should have_record_ref(record_ref)
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
        NetSuite::Actions::Get.should_receive(:call).with(NetSuite::Records::PaymentMethod, :external_id => 10).and_return(response)
        payment_method = NetSuite::Records::PaymentMethod.get(:external_id => 10)
        payment_method.should be_kind_of(NetSuite::Records::PaymentMethod)
        payment_method.is_debit_card.should be_true
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'raises a RecordNotFound exception' do
        NetSuite::Actions::Get.should_receive(:call).with(NetSuite::Records::PaymentMethod, :external_id => 10).and_return(response)
        lambda {
          NetSuite::Records::PaymentMethod.get(:external_id => 10)
        }.should raise_error(NetSuite::RecordNotFound,
          /NetSuite::Records::PaymentMethod with OPTIONS=(.*) could not be found/)
      end
    end
  end

end
