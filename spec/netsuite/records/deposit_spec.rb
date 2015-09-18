require 'spec_helper'

describe NetSuite::Records::Deposit do
  let(:deposit) { NetSuite::Records::Deposit.new }
  let(:customer) { NetSuite::Records::Customer.new }
  let(:response) { NetSuite::Response.new(:success => true, :body => { :internal_id => '1' }) }

  it 'has all the right fields' do
    [
      :created_date, :last_modified_date, :currency_name, :tran_id, :total, :tran_date, :memo, :to_be_printed
    ].each do |field|
      expect(deposit).to have_field(field)
    end
  end

  it 'has all the right record refs' do
    [
      :custom_form, :account, :posting_period, :subsidiary, :department, :klass, :location
    ].each do |record_ref|
      expect(deposit).to have_record_ref(record_ref)
    end
  end

  describe '#item_list' do
    it 'can be set from attributes' do
      attributes = {
        payment: {
          deposit: true,
          id: '941',
          type: 'CashSale'
        }
      }
      deposit.payment_list.payment = attributes
      expect(deposit.payment_list).to be_kind_of(NetSuite::Records::DepositPaymentList)
      expect(deposit.payment_list.payments.length).to eql(1)
    end

    it 'can be set from a DepositItemList object' do
      item_list = NetSuite::Records::DepositPaymentList.new
      deposit.payment_list = item_list
      expect(deposit.payment_list).to eql(item_list)
    end
  end

  describe '#cash_back_list' do
    it 'can be set from attributes' do
      attributes = {
        amount: 100,
        memo: "test"
      }
      
      deposit.cash_back_list.deposit_cash_back = attributes
      expect(deposit.cash_back_list).to be_kind_of(NetSuite::Records::DepositCashBackList)
      expect(deposit.cash_back_list.deposit_cash_back.length).to eql(1)
    end

    it 'can be set from a DepositCashBackList object' do
      item_list = NetSuite::Records::DepositCashBackList.new
      deposit.cash_back_list = item_list
      expect(deposit.cash_back_list).to eql(item_list)
    end
  end

  describe '.get' do
    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :memo => 'transfer for subscriptions' }) }

      it 'returns a Deposit instance populated with the data from the response object' do
        expect(NetSuite::Actions::Get).to receive(:call).with([NetSuite::Records::Deposit, {:external_id => 1}], {}).and_return(response)
        deposit = NetSuite::Records::Deposit.get(:external_id => 1)
        expect(deposit).to be_kind_of(NetSuite::Records::Deposit)
        expect(deposit.memo).to eql('transfer for subscriptions')
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'raises a RecordNotFound exception' do
        expect(NetSuite::Actions::Get).to receive(:call).with([NetSuite::Records::Deposit, {:external_id => 1}], {}).and_return(response)
        expect {
          NetSuite::Records::Deposit.get(:external_id => 1)
        }.to raise_error(NetSuite::RecordNotFound,
          /NetSuite::Records::Deposit with OPTIONS=(.*) could not be found/)
      end
    end
  end

  describe '#add' do
    let(:test_data) { { :email => 'test@example.com', :fax => '1234567890' } }

    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :internal_id => '1' }) }

      it 'returns true' do
        deposit = NetSuite::Records::Deposit.new(test_data)
        expect(NetSuite::Actions::Add).to receive(:call).
            with([deposit], {}).
            and_return(response)
        expect(deposit.add).to be_truthy
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'returns false' do
        deposit = NetSuite::Records::Deposit.new(test_data)
        expect(NetSuite::Actions::Add).to receive(:call).
            with([deposit], {}).
            and_return(response)
        expect(deposit.add).to be_falsey
      end
    end
  end

  describe '#delete' do
    let(:test_data) { { :internal_id => '1' } }

    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :internal_id => '1' }) }

      it 'returns true' do
        deposit = NetSuite::Records::Deposit.new(test_data)
        expect(NetSuite::Actions::Delete).to receive(:call).
            with([deposit], {}).
            and_return(response)
        expect(deposit.delete).to be_truthy
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'returns false' do
        deposit = NetSuite::Records::Deposit.new(test_data)
        expect(NetSuite::Actions::Delete).to receive(:call).
            with([deposit], {}).
            and_return(response)
        expect(deposit.delete).to be_falsey
      end
    end
  end

  describe '#to_record' do
    before do
      deposit.memo   = 'something@example.com'
      deposit.tran_id = '4'
    end
    it 'can represent itself as a SOAP record' do
      record = {
        'tranBank:memo'  => 'something@example.com',
        'tranBank:tranId' => '4'
      }
      expect(deposit.to_record).to eql(record)
    end
  end

  describe '#record_type' do
    it 'returns a string representation of the SOAP type' do
      expect(deposit.record_type).to eql('tranBank:Deposit')
    end
  end

end
