require 'spec_helper'

describe NetSuite::Records::CustomFieldList do
  let(:list) { NetSuite::Records::CustomFieldList.new }

  it 'has a custom_fields attribute' do
    list.custom_fields.should be_kind_of(Array)
  end

  it 'accepts a collection of CustomField records' do
    field = NetSuite::Records::CustomField.new({:value=>{:internal_id=>"5", :type_id=>"103"},
             :script_id=>"custitem_item_category", :"@xsi:type"=>"platformCore:SelectCustomFieldRef"})
    list = described_class.new(custom_field: [field])
    expect(list.custom_fields).to eq([field])
  end

  context 'initializing with custom field attributes without a type' do
    it 'does not mutate the attributes' do
      field = {:value=>{:internal_id=>"5", :type_id=>"103"},
               :script_id=>"custitem_item_category"}
      described_class.new(custom_field: [field])
      expect(field).to eq({:value=>{:internal_id=>"5", :type_id=>"103"},
               :script_id=>"custitem_item_category"})
    end
  end

  context 'initializing with custom field attributes and a type' do
    it 'does not mutate the attributes' do
      field = {:value=>{:internal_id=>"5", :type_id=>"103"},
               :script_id=>"custitem_item_category", :"@xsi:type"=>"platformCore:SelectCustomFieldRef"}
      described_class.new(custom_field: [field])
      expect(field).to eq({:value=>{:internal_id=>"5", :type_id=>"103"},
               :script_id=>"custitem_item_category", :"@xsi:type"=>"platformCore:SelectCustomFieldRef"})
    end
  end

  context 'writing convience methods' do
    it "should create a custom field entry when none exists" do
      list.custrecord_somefield = 'a value'
      list.custom_fields.size.should == 1
      list.custom_fields.first.value.should == 'a value'
      list.custom_fields.first.type.should == 'platformCore:StringCustomFieldRef'
    end

    it "should handle date custom field creation" do
      list.custrecord_somefield = Date.parse("12/12/2012")
      list.custom_fields.first.value.should == '2012-12-12T00:00:00+00:00'
    end

    it "should handle datetime custom field creation" do
      list.custrecord_somefield = DateTime.parse("12/12/2012 10:05am")
      list.custom_fields.first.value.should == '2012-12-12T10:05:00+00:00'
    end

    it "should convert a list of numbers into a list of custom field refs" do
      list.custrecord_somefield = [1,2]
      list.custom_fields.first.type.should == 'platformCore:MultiSelectCustomFieldRef'
      list.custom_fields.first.value.map(&:to_record).should eql([
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

      list.to_record.should eql(record)
      list.to_record.length.should == 1
    end
  end

end
