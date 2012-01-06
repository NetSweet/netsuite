require 'spec_helper'

describe NetSuite::Records::ShipAddress do
  let(:ship_address) { NetSuite::Records::ShipAddress.new }

  it 'has all the right fields' do
    [
      :ship_attention, :ship_addressee, :ship_phone, :ship_addr1, :ship_addr2, :ship_addr3,
      :ship_city, :ship_state, :ship_zip, :ship_country, :ship_is_residential
    ].each do |field|
      ship_address.should have_field(field)
    end
  end

end
