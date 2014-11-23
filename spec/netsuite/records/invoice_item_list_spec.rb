require 'spec_helper'

describe NetSuite::Records::InvoiceItemList do
  let(:list) { NetSuite::Records::InvoiceItemList.new }
  let(:item) { NetSuite::Records::InvoiceItem.new }

  it 'can have items be added to it' do
    list.items << item
    item_list = list.items
    expect(item_list).to be_kind_of(Array)
    expect(item_list.length).to eql(1)
    item_list.each { |i| expect(i).to be_kind_of(NetSuite::Records::InvoiceItem) }
  end

  describe '#to_record' do
    it 'can represent itself as a SOAP record' do
      record = {
        'tranSales:item' => []
      }
      expect(list.to_record).to eql(record)
    end
  end

end
