require 'spec_helper'

describe NetSuite::Records::RecordRef do
  let(:record_ref) { NetSuite::Records::RecordRef.new }

  describe 'internal_id' do
    context 'when passing in as plain attribute to initialize' do
      it 'correctly sets the internal_id' do
        record_ref = NetSuite::Records::RecordRef.new(:internal_id => '1')
        expect(record_ref.internal_id).to eql('1')
      end
    end

    context 'when passing in as swirly attributes to initialize' do
      it 'correctly sets the internal_id' do
        record_ref = NetSuite::Records::RecordRef.new(:@internal_id => '2')
        expect(record_ref.internal_id).to eql('2')
      end
    end

    context 'when not passed in as an attribute to initialize' do
      it 'does not set an internal_id' do
        record_ref = NetSuite::Records::RecordRef.new
        expect(record_ref.internal_id).to be_nil
      end
    end

    it 'has no public internal_id setter' do
      expect(record_ref).not_to respond_to(:internal_id=)
    end
  end

  describe 'attributes' do
    let(:record_ref) do
      NetSuite::Records::RecordRef.new(
        :name   => 'This is a record_ref',
        :banana => 'for monkeys'
      )
    end

    context 'readers' do
      it 'can take on arbitrary attributes into itself on initialization' do
        expect(record_ref.name).to eql('This is a record_ref')
        expect(record_ref.banana).to eql('for monkeys')
      end

      it 'should have truthy result for respond_to existing attribute' do
        record_ref.respond_to?(:name).should be_true
      end

      it 'should have false result for respond_to missing attribute' do
        record_ref.respond_to?(:apple).should be_false
      end
    end
  end

  describe 'untouchables' do
    let(:record_ref) do
      NetSuite::Records::RecordRef.new(
        :"@xmlns:platform_core" => 'something'
      )
    end

    it 'ignores untouchable attributes' do
      expect(record_ref.instance_variable_get('@attributes').keys).not_to include(:"@xmlns:platform_core")
    end
  end

  describe 'initialize from record' do
    it 'initializes a new ref with the proper attributes from the record' do
      record = NetSuite::Records::Classification.new(:is_inactive => false, :name => 'Retail', :internal_id => '9')
      record_ref = NetSuite::Records::RecordRef.new(record)
      expect(record_ref).to be_kind_of(NetSuite::Records::RecordRef)
      expect(record_ref.internal_id).to eql('9')
      expect(record_ref.type).to eql('classification')
    end
  end

  describe '#to_record' do
    it 'can represent itself as a SOAP record' do
      record_ref = NetSuite::Records::RecordRef.new(:something => 'blah')
      record = {
        'platformCore:something' => 'blah'
      }
      expect(record_ref.to_record).to eql(record)
    end
  end

  describe '#record_type' do
    it 'returns a string of the SOAP type' do
      expect(record_ref.record_type).to eql('platformCore:RecordRef')
    end
  end

end
