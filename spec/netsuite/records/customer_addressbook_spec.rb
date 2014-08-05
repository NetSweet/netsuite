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
      :phone, :addr1, :addr2, :addr3, :city, :zip, :country, :addr_text, :override, :state
    ].each do |field|
      list.should have_field(field)
    end
  end

  describe '#initialize' do
    context 'when taking in a hash of attributes' do
      it 'sets the attributes for the object given the attributes hash' do
        list.addr1.should eql('123 Happy Lane')
        list.addr_text.should eql("123 Happy Lane\nLos Angeles CA 90007")
        list.city.should eql('Los Angeles')
        list.country.should eql('_unitedStates')
        list.default_billing.should be_truthy
        list.default_shipping.should be_truthy
        list.is_residential.should be_falsey
        list.label.should eql('123 Happy Lane')
        list.override.should be_falsey
        list.state.should eql('CA')
        list.zip.should eql('90007')
        list.internal_id.should eql('567')
      end
    end

    context 'when taking in a CustomerAddressbookList instance' do
      it 'sets the attributes for the object given the record attributes' do
        old_list = NetSuite::Records::CustomerAddressbook.new(attributes)
        list     = NetSuite::Records::CustomerAddressbook.new(old_list)
        list.addr1.should eql('123 Happy Lane')
        list.addr_text.should eql("123 Happy Lane\nLos Angeles CA 90007")
        list.city.should eql('Los Angeles')
        list.country.should eql('_unitedStates')
        list.default_billing.should be_truthy
        list.default_shipping.should be_truthy
        list.is_residential.should be_falsey
        list.label.should eql('123 Happy Lane')
        list.override.should be_falsey
        list.state.should eql('CA')
        list.zip.should eql('90007')
        list.internal_id.should eql('567')
      end
    end
  end

  describe '#to_record' do
    it 'can represent itself as a SOAP record' do
      record = {
        'listRel:addr1'           => '123 Happy Lane',
        'listRel:addrText'        => "123 Happy Lane\nLos Angeles CA 90007",
        'listRel:city'            => 'Los Angeles',
        'listRel:country'         => '_unitedStates',
        'listRel:defaultBilling'  => true,
        'listRel:defaultShipping' => true,
        'listRel:isResidential'   => false,
        'listRel:label'           => '123 Happy Lane',
        'listRel:override'        => false,
        'listRel:state'           => 'CA',
        'listRel:zip'             => '90007'
      }
      list.to_record.should eql(record)
    end
  end

  describe '#record_type' do
    it 'returns a string of the record SOAP type' do
      list.record_type.should eql('listRel:CustomerAddressbook')
    end
  end

end
