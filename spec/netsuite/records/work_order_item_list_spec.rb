require 'spec_helper'

describe NetSuite::Records::WorkOrderItemList do
  let(:list) { NetSuite::Records::WorkOrderItemList.new }

  it 'has a items attribute' do
    expect(list.items).to be_kind_of(Array)
  end

  describe '#to_record' do
    before do
      list.items << NetSuite::Records::WorkOrderItem.new(
        :average_cost => 10
      )
    end

    it 'can represent itself as a SOAP record' do
      record =  {
        'tranInvt:item' => [{
          'tranInvt:averageCost' => 10
        }]
      }
      expect(list.to_record).to eql(record)
    end
  end
end
