require 'spec_helper'

describe NetSuite::Records::TaxType do
  subject(:tax_type) { described_class.new }

  it 'has all the right fields' do
    [ :description, :name ].each do |field|
      expect(tax_type).to have_field(field)
    end
  end
end
