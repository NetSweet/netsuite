require 'spec_helper'

describe NetSuite::Records::CustomFieldList do
  let(:list) { NetSuite::Records::CustomFieldList.new }

  it 'has a custom_fields attribute' do
    list.custom_fields.should be_kind_of(Array)
  end

  describe '#to_record' do
    before do
      list.custom_fields << NetSuite::Records::CustomField.new(
        :internal_id => 'custentity_registeredonline',
        :type        => 'BooleanCustomFieldRef',
        :value       => false
      )
      list.custom_fields << NetSuite::Records::CustomField.new(
        :internal_id => 'custbody_salesclassification',
        :type        => 'SelectCustomFieldRef',
        :value       => NetSuite::Records::CustomRecordRef.new(:internal_id => 13, :name => "The Name")
      )
    end

    it 'can represent itself as a SOAP record' do
      record = [
        {
          "platformCore:customField" => {
            "@internalId" => "custentity_registeredonline",
            "@xsi:type" => "BooleanCustomFieldRef",
            :content! => { "platformCore:value" => false }
          }
        },
        {
          "platformCore:customField" => {
            '@internalId' => 'custbody_salesclassification',
            '@xsi:type' => 'BooleanCustomFieldRef',
            :content! => { "platformCore:value" => true }
          }
        }
      ]

      list.to_record.should eql(record)
      list.to_record.length.should == 2
    end
  end

end
