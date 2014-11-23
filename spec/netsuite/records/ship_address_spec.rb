require 'spec_helper'

describe NetSuite::Records::ShipAddress do
  let(:ship_address) { NetSuite::Records::ShipAddress.new }

  it 'has all the right fields' do
    [
      :ship_attention, :ship_addressee, :ship_phone, :ship_addr1, :ship_addr2, :ship_addr3,
      :ship_city, :ship_state, :ship_zip, :ship_country, :ship_is_residential
    ].each do |field|
      expect(ship_address).to have_field(field)
    end
  end

  describe '#to_record' do
    before do
      ship_address.ship_attention = 'Mr. Smith'
      ship_address.ship_zip       = '90007'
    end

    it 'can represent itself as a SOAP record' do
      record = {
        'platformCommon:shipAttention' => 'Mr. Smith',
        'platformCommon:shipZip'       => '90007'
      }
      expect(ship_address.to_record).to eql(record)
    end
  end

  describe '#record_type' do
    it 'returns a string of the SOAP record type' do
      expect(ship_address.record_type).to eql('platformCommon:ShipAddress')
    end
  end

end
