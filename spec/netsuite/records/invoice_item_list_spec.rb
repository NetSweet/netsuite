require 'spec_helper'

describe NetSuite::Records::InvoiceItemList do
  let(:list) { NetSuite::Records::InvoiceItemList.new }
  let(:item) { NetSuite::Records::InvoiceItem.new }

  it 'can have items be added to it' do
    list.add_item(item)
    item_list = list.send(:items)
    item_list.should be_kind_of(Array)
    item_list.length.should eql(1)
    item_list.each { |i| i.should be_kind_of(NetSuite::Records::InvoiceItem) }
  end

  describe '#to_record' do
    it 'can represent itself as a SOAP record' do
      record = {
        'tranSales:item' => []
      }
      list.to_record.should eql(record)
    end
  end

end
