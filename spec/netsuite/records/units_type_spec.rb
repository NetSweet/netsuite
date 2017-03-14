require 'spec_helper'

describe NetSuite::Records::UnitsType do
  let(:units_type) { described_class.new }

  it 'has all the right fields' do
    [
      :is_inactive, :name
    ].each do |field|
      expect(units_type).to have_field(field)
    end
  end

  describe '#uom_list' do
    it 'can be set from attributes' do
      attributes = [{
        uom: {
          abbreviation: '6 oz',
          conversion_rate: 1.4
        }
      }]
      units_type.uom_list.uom = attributes
      expect(units_type.uom_list).to be_kind_of(NetSuite::Records::UnitsTypeUomList)
      expect(units_type.uom_list.uom.length).to eql(1)
    end

    it 'can be set from a units_typeItemList object' do
      item_list = NetSuite::Records::UnitsTypeUomList.new
      units_type.uom_list = item_list
      expect(units_type.uom_list).to eql(item_list)
    end
  end
end
