require 'spec_helper'

describe NetSuite::Records::EstimateItemList do
  let(:list) { NetSuite::Records::EstimateItemList.new }

  it 'has a items attribute' do
    expect(list.items).to be_kind_of(Array)
  end

  describe '#to_record' do
    before do
      list.items << NetSuite::Records::EstimateItem.new(
        :rate => 10
      )
    end

    it 'can represent itself as a SOAP record' do
      record =  {
        'tranSales:item' => [{
          'tranSales:rate' => 10
        }]
      }
      expect(list.to_record).to eql(record)
    end
  end
end
