require 'spec_helper'

describe NetSuite::Records::ItemVendor do
  let(:vendor) { NetSuite::Records::ItemVendor.new }

  it 'has all the right fields' do
    [
      :vendor, :purchase_price, :preferred_vendor
    ].each do |field|
      expect(vendor).to have_field(field)
    end
  end

  it 'has all the right record refs'
end
