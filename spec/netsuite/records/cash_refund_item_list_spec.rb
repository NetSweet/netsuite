require 'spec_helper'

describe NetSuite::Records::CashRefundItemList do
  let(:list) { NetSuite::Records::CashRefundItemList.new }

  it 'has a items attribute' do
    expect(list.items).to be_kind_of(Array)
  end

  describe '#to_record' do
    before do
      list.items << NetSuite::Records::CashRefundItem.new(
        :amount => 10
      )
    end

    it 'can represent itself as a SOAP record' do
      record =  {
        'tranCust:item' => [{
          'tranCust:amount' => 10
        }]
      }
      expect(list.to_record).to eql(record)
    end
  end
end

