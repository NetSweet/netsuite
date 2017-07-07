require 'spec_helper'

describe NetSuite::Records::ReturnAuthorizationItemList do
  let(:list) { NetSuite::Records::ReturnAuthorizationItemList.new }

  it 'has a items attribute' do
    expect(list.items).to be_kind_of(Array)
  end

  describe '#to_record' do
    before do
      list.items << NetSuite::Records::ReturnAuthorizationItem.new(
        :rate => 10
      )
    end

    it 'can represent itself as a SOAP record' do
      record =  {
        'tranCust:item' => [{
          'tranCust:rate' => 10
        }]
      }
      expect(list.to_record).to eql(record)
    end
  end
end
