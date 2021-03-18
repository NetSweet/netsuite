require 'spec_helper'

describe NetSuite::Records::CustomerPayment do
  let(:payment) { NetSuite::Records::CustomerPayment.new }
  let(:invoice) { NetSuite::Records::Invoice.new }
  let(:response) { NetSuite::Response.new(:success => true, :body => { :internal_id => '1' }) }

  it 'has all the right fields' do
    [
      :applied, :auth_code, :auto_apply, :balance, :cc_approved, :cc_avs_street_match, :cc_avs_zip_match, :cc_expire_date,
      :cc_name, :cc_number, :cc_security_code, :cc_security_code_match, :cc_street, :cc_zip_code, :charge_it, :check_num,
      :created_date, :currency_name, :debit_card_issue_no, :exchange_rate, :ignore_avs, :last_modified_date, :memo, :payment,
      :pending, :pn_ref_num, :status, :three_d_status_code, :total, :tran_date, :unapplied, :undep_funds, :valid_from
    ].each do |field|
      expect(payment).to have_field(field)
    end
  end

  it 'has all the right record refs' do
    [
      :account, :ar_acct, :credit_card, :credit_card_processor, :custom_form, :customer, :department, :klass, :location, :payment_method, :payment_option, :posting_period, :subsidiary
    ].each do |record_ref|
      expect(payment).to have_record_ref(record_ref)
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
      payment.custom_field_list = attributes
      expect(payment.custom_field_list).to be_kind_of(NetSuite::Records::CustomFieldList)
      expect(payment.custom_field_list.custom_fields.length).to eql(1)
    end

    it 'can be set from a CustomFieldList object' do
      custom_field_list = NetSuite::Records::CustomFieldList.new
      payment.custom_field_list = custom_field_list
      expect(payment.custom_field_list).to eql(custom_field_list)
    end
  end

  describe '#apply_list' do
    it 'can be set from attributes'
    it 'can be set from a CustomerPaymentApplyList object'
  end

  describe '#deposit_list' do
    it 'can be set from attributes'
    it 'can be set from a CustomerPaymentDepositList object'
  end

  describe '.get' do
    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :memo => 'This is a memo' }) }

      it 'returns an CustomerPayment instance populated with the data from the response object' do
        expect(NetSuite::Actions::Get).to receive(:call).with([NetSuite::Records::CustomerPayment, {:external_id => 7}], {}).and_return(response)
        payment = NetSuite::Records::CustomerPayment.get(:external_id => 7)
        expect(payment).to be_kind_of(NetSuite::Records::CustomerPayment)
        expect(payment.memo).to eql('This is a memo')
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'raises a RecordNotFound exception' do
        expect(NetSuite::Actions::Get).to receive(:call).with([NetSuite::Records::CustomerPayment, {:external_id => 8}], {}).and_return(response)
        expect {
          NetSuite::Records::CustomerPayment.get(:external_id => 8)
        }.to raise_error(NetSuite::RecordNotFound,
          /NetSuite::Records::CustomerPayment with OPTIONS=(.*) could not be found/)
      end
    end
  end

  describe '.initialize' do
    context 'when the request is successful' do
      it 'returns an initialized invoice from the customer entity' do
        expect(NetSuite::Actions::Initialize).to receive(:call).with([NetSuite::Records::CustomerPayment, invoice], {}).and_return(response)
        payment = NetSuite::Records::CustomerPayment.initialize(invoice)
        expect(payment).to be_kind_of(NetSuite::Records::CustomerPayment)
      end
    end

    context 'when the response is unsuccessful' do
      skip
    end
  end

  describe '#add' do
    let(:test_data) { { :cc_name => 'Ryan Moran', :cc_number => '1234567890123456' } }

    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :internal_id => '1' }) }

      it 'returns true' do
        payment = NetSuite::Records::CustomerPayment.new(test_data)
        expect(NetSuite::Actions::Add).to receive(:call).
            with([payment], {}).
            and_return(response)
        expect(payment.add).to be_truthy
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'returns false' do
        payment = NetSuite::Records::CustomerPayment.new(test_data)
        expect(NetSuite::Actions::Add).to receive(:call).
            with([payment], {}).
            and_return(response)
        expect(payment.add).to be_falsey
      end
    end
  end

    describe '#delete' do
    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :internal_id => '1' }) }

      it 'returns true' do
        expect(NetSuite::Actions::Delete).to receive(:call).
            with([payment], {}).
            and_return(response)
        expect(payment.delete).to be_truthy
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'returns false' do
        expect(NetSuite::Actions::Delete).to receive(:call).
            with([payment], {}).
            and_return(response)
        expect(payment.delete).to be_falsey
      end
    end
  end

  describe '#to_record' do
    before do
      payment.cc_name   = 'Ryan Moran'
      payment.cc_number = '1234567890123456'
    end
    it 'can represent itself as a SOAP record' do
      record = {
        'tranCust:ccName'   => 'Ryan Moran',
        'tranCust:ccNumber' => '1234567890123456'
      }
      expect(payment.to_record).to eql(record)
    end
  end

  describe '#record_type' do
    it 'returns a string representation of the SOAP type' do
      expect(payment.record_type).to eql('tranCust:CustomerPayment')
    end
  end

end
