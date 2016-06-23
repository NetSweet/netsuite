require 'spec_helper'

describe NetSuite::Records::PaymentItem do
  let(:item) { NetSuite::Records::PaymentItem.new }

  it 'has the right fields' do
    [
      :created_date, :display_name, :include_children, :is_inactive, :item_id, :last_modified_date
    ].each do |field|
      expect(item).to have_field(field)
    end

  end

  describe '.get' do
    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :manufacturer_zip => '90401' }) }

      it 'returns a PaymentItem instance populated with the data from the response object' do
        expect(NetSuite::Actions::Get).to receive(:call).with([NetSuite::Records::PaymentItem, {:external_id => 20}], {}).and_return(response)
        item = NetSuite::Records::PaymentItem.get(:external_id => 20)
        expect(item).to be_kind_of(NetSuite::Records::PaymentItem)
        expect(item.manufacturer_zip).to eql('90401')
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'raises a RecordNotFound exception' do
        expect(NetSuite::Actions::Get).to receive(:call).with([NetSuite::Records::PaymentItem, {:external_id => 20}], {}).and_return(response)
        expect {
          NetSuite::Records::PaymentItem.get(:external_id => 20)
        }.to raise_error(NetSuite::RecordNotFound,
          /NetSuite::Records::PaymentItem with OPTIONS=(.*) could not be found/)
      end
    end
  end

  describe '#add' do
    # let(:item) { NetSuite::Records::PaymentItem.new(:cost => 100, :is_inactive => false) }

    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :internal_id => '1' }) }

      it 'returns true' do
        expect(NetSuite::Actions::Add).to receive(:call).
            with([item], {}).
            and_return(response)
        expect(item.add).to be_truthy
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'returns false' do
        expect(NetSuite::Actions::Add).to receive(:call).
            with([item], {}).
            and_return(response)
        expect(item.add).to be_falsey
      end
    end
  end

  describe '#delete' do
    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :internal_id => '1' }) }

      it 'returns true' do
        expect(NetSuite::Actions::Delete).to receive(:call).
            with([item], {}).
            and_return(response)
        expect(item.delete).to be_truthy
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'returns false' do
        expect(NetSuite::Actions::Delete).to receive(:call).
            with([item], {}).
            and_return(response)
        expect(item.delete).to be_falsey
      end
    end
  end

  describe '#to_record' do
    before do
      item.handling_cost = 100.0
      item.is_online     = true
    end

    it 'can represent itself as a SOAP record' do
      record = {
        'listAcct:handlingCost' => 100.0,
        'listAcct:isOnline'     => true
      }
      expect(item.to_record).to eql(record)
    end
  end

  describe '#record_type' do
    it 'returns a string of the SOAP type' do
      expect(item.record_type).to eql('listAcct:PaymentItem')
    end
  end

end
