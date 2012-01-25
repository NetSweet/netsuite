require 'spec_helper'

describe NetSuite::Records::CustomFieldList do
  let(:list) { NetSuite::Records::CustomFieldList.new }

  it 'has a custom_fields attribute' do
    list.custom_fields.should be_kind_of(Array)
  end

  describe '#to_record' do
    before do
      list.custom_fields << NetSuite::Records::CustomField.new(
        :internal_id => '3',
        :type        => 'BooleanCustomFieldRef',
        :value       => false
      )
    end

    it 'can represent itself as a SOAP record' do
      record = "<platformCore:customField internalId=\"3\" xsi:type=\"BooleanCustomFieldRef\"><platformCore:value>false</platformCore:value></platformCore:customField>"
      list.to_record.should eql(record)
    end
  end

end
