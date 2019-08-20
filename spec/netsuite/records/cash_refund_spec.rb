require 'spec_helper'

describe NetSuite::Records::CashRefund do
  let(:cashrefund) { NetSuite::Records::CashRefund.new }
  let(:customer) { NetSuite::Records::Customer.new }

  it 'has all the right fields' do
    [
      :tran_date, :to_be_emailed, :memo, :tran_id
    ].each do |field|
      expect(cashrefund).to have_field(field)
    end
  end

  it 'has all the right record refs' do
    [
      :entity, :custom_form, :payment_method, :created_from, :klass
    ].each do |record_ref|
      expect(cashrefund).to have_record_ref(record_ref)
    end
  end

  describe '#item_list' do
    it 'can be set from attributes' do
      attributes = {
        :item => {
          :amount => 10
        }
      }
      cashrefund.item_list = attributes
      expect(cashrefund.item_list).to be_kind_of(NetSuite::Records::CashRefundItemList)
      expect(cashrefund.item_list.items.length).to eql(1)
    end

    it 'can be set from a CashRefundItemList object' do
      item_list = NetSuite::Records::CashRefundItemList.new
      cashrefund.item_list = item_list
      expect(cashrefund.item_list).to eql(item_list)
    end
  end

  describe '#custom_field_list' do
    it 'can be set through individual field setters' do
      cashrefund.custom_field_list.custbody18 = "123-456"
      expect(cashrefund.custom_field_list).to be_kind_of(NetSuite::Records::CustomFieldList)
      expect(cashrefund.custom_field_list.custom_fields.length).to eql(1)
      expect(cashrefund.custom_field_list.custbody18.attributes[:value]).to eq("123-456")
    end
  end

  describe '.get' do
    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :tran_date => 'test_tran_date' }) }

      it 'returns a CashRefund instance populated with the data from the response object' do
        expect(NetSuite::Actions::Get).to receive(:call).with([NetSuite::Records::CashRefund, :external_id => 1], {}).and_return(response)
        cashrefund = NetSuite::Records::CashRefund.get(:external_id => 1)
        expect(cashrefund).to be_kind_of(NetSuite::Records::CashRefund)
        expect(cashrefund.tran_date).to eql('test_tran_date')
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'raises a RecordNotFound exception' do
        expect(NetSuite::Actions::Get).to receive(:call).with([NetSuite::Records::CashRefund, :external_id => 1], {}).and_return(response)
        expect {
          NetSuite::Records::CashRefund.get(:external_id => 1)
        }.to raise_error(NetSuite::RecordNotFound,
          /NetSuite::Records::CashRefund with OPTIONS=(.*) could not be found/)
      end
    end
  end

  describe '#add' do
    let(:test_data) { { :email => 'test@example.com', :fax => '1234567890' } }

    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :internal_id => '1' }) }

      it 'returns true' do
        cashrefund = NetSuite::Records::CashRefund.new(test_data)
        expect(NetSuite::Actions::Add).to receive(:call).
            with([cashrefund], {}).
            and_return(response)
        expect(cashrefund.add).to be_truthy
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'returns false' do
        cashrefund = NetSuite::Records::CashRefund.new(test_data)
        expect(NetSuite::Actions::Add).to receive(:call).
            with([cashrefund], {}).
            and_return(response)
        expect(cashrefund.add).to be_falsey
      end
    end
  end

  describe '#delete' do
    let(:test_data) { { :internal_id => '1' } }

    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :internal_id => '1' }) }

      it 'returns true' do
        cashrefund = NetSuite::Records::CashRefund.new(test_data)
        expect(NetSuite::Actions::Delete).to receive(:call).
            with([cashrefund], {}).
            and_return(response)
        expect(cashrefund.delete).to be_truthy
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'returns false' do
        cashrefund = NetSuite::Records::CashRefund.new(test_data)
        expect(NetSuite::Actions::Delete).to receive(:call).
            with([cashrefund], {}).
            and_return(response)
        expect(cashrefund.delete).to be_falsey
      end
    end
  end

  describe '#to_record' do
    let(:tran_date) { Time.now }
    before do
      cashrefund.tran_date = tran_date
    end
    it 'can represent itself as a SOAP record' do
      record = {
        'tranCust:tranDate'  => tran_date
      }
      expect(cashrefund.to_record).to eql(record)
    end
  end


  describe '#record_type' do
    it 'returns a string representation of the SOAP type' do
      expect(cashrefund.record_type).to eql('tranCust:CashRefund')
    end
  end

end
