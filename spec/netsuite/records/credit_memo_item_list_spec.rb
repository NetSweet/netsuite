require 'spec_helper'

describe NetSuite::Records::CreditMemoItemList do
  let(:list) { NetSuite::Records::CreditMemoItemList.new }
  let(:item) { NetSuite::Records::CreditMemoItem.new }

  it 'can have applies be added to it' do
    list.items << item
    item_list = list.items
    expect(item_list).to be_kind_of(Array)
    expect(item_list.length).to eql(1)
    item_list.each { |i| expect(i).to be_kind_of(NetSuite::Records::CreditMemoItem) }
  end

  describe '#to_record' do
    it 'can represent itself as a SOAP record' do
      record = {
        'tranCust:item' => [{},{}]
      }
      list.items.concat([item, item])
      expect(list.to_record).to eql(record)
    end
  end

end
