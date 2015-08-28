require 'spec_helper'

describe NetSuite::Records::CustomerAddressbook do
  let(:attributes) do
    {
      :addressbook => {
        :addressbook_address => NetSuite::Records::Address.new({
                                  :addr1        => '123 Happy Lane',
                                  :addr_text    => "123 Happy Lane\nLos Angeles CA 90007",
                                  :city         => 'Los Angeles',
                                  :country      => '_unitedStates',
                                  :state        => 'CA',
                                  :override     => false,
                                  :zip          => '90007'
                                    }),
        :default_billing  => true,
        :default_shipping => true,
        :internal_id      => '567',
        :is_residential   => false,
        :label            => '123 Happy Lane'
      }
    }
  end      
  let(:list) { NetSuite::Records::CustomerAddressbook.new(attributes) }

  it 'has all the right fields' do
    [
      :addressbook_address, :default_billing, :default_shipping, :internal_id, 
               :is_residential, :label
    ].each do |field|
      expect(list).to have_field(field)
    end
  end

  describe '#initialize' do
    context 'when taking in a hash of attributes' do
      it 'sets the attributes for the object given the attributes hash' do
        expect(list.addressbook_address.addr1).to eql('123 Happy Lane')
        expect(list.addressbook_address.addr_text).to eql("123 Happy Lane\nLos Angeles CA 90007")
        expect(list.addressbook_address.city).to eql('Los Angeles')
        expect(list.addressbook_address.country.to_record).to eql('_unitedStates')
        expect(list.addressbook_address.override).to be_falsey
        expect(list.addressbook_address.state).to eql('CA')
        expect(list.addressbook_address.zip).to eql('90007')
        expect(list.default_billing).to be_truthy
        expect(list.default_shipping).to be_truthy
        expect(list.is_residential).to be_falsey
        expect(list.label).to eql('123 Happy Lane')
        expect(list.internal_id).to eql('567')
      end
    end

    context 'when taking in a CustomerAddressbookList instance' do
      it 'sets the attributes for the object given the record attributes' do
        old_list = NetSuite::Records::CustomerAddressbook.new(attributes)
        list     = NetSuite::Records::CustomerAddressbook.new(old_list)
        expect(list.addressbook_address.addr1).to eql('123 Happy Lane')
        expect(list.addressbook_address.addr_text).to eql("123 Happy Lane\nLos Angeles CA 90007")
        expect(list.addressbook_address.city).to eql('Los Angeles')
        expect(list.addressbook_address.country.to_record).to eql('_unitedStates')
        expect(list.addressbook_address.override).to be_falsey
        expect(list.addressbook_address.state).to eql('CA')
        expect(list.addressbook_address.zip).to eql('90007')
        expect(list.default_billing).to be_truthy
        expect(list.default_shipping).to be_truthy
        expect(list.is_residential).to be_falsey
        expect(list.label).to eql('123 Happy Lane')
        expect(list.internal_id).to eql('567')
      end
    end
  end

  describe '#to_record' do
    it 'can represent itself as a SOAP record' do
      record = {
          'listRel:addressbookAddress' => {
            'platformCommon:addr1'     => '123 Happy Lane',
            'platformCommon:city'      => 'Los Angeles',
            'platformCommon:country'   => '_unitedStates',
            'platformCommon:override'  => false,
            'platformCommon:state'     => 'CA',
            'platformCommon:zip'       => '90007'
          },
        'listRel:defaultBilling'  => true,
        'listRel:defaultShipping' => true,
        'listRel:isResidential'   => false,
        'listRel:label'           => '123 Happy Lane',
        'listRel:internalId'      => '567'
      }
      expect(list.to_record).to eql(record)
    end
  end

  describe '#record_type' do
    it 'returns a string of the record SOAP type' do
      expect(list.record_type).to eql('listRel:CustomerAddressbook')
    end
  end

end
