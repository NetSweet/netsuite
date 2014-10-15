require 'spec_helper'

describe NetSuite::Records::CreditMemoItemList do
  let(:list) { NetSuite::Records::CreditMemoItemList.new }

  it 'has a items attribute' do
    expect(list.items).to be_kind_of(Array)
  end

  describe '#to_record' do
    before do
      list.items << NetSuite::Records::CreditMemoItem.new(
        :rate => 10
      )
    end

    it 'can represent itself as a SOAP record' do
      record = {
        'tranCust:item' => [{
          'tranCust:rate' => 10
        }]
      }
      list.to_record.should eql(record)
    end
  end
end
