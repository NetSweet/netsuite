require 'spec_helper'

describe NetSuite::Records::ContactAddressbook do
  let(:contact_addressbook) { NetSuite::Records::ContactAddressbook.new }

  describe 'field definitions' do
    it 'has all the common fields' do
      [
        :default_shipping, :default_billing, :is_residential, :label, :internal_id
      ].each do |field|
        expect(contact_addressbook).to have_field(field)
      end
    end

    it 'has all the legacy API fields (< 2014_2)' do
      [
        :attention, :addressee, :phone, :addr1, :addr2, :addr3, 
        :city, :zip, :override, :state
      ].each do |field|
        expect(contact_addressbook).to have_field(field)
      end
    end
  end

  describe '#initialize' do
    context 'when initialized with a Hash' do
      it 'sets attributes from hash' do
        attributes = {
          label: 'Home Address',
          addr1: '123 Main St',
          city: 'New York',
          state: 'NY',
          zip: '10001',
          default_billing: true,
          default_shipping: false
        }
        
        addressbook = described_class.new(attributes)
        
        expect(addressbook.label).to eq('Home Address')
        expect(addressbook.addr1).to eq('123 Main St')
        expect(addressbook.city).to eq('New York')
        expect(addressbook.state).to eq('NY')
        expect(addressbook.zip).to eq('10001')
        expect(addressbook.default_billing).to eq(true)
        expect(addressbook.default_shipping).to eq(false)
      end

      it 'handles nested :addressbook hash' do
        attributes = {
          addressbook: {
            label: 'Office',
            addr1: '456 Business Ave',
            city: 'Boston',
            state: 'MA',
            zip: '02101'
          }
        }
        
        addressbook = described_class.new(attributes)
        
        expect(addressbook.label).to eq('Office')
        expect(addressbook.addr1).to eq('456 Business Ave')
        expect(addressbook.city).to eq('Boston')
        expect(addressbook.state).to eq('MA')
        expect(addressbook.zip).to eq('02101')
      end

      it 'handles empty hash' do
        addressbook = described_class.new({})
        expect(addressbook).to be_a(described_class)
      end

      it 'sets all legacy fields' do
        attributes = {
          label: 'Warehouse',
          attention: 'John Doe',
          addressee: 'ACME Corp',
          phone: '555-1234',
          addr1: '100 Industrial Blvd',
          addr2: 'Suite 200',
          addr3: 'Building A',
          city: 'Houston',
          state: 'TX',
          zip: '77001',
          country: '_unitedStates',
          override: true,
          is_residential: false,
          default_shipping: true,
          default_billing: false,
          internal_id: '12345'
        }
        
        addressbook = described_class.new(attributes)
        
        expect(addressbook.label).to eq('Warehouse')
        expect(addressbook.attention).to eq('John Doe')
        expect(addressbook.addressee).to eq('ACME Corp')
        expect(addressbook.phone).to eq('555-1234')
        expect(addressbook.addr1).to eq('100 Industrial Blvd')
        expect(addressbook.addr2).to eq('Suite 200')
        expect(addressbook.addr3).to eq('Building A')
        expect(addressbook.city).to eq('Houston')
        expect(addressbook.state).to eq('TX')
        expect(addressbook.zip).to eq('77001')
        expect(addressbook.country.to_record).to eq('_unitedStates')
        expect(addressbook.override).to eq(true)
        expect(addressbook.is_residential).to eq(false)
        expect(addressbook.default_shipping).to eq(true)
        expect(addressbook.default_billing).to eq(false)
        expect(addressbook.internal_id).to eq('12345')
      end
    end

    context 'when initialized with another ContactAddressbook instance' do
      before do
        allow(NetSuite::Configuration).to receive(:api_version).and_return('2013_1')
      end

      it 'calls initialize_from_record' do
        original = described_class.new(
          label: 'Home',
          addr1: '789 Oak Lane',
          city: 'Chicago',
          state: 'IL',
          zip: '60601',
          default_billing: true,
          default_shipping: false
        )
        
        copy = described_class.new(original)
        
        expect(copy.label).to eq(original.label)
        expect(copy.addr1).to eq(original.addr1)
        expect(copy.city).to eq(original.city)
        expect(copy.state).to eq(original.state)
        expect(copy.zip).to eq(original.zip)
        expect(copy.default_billing).to eq(original.default_billing)
        expect(copy.default_shipping).to eq(original.default_shipping)
      end
    end
  end

  describe '#initialize_from_record' do
    let(:source_record) { described_class.new }

    context 'when API version is less than 2014_2' do
      before do
        allow(NetSuite::Configuration).to receive(:api_version).and_return('2013_1')
      end

      it 'copies all legacy fields from the source record' do
        source_record.default_shipping = true
        source_record.default_billing = false
        source_record.is_residential = true
        source_record.label = 'Warehouse'
        source_record.attention = 'John Doe'
        source_record.addressee = 'ACME Corp'
        source_record.phone = '555-1234'
        source_record.addr1 = '100 Industrial Blvd'
        source_record.addr2 = 'Suite 200'
        source_record.addr3 = 'Building A'
        source_record.city = 'Houston'
        source_record.zip = '77001'
        source_record.addr_text = 'Complete address text'
        source_record.override = true
        source_record.state = 'TX'
        source_record.internal_id = '12345'

        new_record = described_class.new
        new_record.send(:initialize_from_record, source_record)

        expect(new_record.default_shipping).to eq(true)
        expect(new_record.default_billing).to eq(false)
        expect(new_record.is_residential).to eq(true)
        expect(new_record.label).to eq('Warehouse')
        expect(new_record.attention).to eq('John Doe')
        expect(new_record.addressee).to eq('ACME Corp')
        expect(new_record.phone).to eq('555-1234')
        expect(new_record.addr1).to eq('100 Industrial Blvd')
        expect(new_record.addr2).to eq('Suite 200')
        expect(new_record.addr3).to eq('Building A')
        expect(new_record.city).to eq('Houston')
        expect(new_record.zip).to eq('77001')
        expect(new_record.addr_text).to eq('Complete address text')
        expect(new_record.override).to eq(true)
        expect(new_record.state).to eq('TX')
        expect(new_record.internal_id).to eq('12345')
      end

      it 'handles nil values for all fields' do
        new_record = described_class.new
        new_record.send(:initialize_from_record, source_record)

        expect(new_record.default_shipping).to be_nil
        expect(new_record.default_billing).to be_nil
        expect(new_record.is_residential).to be_nil
        expect(new_record.label).to be_nil
        expect(new_record.attention).to be_nil
        expect(new_record.addressee).to be_nil
        expect(new_record.phone).to be_nil
        expect(new_record.addr1).to be_nil
        expect(new_record.addr2).to be_nil
        expect(new_record.addr3).to be_nil
        expect(new_record.city).to be_nil
        expect(new_record.zip).to be_nil
        expect(new_record.addr_text).to be_nil
        expect(new_record.override).to be_nil
        expect(new_record.state).to be_nil
        expect(new_record.internal_id).to be_nil
      end

      it 'handles partial field values' do
        source_record.label = 'Partial Address'
        source_record.addr1 = '123 Main St'
        source_record.city = 'Boston'

        new_record = described_class.new
        new_record.send(:initialize_from_record, source_record)

        expect(new_record.label).to eq('Partial Address')
        expect(new_record.addr1).to eq('123 Main St')
        expect(new_record.city).to eq('Boston')
        expect(new_record.addr2).to be_nil
        expect(new_record.state).to be_nil
      end
    end

    context 'when API version is 2014_2 or greater' do
      before do
        allow(NetSuite::Configuration).to receive(:api_version).and_return('2014_2')
      end

      it 'copies only the modern API fields from the source record' do
        address_obj = NetSuite::Records::Address.new(addr1: '123 Modern St')
        source_record.addressbook_address = address_obj
        source_record.default_billing = true
        source_record.default_shipping = false
        source_record.internal_id = '67890'
        source_record.is_residential = true
        source_record.label = 'Corporate HQ'

        new_record = described_class.new
        new_record.send(:initialize_from_record, source_record)

        expect(new_record.addressbook_address).to eq(address_obj)
        expect(new_record.default_billing).to eq(true)
        expect(new_record.default_shipping).to eq(false)
        expect(new_record.internal_id).to eq('67890')
        expect(new_record.is_residential).to eq(true)
        expect(new_record.label).to eq('Corporate HQ')
      end

      it 'does not copy legacy fields in modern API' do
        source_record.attention = 'Should not copy'
        source_record.addressee = 'Should not copy'
        source_record.phone = 'Should not copy'
        source_record.addr1 = 'Should not copy'
        source_record.addr2 = 'Should not copy'
        source_record.addr3 = 'Should not copy'
        source_record.city = 'Should not copy'
        source_record.zip = 'Should not copy'
        source_record.addr_text = 'Should not copy'
        source_record.override = true
        source_record.state = 'Should not copy'

        new_record = described_class.new
        new_record.send(:initialize_from_record, source_record)

        # These fields should not be set in 2014_2+ API
        expect(new_record.attention).to be_nil
        expect(new_record.addressee).to be_nil
        expect(new_record.phone).to be_nil
        expect(new_record.addr1).to be_nil
        expect(new_record.addr2).to be_nil
        expect(new_record.addr3).to be_nil
        expect(new_record.city).to be_nil
        expect(new_record.zip).to be_nil
        expect(new_record.addr_text).to be_nil
        expect(new_record.override).to be_nil
        expect(new_record.state).to be_nil
      end

      it 'handles nil values for modern API fields' do
        new_record = described_class.new
        new_record.send(:initialize_from_record, source_record)

        expect(new_record.default_billing).to be_nil
        expect(new_record.default_shipping).to be_nil
        expect(new_record.internal_id).to be_nil
        expect(new_record.is_residential).to be_nil
        expect(new_record.label).to be_nil
      end
    end

    context 'API version boundary testing' do
      it 'uses legacy path when version is 2013_2' do
        allow(NetSuite::Configuration).to receive(:api_version).and_return('2013_2')
        
        source_record.addr1 = 'Legacy Street'
        source_record.city = 'Legacy City'
        
        new_record = described_class.new
        new_record.send(:initialize_from_record, source_record)

        expect(new_record.addr1).to eq('Legacy Street')
        expect(new_record.city).to eq('Legacy City')
      end

      it 'uses modern path when version is exactly 2014_2' do
        allow(NetSuite::Configuration).to receive(:api_version).and_return('2014_2')
        
        address_obj = NetSuite::Records::Address.new
        source_record.addressbook_address = address_obj
        source_record.addr1 = 'Should not be copied'
        
        new_record = described_class.new
        new_record.send(:initialize_from_record, source_record)

        expect(new_record.addressbook_address).to eq(address_obj)
        expect(new_record.addr1).to be_nil
      end

      it 'uses modern path when version is greater than 2014_2' do
        allow(NetSuite::Configuration).to receive(:api_version).and_return('2019_1')
        
        address_obj = NetSuite::Records::Address.new
        source_record.addressbook_address = address_obj
        source_record.label = 'Future Label'
        
        new_record = described_class.new
        new_record.send(:initialize_from_record, source_record)

        expect(new_record.addressbook_address).to eq(address_obj)
        expect(new_record.label).to eq('Future Label')
      end
    end
  end

  describe 'integration scenarios' do
    context 'copying records in legacy API version' do
      before do
        allow(NetSuite::Configuration).to receive(:api_version).and_return('2013_1')
      end

      it 'successfully copies a complete legacy record' do
        original = described_class.new(
          label: 'Test Address',
          addr1: '123 Test St',
          addr2: 'Apt 4B',
          city: 'Test City',
          state: 'TS',
          zip: '12345',
          attention: 'Jane Doe',
          phone: '555-5555',
          default_billing: true,
          default_shipping: false,
          is_residential: true,
          internal_id: '999'
        )
        
        copy = described_class.new(original)
        
        expect(copy.label).to eq('Test Address')
        expect(copy.addr1).to eq('123 Test St')
        expect(copy.addr2).to eq('Apt 4B')
        expect(copy.city).to eq('Test City')
        expect(copy.state).to eq('TS')
        expect(copy.zip).to eq('12345')
        expect(copy.attention).to eq('Jane Doe')
        expect(copy.phone).to eq('555-5555')
        expect(copy.default_billing).to eq(true)
        expect(copy.default_shipping).to eq(false)
        expect(copy.is_residential).to eq(true)
        expect(copy.internal_id).to eq('999')
      end
    end

    context 'copying records in modern API version' do
      before do
        allow(NetSuite::Configuration).to receive(:api_version).and_return('2019_1')
      end

      it 'successfully copies a modern record' do
        address_obj = NetSuite::Records::Address.new(
          addr1: '456 Modern Ave',
          city: 'Modern City',
          state: 'MC'
        )
        
        original = described_class.new(
          addressbook_address: address_obj,
          label: 'Test Address',
          default_billing: true,
          default_shipping: false,
          is_residential: true,
          internal_id: '888'
        )
        
        copy = described_class.new(original)
        
        expect(copy.addressbook_address).to eq(address_obj)
        expect(copy.label).to eq('Test Address')
        expect(copy.default_billing).to eq(true)
        expect(copy.default_shipping).to eq(false)
        expect(copy.is_residential).to eq(true)
        expect(copy.internal_id).to eq('888')
      end
    end
  end

  describe 'edge cases' do
    it 'handles special characters in address fields' do
      addressbook = described_class.new(
        addr1: "O'Reilly St. #123",
        city: "San José",
        label: "Manager's Office"
      )
      
      expect(addressbook.addr1).to eq("O'Reilly St. #123")
      expect(addressbook.city).to eq("San José")
      expect(addressbook.label).to eq("Manager's Office")
    end

    it 'handles empty strings' do
      addressbook = described_class.new(
        label: '',
        addr1: ''
      )
      
      expect(addressbook.label).to eq('')
      expect(addressbook.addr1).to eq('')
    end

    it 'handles very long address strings' do
      long_address = 'A' * 500
      addressbook = described_class.new(addr1: long_address)
      
      expect(addressbook.addr1).to eq(long_address)
      expect(addressbook.addr1.length).to eq(500)
    end

    it 'handles zip+4 format' do
      addressbook = described_class.new(zip: '12345-6789')
      expect(addressbook.zip).to eq('12345-6789')
    end

    it 'handles international postal codes' do
      addressbook = described_class.new(zip: 'SW1A 1AA')
      expect(addressbook.zip).to eq('SW1A 1AA')
    end
  end

  describe 'boolean field behaviors' do
    it 'handles default_shipping boolean values' do
      addressbook = described_class.new
      
      expect(addressbook.default_shipping).to be_nil
      
      addressbook.default_shipping = true
      expect(addressbook.default_shipping).to eq(true)
      
      addressbook.default_shipping = false
      expect(addressbook.default_shipping).to eq(false)
    end

    it 'handles default_billing boolean values' do
      addressbook = described_class.new
      
      expect(addressbook.default_billing).to be_nil
      
      addressbook.default_billing = true
      expect(addressbook.default_billing).to eq(true)
      
      addressbook.default_billing = false
      expect(addressbook.default_billing).to eq(false)
    end

    it 'handles is_residential boolean values' do
      addressbook = described_class.new
      
      expect(addressbook.is_residential).to be_nil
      
      addressbook.is_residential = true
      expect(addressbook.is_residential).to eq(true)
      
      addressbook.is_residential = false
      expect(addressbook.is_residential).to eq(false)
    end

    it 'handles override boolean values' do
      addressbook = described_class.new
      
      expect(addressbook.override).to be_nil
      
      addressbook.override = true
      expect(addressbook.override).to eq(true)
      
      addressbook.override = false
      expect(addressbook.override).to eq(false)
    end
  end

  describe 'record mutation' do
    it 'allows changing field values after initialization' do
      addressbook = described_class.new(
        label: 'Old Label',
        addr1: 'Old Address',
        city: 'Old City'
      )

      addressbook.label = 'New Label'
      addressbook.addr1 = 'New Address'
      addressbook.city = 'New City'

      expect(addressbook.label).to eq('New Label')
      expect(addressbook.addr1).to eq('New Address')
      expect(addressbook.city).to eq('New City')
    end

    it 'allows clearing field values' do
      addressbook = described_class.new(
        label: 'Some Label',
        addr1: 'Some Address',
        default_billing: true
      )

      addressbook.label = nil
      addressbook.addr1 = nil
      addressbook.default_billing = nil

      expect(addressbook.label).to be_nil
      expect(addressbook.addr1).to be_nil
      expect(addressbook.default_billing).to be_nil
    end
  end

  describe '#record_type' do
    it 'returns the correct SOAP record type' do
      expect(contact_addressbook.record_type).to eql('listRel:ContactAddressbook')
    end
  end
end
