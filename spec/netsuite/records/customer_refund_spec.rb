require 'spec_helper'

describe NetSuite::Records::CustomerRefund do
  let(:refund) { NetSuite::Records::CustomerRefund.new }
  let(:memo) { NetSuite::Records::CreditMemo.new }
  let(:response) { NetSuite::Response.new(:success => true, :body => { :internal_id => '1' }) }

  it 'has all the right fields' do
    [
      :address, :balance, :cc_approved, :cc_expire_date, :cc_name, :cc_number, :cc_street, :cc_zip_code, :charge_it,
      :created_date, :currency_name, :debit_card_issue_no, :exchange_rate, :last_modified_date, :memo, :pn_ref_num, :status,
      :to_be_printed, :total, :tran_date, :tran_id, :valid_from
    ].each do |field|
      expect(refund).to have_field(field)
    end
  end

  it 'has all the right record refs' do
    [
      :account, :ar_acct, :credit_card, :credit_card_processor, :custom_form, :customer, :department, :klass, :location,
      :payment_method, :posting_period, :subsidiary, :void_journal, :currency
    ].each do |record_ref|
      expect(refund).to have_record_ref(record_ref)
    end
  end

  describe '#custom_field_list' do
    it 'can be set from attributes' do
      attributes = {
        :custom_field => {
          :amount => 10,
          :internal_id => 'custfield_amount'
        }
      }
      refund.custom_field_list = attributes
      expect(refund.custom_field_list).to be_kind_of(NetSuite::Records::CustomFieldList)
      expect(refund.custom_field_list.custom_fields.length).to eql(1)
    end

    it 'can be set from a CustomFieldList object' do
      custom_field_list = NetSuite::Records::CustomFieldList.new
      refund.custom_field_list = custom_field_list
      expect(refund.custom_field_list).to eql(custom_field_list)
    end
  end

  describe '#apply_list' do
    it 'can be set from attributes' do
      attributes = {
        :apply => {
          :amount => 10
        }
      }
      refund.apply_list = attributes
      expect(refund.apply_list).to be_kind_of(NetSuite::Records::CustomerRefundApplyList)
      expect(refund.apply_list.applies.length).to eql(1)
    end

    it 'can be set from a CustomerRefundApplyList object' do
      apply_list = NetSuite::Records::CustomerRefundApplyList.new
      refund.apply_list = apply_list
      expect(refund.apply_list).to eql(apply_list)
    end
  end

  describe '#deposit_list' do
    it 'can be set from attributes' do
      attributes = {
        :customer_refund_deposit => {
          :apply => false
        }
      }
      refund.deposit_list = attributes
      expect(refund.deposit_list).to be_kind_of(NetSuite::Records::CustomerRefundDepositList)
      expect(refund.deposit_list.deposits.length).to eql(1)
    end

    it 'can be set from a CustomerRefundDepositList object' do
      deposit_list = NetSuite::Records::CustomerRefundDepositList.new
      refund.deposit_list = deposit_list
      expect(refund.deposit_list).to eql(deposit_list)
    end
  end

  describe '.get' do
    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :is_person => true }) }

      it 'returns an CustomerRefund instance populated with the data from the response object' do
        expect(NetSuite::Actions::Get).to receive(:call).with([NetSuite::Records::CustomerRefund, {:external_id => 10}], {}).and_return(response)
        refund = NetSuite::Records::CustomerRefund.get(:external_id => 10)
        expect(refund).to be_kind_of(NetSuite::Records::CustomerRefund)
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'raises a RecordNotFound exception' do
        expect(NetSuite::Actions::Get).to receive(:call).with([NetSuite::Records::CustomerRefund, {:external_id => 10}], {}).and_return(response)
        expect {
          NetSuite::Records::CustomerRefund.get(:external_id => 10)
        }.to raise_error(NetSuite::RecordNotFound,
          /NetSuite::Records::CustomerRefund with OPTIONS=(.*) could not be found/)
      end
    end
  end

  describe '.initialize' do
    context 'when the request is successful' do
      it 'returns an initialized invoice from the customer entity' do
        expect(NetSuite::Actions::Initialize).to receive(:call).with([NetSuite::Records::CustomerRefund, memo], {}).and_return(response)
        refund = NetSuite::Records::CustomerRefund.initialize(memo)
        expect(refund).to be_kind_of(NetSuite::Records::CustomerRefund)
      end
    end

    context 'when the response is unsuccessful' do
      skip
    end
  end

  describe '#add' do
    let(:test_data) { { :memo => 'This is a memo', :balance => 100 } }

    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :internal_id => '1' }) }

      it 'returns true' do
        refund = NetSuite::Records::CustomerRefund.new(test_data)
        expect(NetSuite::Actions::Add).to receive(:call).
            with([refund], {}).
            and_return(response)
        expect(refund.add).to be_truthy
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'returns false' do
        refund = NetSuite::Records::CustomerRefund.new(test_data)
        expect(NetSuite::Actions::Add).to receive(:call).
            with([refund], {}).
            and_return(response)
        expect(refund.add).to be_falsey
      end
    end
  end

  describe '#delete' do
    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :internal_id => '1' }) }

      it 'returns true' do
        refund = NetSuite::Records::CustomerRefund.new
        expect(NetSuite::Actions::Delete).to receive(:call).
            with([refund], {}).
            and_return(response)
        expect(refund.delete).to be_truthy
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'returns false' do
        refund = NetSuite::Records::CustomerRefund.new
        expect(NetSuite::Actions::Delete).to receive(:call).
            with([refund], {}).
            and_return(response)
        expect(refund.delete).to be_falsey
      end
    end
  end

  describe '#to_record' do
    before do
      refund.memo       = 'This is a memo'
      refund.cc_zip_code = '10101'
    end
    it 'can represent itself as a SOAP record' do
      record = {
        'tranCust:memo'      => 'This is a memo',
        'tranCust:ccZipCode' => '10101'
      }
      expect(refund.to_record).to eql(record)
    end
  end

  describe '#record_type' do
    it 'returns a string representation of the SOAP type' do
      expect(refund.record_type).to eql('tranCust:CustomerRefund')
    end
  end

end
