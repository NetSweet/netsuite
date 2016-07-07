require 'spec_helper'

describe NetSuite::Records::VendorPayment do
  let(:payment) { NetSuite::Records::VendorPayment.new }
  let(:vendor) { NetSuite::Records::Vendor.new }
  let(:response) { NetSuite::Response.new(:success => true, :body => { :@internal_id => '1', :@external_id => 'some id' }) }

  it 'has all the right fields' do
    [
      :address, :balance, :bill_pay, :created_date, :credit_list, :currency_name, :exchange_rate, :last_modified_date,
      :memo, :print_voucher, :status, :to_ach, :to_be_printed, :total, :tran_date, :tran_id, :transaction_number
    ].each do |field|
      expect(payment).to have_field(field)
    end
  end

  it 'has all the right record refs' do
    [
      :account, :ap_acct, :currency, :custom_form, :department, :entity, :klass, :location, :posting_period,
      :subsidiary, :void_journal
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
    it 'can be set from attributes' do
      attributes = {
        :apply => {
          :amount => 10
        }
      }
      payment.apply_list = attributes
      expect(payment.apply_list).to be_kind_of(NetSuite::Records::VendorPaymentApplyList)
      expect(payment.apply_list.applies.length).to eql(1)
    end

    it 'can be set from a VendorPaymentApplyList object' do
      apply_list = NetSuite::Records::VendorPaymentApplyList.new
      payment.apply_list = apply_list
      expect(payment.apply_list).to eql(apply_list)
    end
  end

  describe '.get' do
    context 'when the response is successful' do
      it 'returns an VendorPayment instance populated with the data from the response object' do
        expect(NetSuite::Actions::Get).to receive(:call).with([NetSuite::Records::VendorPayment, external_id: 'some id'], {}).and_return(response)
        payment = NetSuite::Records::VendorPayment.get(external_id: 'some id')
        expect(payment).to be_kind_of(NetSuite::Records::VendorPayment)
        expect(payment.internal_id).to eql('1')
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'raises a RecordNotFound exception' do
        expect(NetSuite::Actions::Get).to receive(:call).with([NetSuite::Records::VendorPayment, external_id: 'some id'], {}).and_return(response)
        expect {
          NetSuite::Records::VendorPayment.get(external_id: 'some id')
        }.to raise_error(NetSuite::RecordNotFound,
                         /NetSuite::Records::VendorPayment with OPTIONS=(.*) could not be found/)
      end
    end
  end

  describe '.initialize' do
    context 'when the request is successful' do
      it 'returns an initialized vendor payment from the vendor entity' do
        expect(NetSuite::Actions::Initialize).to receive(:call).with([NetSuite::Records::VendorPayment, vendor], {}).and_return(response)
        payment = NetSuite::Records::VendorPayment.initialize(vendor)
        expect(payment).to be_kind_of(NetSuite::Records::VendorPayment)
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'raises a InitializationError exception' do
        expect(NetSuite::Actions::Initialize).to receive(:call).with([NetSuite::Records::VendorPayment, vendor], {}).and_return(response)
        expect {
          NetSuite::Records::VendorPayment.initialize(vendor)
        }.to raise_error(NetSuite::InitializationError,
                         /NetSuite::Records::VendorPayment.initialize with .+ failed./)
      end
    end
  end

  describe '#add' do
    context 'when the response is successful' do
      it 'returns true' do
        expect(NetSuite::Actions::Add).to receive(:call).with([payment], {}).and_return(response)
        expect(payment.add).to be_truthy
        expect(payment.internal_id).to eq('1')
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }
      it 'returns false' do
        expect(NetSuite::Actions::Add).to receive(:call).with([payment], {}).and_return(response)
        expect(payment.add).to be_falsey
      end
    end
  end

  describe '#delete' do
    context 'when the response is successful' do
      it 'returns true' do
        expect(NetSuite::Actions::Delete).to receive(:call).with([payment], {}).and_return(response)
        expect(payment.delete).to be_truthy
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }
      it 'returns false' do
        expect(NetSuite::Actions::Delete).to receive(:call).with([payment], {}).and_return(response)
        expect(payment.delete).to be_falsey
      end
    end
  end

  describe '#to_record' do
    before do
      payment.memo   = 'some payment'
      payment.total = '123'
    end
    it 'can represent itself as a SOAP record' do
      record = {
          'tranPurch:memo'   => 'some payment',
          'tranPurch:total' => '123'
      }
      expect(payment.to_record).to eql(record)
    end
  end

  describe '#record_type' do
    it 'returns a string representation of the SOAP type' do
      expect(payment.record_type).to eql('tranPurch:VendorPayment')
    end
  end
end
