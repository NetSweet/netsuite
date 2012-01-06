require 'spec_helper'

describe NetSuite::Records::BillAddress do
  let(:bill_address) { NetSuite::Records::BillAddress.new }

  it 'has all the right fields' do
    [
      :bill_attention, :bill_addressee, :bill_phone, :bill_addr1, :bill_addr2,
      :bill_addr3, :bill_city, :bill_state, :bill_zip, :bill_country
    ].each do |field|
      bill_address.should have_field(field)
    end
  end

end
