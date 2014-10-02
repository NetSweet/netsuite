require 'spec_helper'

describe NetSuite::Records::UnitsTypeUomList do
  let(:list) { described_class.new }
  let(:item) { NetSuite::Records::UnitsTypeUom.new }

  it 'can have items be added to it' do
    list.uom << item
    item_list = list.uom
    item_list.should be_kind_of(Array)
    item_list.length.should eql(1)
    item_list.each { |i| i.should be_kind_of(NetSuite::Records::UnitsTypeUom) }
  end

  describe '#to_record' do
    it 'can represent itself as a SOAP record' do
      record = {
        'listAcct:uom' => []
      }
      list.to_record.should eql(record)
    end
  end
end
