require 'spec_helper'

describe NetSuite::Records::ItemVendor do
  let(:vendor) { NetSuite::Records::ItemVendor.new }

  it 'has all the right fields' do
    [
      :purchase_price,
      :preferred_vendor,
      :vendor_code,
      :vendor_currency_name,
    ].each do |field|
      expect(vendor).to have_field(field)
    end
  end

  it 'has all the right record refs' do
    [
      :schedule,
      :subsidiary,
      :vendor,
      :vendor_currency,
    ].each do |field|
      expect(vendor).to have_record_ref(field)
    end
  end
end
