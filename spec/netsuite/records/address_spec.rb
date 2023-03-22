require 'spec_helper'

describe NetSuite::Records::Address do
  let(:attributes) do
    {
      :addr1        => '123 Happy Lane',
      :addr2        => '#10-10 Big Building',
      :addressee    => 'Happy Pizza',
      :addr_text    => "123 Happy Lane\nLos Angeles CA 90007",
      :addr_phone   => '91828232',
      :attention    => 'Mr. Happy',
      :city         => 'Los Angeles',
      :country      => '_unitedStates',
      :internal_id  => '1232',
      :override     => false,
      :state        => 'CA',
      :zip          => '90007'
    }
  end
  let(:list) { NetSuite::Records::Address.new(attributes) }

  it 'has all the right fields' do
    [
      :addr1, :addr2, :addressee, :addr_phone, :attention, :city, :internal_id, :override, :state, :zip
    ].each do |field|
      expect(list).to have_field(field)
    end
  end

  it 'has all the right read_only_fields' do
    [
      :addr_text
    ].each do |field|
      expect(NetSuite::Records::Address).to have_read_only_field(field)
    end
  end

  describe '#initialize' do
    context 'when taking in a hash of attributes' do
      it 'sets the attributes for the object given the attributes hash' do
        expect(list.addr1).to eql('123 Happy Lane')
        expect(list.addr2).to eql('#10-10 Big Building')
        expect(list.addressee).to eql('Happy Pizza')
        expect(list.addr_text).to eql("123 Happy Lane\nLos Angeles CA 90007")
        expect(list.addr_phone).to eql('91828232')
        expect(list.attention).to eql('Mr. Happy')
        expect(list.city).to eql('Los Angeles')
        expect(list.country.to_record).to eql('_unitedStates')
        expect(list.internal_id).to eql('1232')
        expect(list.override).to be_falsey
        expect(list.state).to eql('CA')
        expect(list.zip).to eql('90007')
      end
    end

    context 'when taking in a CustomerAddressbookList instance' do
      it 'sets the attributes for the object given the record attributes' do
        old_list = NetSuite::Records::Address.new(attributes)
        list     = NetSuite::Records::Address.new(old_list)
        expect(list.addr1).to eql('123 Happy Lane')
        expect(list.addr2).to eql('#10-10 Big Building')
        expect(list.addressee).to eql('Happy Pizza')
        expect(list.addr_text).to eql("123 Happy Lane\nLos Angeles CA 90007")
        expect(list.addr_phone).to eql('91828232')
        expect(list.attention).to eql('Mr. Happy')
        expect(list.city).to eql('Los Angeles')
        expect(list.country.to_record).to eql('_unitedStates')
        expect(list.internal_id).to eql('1232')
        expect(list.override).to be_falsey
        expect(list.state).to eql('CA')
        expect(list.zip).to eql('90007')
      end
    end
  end

  describe '#to_record' do
    it 'can represent itself as a SOAP record' do
      record = {
        'platformCommon:addr1'       => '123 Happy Lane',
        'platformCommon:addr2'       => '#10-10 Big Building',
        'platformCommon:addressee'   => 'Happy Pizza',
        'platformCommon:addrPhone'   => '91828232',
        'platformCommon:attention'   => 'Mr. Happy',
        'platformCommon:city'        => 'Los Angeles',
        'platformCommon:country'     => '_unitedStates',
        'platformCommon:internalId'  => '1232',
        'platformCommon:override'    => false,
        'platformCommon:state'       => 'CA',
        'platformCommon:zip'         => '90007'
      }
      expect(list.to_record).to eql(record)
    end
  end

  describe '#record_type' do
    it 'returns a string of the record SOAP type' do
      expect(list.record_type).to eql('platformCommon:Address')
    end
  end

  describe "#country" do
    context "when it's specified as a 2 character ISO code" do
      it "is converted to the appropriate NetSuite enum value" do
        addressbook = NetSuite::Records::Address.new country: "US"
        expect(addressbook.to_record["platformCommon:country"]).to eql "_unitedStates"
      end

      it 'properly evaluates equality against another country of the same ISO code' do
        addressbook = NetSuite::Records::Address.new country: "US"
        addressbook_2 = NetSuite::Records::Address.new country: "US"

        expect(addressbook.country == addressbook_2.country).to eq(true)
      end
    end

    context "when the country code is a YAML reserved word (NO)" do
      it "is converted to the appropriate NetSuite enum value" do
        addressbook = NetSuite::Records::Address.new country: "NO"
        expect(addressbook.to_record["platformCommon:country"]).to eql "_norway"
      end
    end

    it "can be specified as the NetSuite enum value" do
      addressbook = NetSuite::Records::Address.new country: "_unitedStates"
      expect(addressbook.to_record["platformCommon:country"]).to eql "_unitedStates"

      # country with two uppercase letters (looks like ISO2)
      addressbook = NetSuite::Records::Address.new country: "_unitedKingdomGB"
      expect(addressbook.to_record["platformCommon:country"]).to eql "_unitedKingdomGB"
    end

    it "can be unspecified" do
      addressbook = NetSuite::Records::Address.new country: ''
      expect(addressbook.country.to_record).to eql ""
      expect(addressbook.to_record["platformCommon:country"]).to eql ""
    end
  end

end
