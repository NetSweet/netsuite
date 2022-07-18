require 'spec_helper'

describe NetSuite::Records::RecordRef do
  let(:null_field_list) { NetSuite::Records::NullFieldList.new }

  describe '#to_record' do
    it 'can represent itself as a SOAP record for single value' do
      null_field_list.name = 'blah'
      record = {
        'platformCore:name' => 'blah'
      }
      expect(null_field_list.to_record).to eql(record)
    end

    it 'can represent itself as a SOAP record for multiple values' do
      null_field_list.name = ['blah', 'foo']
      record = {
        'platformCore:name' => ['blah', 'foo']
      }
      expect(null_field_list.to_record).to eql(record)
    end
  end

  describe '#record_type' do
    it 'returns a string of the SOAP type' do
      expect(null_field_list.record_type).to eql('platformCore:NullFieldList')
    end
  end

end
