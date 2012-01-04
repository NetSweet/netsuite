require 'spec_helper'

describe NetSuite::Records::CustomerAddressbookList do
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
  let(:record) { NetSuite::Records::CustomerAddressbookList.new(attributes) }

  it 'has all the right fields' do
    [
      :default_shipping, :default_billing, :is_residential, :label, :attention, :addressee,
      :phone, :addr1, :addr2, :addr3, :city, :zip, :country, :addr_text, :override, :state
    ].each do |field|
      record.should have_field(field)
    end
  end

  describe '#initialize' do
    context 'when taking in a hash of attributes' do
      it 'sets the attributes for the object given the attributes hash' do
        record.addr1.should eql('123 Happy Lane')
        record.addr_text.should eql("123 Happy Lane\nLos Angeles CA 90007")
        record.city.should eql('Los Angeles')
        record.country.should eql('_unitedStates')
        record.default_billing.should be_true
        record.default_shipping.should be_true
        record.is_residential.should be_false
        record.label.should eql('123 Happy Lane')
        record.override.should be_false
        record.state.should eql('CA')
        record.zip.should eql('90007')
        record.internal_id.should eql('567')
      end
    end

    context 'when taking in a CustomerAddressbookList instance' do
      it 'sets the attributes for the object given the record attributes' do
        old_record = NetSuite::Records::CustomerAddressbookList.new(attributes)
        record     = NetSuite::Records::CustomerAddressbookList.new(old_record)
        record.addr1.should eql('123 Happy Lane')
        record.addr_text.should eql("123 Happy Lane\nLos Angeles CA 90007")
        record.city.should eql('Los Angeles')
        record.country.should eql('_unitedStates')
        record.default_billing.should be_true
        record.default_shipping.should be_true
        record.is_residential.should be_false
        record.label.should eql('123 Happy Lane')
        record.override.should be_false
        record.state.should eql('CA')
        record.zip.should eql('90007')
        record.internal_id.should eql('567')
      end
    end
  end

end
