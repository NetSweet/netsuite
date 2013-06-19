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
      list.custom_fields << NetSuite::Records::CustomField.new(
        :internal_id => '4',
        :type        => 'BooleanCustomFieldRef',
        :value       => true
      )
    end

    it 'can represent itself as a SOAP record' do
      list.to_record.length.should == 2
      Gyoku.xml(list.to_record[0]).should == '<platformCore:customField internalId="3" xsi:type="BooleanCustomFieldRef">false</platformCore:customField>'
    end
  end

end
