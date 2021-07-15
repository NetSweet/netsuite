require 'spec_helper'

describe NetSuite::Records::CustomFieldList do
  let(:list) { NetSuite::Records::CustomFieldList.new }

  before(:all) { savon.mock! }
  after(:all) { savon.unmock! }

  it 'has a custom_fields attribute' do
    expect(list.custom_fields).to be_kind_of(Array)
  end

  it 'accepts a collection of CustomField records' do
    field = NetSuite::Records::CustomField.new({
      :value=>{:internal_id=>"5", :type_id=>"103"},
      :script_id=>"custitem_item_category",
      :"@xsi:type"=>"platformCore:SelectCustomFieldRef"
    })

    list = described_class.new(custom_field: [field])

    expect(list.custom_fields).to eq([field])
  end

  it 'properly decodes various custom field types' do
    savon.
      expects(:get).
      with(message: {"platformMsgs:baseRef"=>{"@xsi:type"=>"platformCore:RecordRef", "@internalId"=>123, "@type"=>"creditMemo"}}).
      returns(File.read('spec/support/fixtures/custom_fields/multi_select.xml'))

    credit_memo_with_custom_fields = NetSuite::Records::CreditMemo.get(123)

    expect(credit_memo_with_custom_fields.custom_field_list.custbody_standard_select.value.internal_id).to eq("2")
    expect(credit_memo_with_custom_fields.custom_field_list.custbody_standard_select.value.attributes[:name]).to eq("Manual")

    expect(credit_memo_with_custom_fields.custom_field_list.custbody_date_field.value).to be_a(DateTime)
    expect(credit_memo_with_custom_fields.custom_field_list.custbody_date_field.value.to_s).to eq("2021-07-13T22:00:00-07:00")

    expect(credit_memo_with_custom_fields.custom_field_list.custbody_string_field.value).to eq("a very nice string")
    expect(credit_memo_with_custom_fields.custom_field_list.custbody_boolean_field.value).to eq(false)

    # even if there's a single value, it should return an array
    expect(credit_memo_with_custom_fields.custom_field_list.custbody_multi_select_field.value).to be_a(Array)
    expect(credit_memo_with_custom_fields.custom_field_list.custbody_multi_select_field.value.size).to eq(1)
    expect(credit_memo_with_custom_fields.custom_field_list.custbody_multi_select_field.value.first.attributes[:name]).to eq("selection value")

    expect(credit_memo_with_custom_fields.custom_field_list.custbody_multi_select_with_multiple.value).to be_a(Array)
    expect(credit_memo_with_custom_fields.custom_field_list.custbody_multi_select_with_multiple.value.size).to eq(2)
    expect(credit_memo_with_custom_fields.custom_field_list.custbody_multi_select_with_multiple.value.first.attributes[:name]).to eq("selection value 1")
    expect(credit_memo_with_custom_fields.custom_field_list.custbody_multi_select_with_multiple.value.last.attributes[:name]).to eq("selection value 2")
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
      custom_fields = list.custom_fields

      expect(custom_fields.size).to eq(1)
      expect(custom_fields.first.value).to eq('a value')
      expect(custom_fields.first.type).to eq('platformCore:StringCustomFieldRef')
    end

    # https://github.com/NetSweet/netsuite/issues/325
    it 'should create a custom field entry when some fields exist without scriptIds' do
      list.custom_fields << NetSuite::Records::CustomField.new
      list.custrecord_somefield = 123
    end
  end

  context 'custom field internalId-to-scriptId transition at WSDL 2013_2:' do
    before(:context) { @reset = NetSuite::Configuration.api_version }
    after(:context)  { NetSuite::Configuration.api_version = @reset }

    transition_version = '2013_2'

    ['2012_2', '2013_2', '2014_2'].each do |version|

      comparison = ['==', '>', '<'][version <=> transition_version]

      context "when WSDL version #{comparison} #{transition_version}," do
        before { NetSuite::Configuration.api_version = version }

        context 'convenience methods' do
          reference_id_type = version < transition_version ? :internal_id : :script_id

          it "should create a custom field entry when none exists" do
            list.some_custom_field = 'a value'

            expect(list.custom_fields.size).to eq(1)
            expect(list.custom_fields.first.value).to eq('a value')
            expect(list.custom_fields.first.type).to eq('platformCore:StringCustomFieldRef')
          end

          it "should set #{reference_id_type} to method name when creating a custom field" do
            list.some_custom_field = 'a value'

            expect(list.some_custom_field.send(reference_id_type)).to eq('some_custom_field')
          end

          it "should update a custom field's value when one exists" do
            list.existing_custom_field = 'old value'
            list.existing_custom_field = 'new value'

            expect(list.existing_custom_field.value).to eq('new value')
          end

          it "should handle date custom field creation" do
            list.some_custom_field = Date.parse("12/12/2012")

            expect(list.custom_fields.first.value).to eq('2012-12-12T00:00:00+00:00')
          end

          it "should handle datetime custom field creation" do
            list.some_custom_field = DateTime.parse("12/12/2012 10:05am")

            expect(list.custom_fields.first.value).to eq('2012-12-12T10:05:00+00:00')
          end

          it "should convert a list of numbers into a list of custom field refs" do
            list.some_custom_field = [1,2]

            expect(list.custom_fields.first.type).to eq('platformCore:MultiSelectCustomFieldRef')
            expect(list.custom_fields.first.value.map(&:to_record)).to eql([
              NetSuite::Records::CustomRecordRef.new(:internal_id => 1),
              NetSuite::Records::CustomRecordRef.new(:internal_id => 2)
            ].map(&:to_record))
          end

          it "should return custom field record when entry exists" do
            list.existing_custom_field = 'a value'

            expect(list.existing_custom_field).to be_a(NetSuite::Records::CustomField)
            expect(list.existing_custom_field.value).to eq('a value')
          end

          it "should raise an error if custom field entry does not exist" do
            expect{ list.nonexisting_custom_field }.to raise_error(NoMethodError)
          end
        end
      end
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

    context "when custom field list is initialised from a hash" do
      let(:attributes) do
        {
          custom_field: [
            {
              script_id: "custentity_registeredonline",
              type: "platformCore:SelectCustomFieldRef",
              value: { internal_id: 200, type_id: 1 },
            },
            {
              script_id: "custbody_salesclassification",
              type: "platformCore:StringCustomFieldRef",
              value: "foobar"
            },
            {
              script_id: 'custbody_multipleselectfield',
              type: "platformCore:MultiSelectCustomFieldRef",
              value: [
                {
                  internal_id: 405,
                  type_id: 157
                },
                {
                  internal_id: 419,
                  type_id: 157
                }
              ]
            }
          ]
        }
      end

      it "can represent itself as a SOAP record" do
        list = NetSuite::Records::CustomFieldList.new(attributes)

        record = {
          "platformCore:customField" => [
            {
              "@scriptId" => "custentity_registeredonline",
              "@xsi:type" => "platformCore:SelectCustomFieldRef",
              "platformCore:value" => {:@internalId => 200, :@typeId => "1"},
            },
            {
              "@scriptId" => "custbody_salesclassification",
              "@xsi:type" => "platformCore:StringCustomFieldRef",
              "platformCore:value" => "foobar",
            },
            {
              '@scriptId' => 'custbody_multipleselectfield',
              '@xsi:type' => 'platformCore:MultiSelectCustomFieldRef',
              'platformCore:value' => [
                {
                  :@internalId => 405,
                  :@typeId => "157"
                },
                {
                  :@internalId => 419,
                  :@typeId => "157"
                }
              ]
            }
          ]
        }

        # field accessors are tested elsewhere, but let's run tests here to check various field types
        expect(list).to respond_to(:custbody_multipleselectfield)
        expect(list).to respond_to(:custbody_salesclassification)
        expect(list).to respond_to(:custentity_registeredonline)

        expect(list.to_record).to eql(record)
        expect(list.to_record.length).to eq(1)
      end
    end

    # https://github.com/NetSweet/netsuite/issues/182
    it 'handles custom fields without an internalId or scriptId' do
      custom_list = NetSuite::Records::CustomFieldList.new({custom_field: { '@xsi:type' => 'platformCore:StringCustomFieldRef' }})
    end
  end

end
