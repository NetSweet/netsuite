require 'spec_helper'

describe NetSuite::Records::CustomerAddressbook do
  let(:attributes) do
    {
      :addressbook => {
        :addr1            => '123 Happy Lane',
        :addr_text        => "123 Happy Lane\nLos Angeles CA 90007",
        :city             => 'Los Angeles',
        :country          => '_unitedStates',
        :default_billing  => true,
        :default_shipping => true,
        :internal_id      => '567',
        :is_residential   => false,
        :label            => '123 Happy Lane',
        :override         => false,
        :state            => 'CA',
        :zip              => '90007'
      }
    }
  end
  let(:list) { NetSuite::Records::CustomerAddressbook.new(attributes) }

  it 'has all the right fields' do
    [
      :default_shipping, :default_billing, :is_residential, :label, :attention, :addressee,
      :phone, :addr1, :addr2, :addr3, :city, :zip, :addr_text, :override, :state
    ].each do |field|
      expect(list).to have_field(field)
    end
  end

  it 'has all the right read_only_fields' do
    [
      :addr_text
    ].each do |field|
      expect(NetSuite::Records::CustomerAddressbook).to have_read_only_field(field)
    end
  end

  describe '#initialize' do
    context 'when taking in a hash of attributes' do
      it 'sets the attributes for the object given the attributes hash' do
        expect(list.addr1).to eql('123 Happy Lane')
        expect(list.addr_text).to eql("123 Happy Lane\nLos Angeles CA 90007")
        expect(list.city).to eql('Los Angeles')
        expect(list.country.to_record).to eql('_unitedStates')
        expect(list.default_billing).to be_truthy
        expect(list.default_shipping).to be_truthy
        expect(list.is_residential).to be_falsey
        expect(list.label).to eql('123 Happy Lane')
        expect(list.override).to be_falsey
        expect(list.state).to eql('CA')
        expect(list.zip).to eql('90007')
        expect(list.internal_id).to eql('567')
      end
    end

    context 'when taking in a CustomerAddressbookList instance' do
      it 'sets the attributes for the object given the record attributes' do
        old_list = NetSuite::Records::CustomerAddressbook.new(attributes)
        list     = NetSuite::Records::CustomerAddressbook.new(old_list)
        expect(list.addr1).to eql('123 Happy Lane')
        expect(list.addr_text).to eql("123 Happy Lane\nLos Angeles CA 90007")
        expect(list.city).to eql('Los Angeles')
        expect(list.country.to_record).to eql('_unitedStates')
        expect(list.default_billing).to be_truthy
        expect(list.default_shipping).to be_truthy
        expect(list.is_residential).to be_falsey
        expect(list.label).to eql('123 Happy Lane')
        expect(list.override).to be_falsey
        expect(list.state).to eql('CA')
        expect(list.zip).to eql('90007')
        expect(list.internal_id).to eql('567')
      end
    end
  end

  describe '#to_record' do
    it 'can represent itself as a SOAP record' do
      record = {
        'listRel:addr1'           => '123 Happy Lane',
        'listRel:city'            => 'Los Angeles',
        'listRel:country'         => '_unitedStates',
        'listRel:defaultBilling'  => true,
        'listRel:defaultShipping' => true,
        'listRel:isResidential'   => false,
        'listRel:label'           => '123 Happy Lane',
        'listRel:override'        => false,
        'listRel:state'           => 'CA',
        'listRel:zip'             => '90007',
        "listRel:internalId"      => "567"
      }
      expect(list.to_record).to eql(record)
    end
  end

  describe "#country" do
    context "when it's specified as a 2 character ISO code" do
      it "is converted to the appropriate NetSuite enum value" do
        addressbook = NetSuite::Records::CustomerAddressbook.new country: "US"
        expect(addressbook.to_record["listRel:country"]).to eql "_unitedStates"
      end
    end

    context "when the country code is a YAML reserved word (NO)" do
      it "is converted to the appropriate NetSuite enum value" do
        addressbook = NetSuite::Records::CustomerAddressbook.new country: "NO"
        expect(addressbook.to_record["listRel:country"]).to eql "_norway"
      end
    end

    it "can be specified as the NetSuite enum value" do
      addressbook = NetSuite::Records::CustomerAddressbook.new country: "_unitedStates"
      expect(addressbook.to_record["listRel:country"]).to eql "_unitedStates"

      # country with two uppercase letters (looks like ISO2)
      addressbook = NetSuite::Records::CustomerAddressbook.new country: "_unitedKingdomGB"
      expect(addressbook.to_record["listRel:country"]).to eql "_unitedKingdomGB"
    end

    it "can be unspecified" do
      addressbook = NetSuite::Records::CustomerAddressbook.new country: ''
      expect(addressbook.country.to_record).to eql ""
      expect(addressbook.to_record["listRel:country"]).to eql ""
    end
  end

  describe '#record_type' do
    it 'returns a string of the record SOAP type' do
      expect(list.record_type).to eql('listRel:CustomerAddressbook')
    end
  end

end
