require 'spec_helper'

describe NetSuite::Records::VendorBillItemList do
  let(:item_list) { NetSuite::Records::VendorBillItemList.new }
  let(:item) { NetSuite::Records::VendorBillItem.new }

  it 'can be initialized with a hash' do
    item_list = NetSuite::Records::VendorBillItemList.new(item: {})
    expect(item_list.items).to be_kind_of(Array)
    expect(item_list.items.length).to eql(1)
    expect(item_list.items[0]).to be_kind_of(NetSuite::Records::VendorBillItem)
  end

  it 'can be initialized with a hash list' do
    item_list = NetSuite::Records::VendorBillItemList.new(item: [{}])
    expect(item_list.items).to be_kind_of(Array)
    expect(item_list.items.length).to eql(1)
    expect(item_list.items[0]).to be_kind_of(NetSuite::Records::VendorBillItem)
  end

  it 'can have items be added to it' do
    item_list.items << item
    expect(item_list.items).to be_kind_of(Array)
    expect(item_list.items.length).to eql(1)
    expect(item_list.items[0]).to be_kind_of(NetSuite::Records::VendorBillItem)
  end

  describe '#to_record' do
    it 'can represent itself as a SOAP record' do
      record = {
          'tranPurch:item' => []
      }
      expect(item_list.to_record).to eql(record)
    end
  end
end
