require 'spec_helper'

describe NetSuite::Records::CustomFieldList do
  let(:list) { NetSuite::Records::CustomFieldList.new }

  it 'has a custom_fields attribute' do
    expect(list.custom_fields).to be_kind_of(Array)
  end

  context 'writing convience methods' do
    it "should create a custom field entry when none exists" do
      list.custrecord_somefield = 'a value'
      expect(list.custom_fields.size).to eq(1)
      expect(list.custom_fields.first.value).to eq('a value')
      expect(list.custom_fields.first.type).to eq('platformCore:StringCustomFieldRef')
    end

    it "should handle date custom field creation" do
      list.custrecord_somefield = Date.parse("12/12/2012")
      expect(list.custom_fields.first.value).to eq('2012-12-12T00:00:00+00:00')
    end

    it "should handle datetime custom field creation" do
      list.custrecord_somefield = DateTime.parse("12/12/2012 10:05am")
      expect(list.custom_fields.first.value).to eq('2012-12-12T10:05:00+00:00')
    end

    it "should convert a list of numbers into a list of custom field refs" do
      list.custrecord_somefield = [1,2]
      expect(list.custom_fields.first.type).to eq('platformCore:MultiSelectCustomFieldRef')
      expect(list.custom_fields.first.value.map(&:to_record)).to eql([
        NetSuite::Records::CustomRecordRef.new(:internal_id => 1),
        NetSuite::Records::CustomRecordRef.new(:internal_id => 2)
      ].map(&:to_record))
    end
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
      list.custom_fields << NetSuite::Records::CustomField.new(
        :script_id   => 'custbody_accountclassification',
        :type        => 'SelectCustomFieldRef',
        :value       => NetSuite::Records::CustomRecordRef.new(:internal_id => 11, :name => "The Game")
      )
    end

    it 'can represent itself as a SOAP record' do
      record = {
      "platformCore:customField" => [
          {
            'platformCore:value' => 'false',
            "@internalId" => "custentity_registeredonline",
            "@xsi:type" => "BooleanCustomFieldRef",
          },
          {
            '@internalId' => 'custbody_salesclassification',
            '@xsi:type' => 'SelectCustomFieldRef',
            "platformCore:value"=>{"platformCore:name"=>"The Name", :@internalId=>13}
          },
          {
            '@scriptId' => 'custbody_accountclassification',
            '@xsi:type' => 'SelectCustomFieldRef',
            "platformCore:value"=>{"platformCore:name"=>"The Game", :@internalId=>11}
          }
        ]
      }

      expect(list.to_record).to eql(record)
      expect(list.to_record.length).to eq(1)
    end

    # https://github.com/NetSweet/netsuite/issues/182
    it 'handles custom fields without an internalId or scriptId' do
      custom_list = NetSuite::Records::CustomFieldList.new({custom_field: { '@xsi:type' => 'platformCore:StringCustomFieldRef' }})
    end
  end

end
