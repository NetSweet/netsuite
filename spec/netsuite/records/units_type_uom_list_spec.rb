require 'spec_helper'

describe NetSuite::Records::UnitsTypeUomList do
  let(:list) { described_class.new }
  let(:item) { NetSuite::Records::UnitsTypeUom.new }

  it 'can have items be added to it' do
    list.uom << item
    item_list = list.uom
    expect(item_list).to be_kind_of(Array)
    expect(item_list.length).to eql(1)
    item_list.each { |i| expect(i).to be_kind_of(NetSuite::Records::UnitsTypeUom) }
  end

  describe '#to_record' do
    it 'can represent itself as a SOAP record' do
      record = {
        'listAcct:uom' => []
      }
      expect(list.to_record).to eql(record)
    end
  end
end
