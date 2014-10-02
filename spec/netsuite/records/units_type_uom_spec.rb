require 'spec_helper'

describe NetSuite::Records::UnitsTypeUom do
  let(:uom) { described_class.new }

  it 'has all the right fields' do
    [
      :abbreviation, :base_unit, :conversion_rate, :plural_abbreviation,
      :plural_name, :unit_name
    ].each do |field|
      uom.should have_field(field)
    end
  end
end
