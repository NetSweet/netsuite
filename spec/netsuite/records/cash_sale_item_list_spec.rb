require 'spec_helper'

describe NetSuite::Records::CashSaleItemList do
  let(:list) { NetSuite::Records::CashSaleItemList.new }

  it 'has a items attribute' do
    expect(list.items).to be_kind_of(Array)
  end

  describe '#to_record' do
    before do
      list.items << NetSuite::Records::CashSaleItem.new(
        :amount => 10
      )
    end

    it 'can represent itself as a SOAP record' do
      record =  {
        'tranSales:item' => [{
          'tranSales:amount' => 10
        }]
      }
      expect(list.to_record).to eql(record)
    end
  end
end

