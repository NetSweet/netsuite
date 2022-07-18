require 'spec_helper'

describe NetSuite::Actions::Search do
  before(:all) { savon.mock! }
  after(:all) { savon.unmock! }

  it "handles custom auth credentials" do
    allow(NetSuite::Configuration).to receive(:connection).and_return(double().as_null_object)

    credentials = {
      email: 'fake@domain.com',
      password: 'fake'
    }
    NetSuite::Records::Customer.search({}, credentials)

    expect(NetSuite::Configuration).to have_received(:connection).with({:soap_header=>{
      "platformMsgs:passport"=>{
        "platformCore:email"=>"fake@domain.com",
        "platformCore:password"=>"fake",
        "platformCore:account"=>"1234",
        "platformCore:role"=>{:@internalId=>"3"}
      }, "platformMsgs:SearchPreferences"=>{}}}, credentials
    )
  end

  context "search class name" do
    it "infers class name if class doesn't specify search class" do
      instance = described_class.new NetSuite::Records::Customer
      expect(instance.class_name).to eq "Customer"
    end

    it "gets class name from search class specified" do
      instance = described_class.new NetSuite::Records::InventoryItem
      expect(instance.class_name).to eq NetSuite::Records::InventoryItem.search_class_name
    end
  end

  context "saved search" do
    context "with no params" do
      before do
        savon.expects(:search).with(:message => {
          'searchRecord' => {
            '@xsi:type'           => 'listRel:CustomerSearchAdvanced',
            '@savedSearchId'      => 500,
            :content!             => { "listRel:criteria" => {} }
          },
        }).returns(File.read('spec/support/fixtures/search/saved_search_customer.xml'))
      end

      it "should handle a ID only search" do
        result = NetSuite::Records::Customer.search(saved: 500)
        expect(result.results.size).to eq(1)
        expect(result.results.first.email).to eq('aemail@gmail.com')
      end

      it "merges preferences gracefully" do
        expect {
            NetSuite::Records::Customer.search(
              saved: 500,
              preferences: { page_size: 20 }
            )
        }.not_to raise_error
      end
    end

    skip "should handle a ID search with basic params"
    skip "should handle a search with joined params"

    it "should handle a search with joined params containing custom field search" do
      savon.expects(:search).with(:message => {
        'searchRecord' => {
          '@xsi:type'           => 'listRel:CustomerSearchAdvanced',
          '@savedSearchId'      => 500,
          :content!             => {
            "listRel:criteria" => {
              "listRel:basic" => {
                "platformCommon:entityId" => {
                  :content! => {"platformCore:searchValue" => "New Keywords"},
                  :"@operator" => "hasKeywords"
                },
                "platformCommon:stage" => {
                  :content! => {"platformCore:searchValue"=>["_lead", "_customer"]},
                  :"@operator" => "anyOf"
                },
                "platformCommon:customFieldList" => {
                  "platformCore:customField" => [
                    {
                      "platformCore:searchValue" => [{:"@internalId" => 4}, {:"@internalId" => 11}],
                      :attributes! => {
                        "platformCore:searchValue" => { "internalId" => [4, 11] }
                      }
                    },
                    {
                      "platformCore:searchValue" => [{}],
                      :attributes! => {
                        "platformCore:searchValue" => { "internalId" => [88825] }
                      }
                    }
                  ],

                  :attributes! => {
                    "platformCore:customField" => {
                      "scriptId" => ["custentity_customerandcontacttypelist", "custentity_relatedthing"],
                      "operator" => ["anyOf", "anyOf"],
                      "xsi:type" => ["platformCore:SearchMultiSelectCustomField", "platformCore:SearchMultiSelectCustomField"]
                    }
                  }
                }
              }
            },
            "listRel:columns" => [
              {"tranSales:basic"=>{"platformCommon:internalId/"=>{}}}
            ],
          }
        },
      }).returns(File.read('spec/support/fixtures/search/saved_search_joined_custom_customer.xml'))

      search = NetSuite::Records::Customer.search({
        criteria: {
          saved: 500,
          basic: [
            {
              field: 'entityId',
              value: 'New Keywords',
              operator: 'hasKeywords'
            },
            {
              field: 'stage',
              operator: 'anyOf',
              type: 'SearchMultiSelectCustomField',
              value: [
                '_lead',
                '_customer'
              ]
            },
            {
              field: 'customFieldList',
              value: [
                {
                  field: 'custentity_customerandcontacttypelist',
                  operator: 'anyOf',
                  # type is needed for multiselect fields
                  type: 'SearchMultiSelectCustomField',
                  value: [
                    NetSuite::Records::CustomRecordRef.new(:internal_id => 4),
                    NetSuite::Records::CustomRecordRef.new(:internal_id => 11),
                  ]
                },
                {
                  field: 'custentity_relatedthing',
                  # is in the GUI is the equivilent of anyOf with a single element array
                  operator: 'anyOf',
                  type: 'SearchMultiSelectCustomField',
                  value: [
                    NetSuite::Records::Customer.new(:internal_id => 88825)
                  ]
                }
              ]
            }
          ]
        },
        columns: [
          'tranSales:basic' => {
            'platformCommon:internalId/' => {},
          }
        ]
      })

      expect(search.results.size).to eq(2)
      expect(search.current_page).to eq(1)
      expect(search.results.first.internal_id).to eq('123')
      expect(search.results.first.external_id).to eq('456')
      expect(search.results.first.alt_name).to eq('A Awesome Name')
      expect(search.results.first.custom_field_list.custitem_stringfield.value).to eq('sample string value')
      expect(search.results.first.custom_field_list.custitem_apcategoryforsales.value.internal_id).to eq('4')
      expect(search.results.last.email).to eq('alessawesome@gmail.com')
    end

    it "should handle an ID search with basic search only field result columns" do
      response = File.read('spec/support/fixtures/search/saved_search_item.xml')
      savon.expects(:search)
        .with(message: {
          "searchRecord"=>{
            "@xsi:type"      =>"listAcct:ItemSearchAdvanced",
            "@savedSearchId" =>42,
            :content!        =>{"listAcct:criteria"=>{}},
          }
        }).returns(response)

      search = NetSuite::Records::InventoryItem.search(saved: 42)

      expect(search.results.first.location_quantity_available).to eq('3307.0')
      expect(search.results.first.location_re_order_point).to eq('2565.0')
      expect(search.results.first.location_quantity_on_order).to eq('40000.0')
    end
  end

  context "advanced search" do
    skip "should handle search column definitions"
    skip "should handle joined search results"
  end

  context "basic search" do
    it "should handle a basic search matching on RecordRef using internalId" do
      response = File.read('spec/support/fixtures/search/basic_search_contact.xml')
      savon.expects(:search)
        .with(message: {
          "searchRecord" => {
            :content! => {
              "listRel:basic" => {
                "platformCommon:company" => {
                  "@operator" => "anyOf",
                  "@xsi:type" => "platformCore:SearchMultiSelectField",
                  "platformCore:searchValue" => [
                    {
                      :content! => {},
                      "@xsi:type" => "platformCore:RecordRef",
                      "@type" => "account",
                      "@internalId" => 7497,
                    },
                    {
                      :content! => {},
                      "@xsi:type" => "platformCore:RecordRef",
                      "@type" => "account",
                      "@internalId" => 7270,
                    },
                  ],
                },
              },
            },
            "@xsi:type" => "listRel:ContactSearch",
          },
        }).returns(response)

      search = NetSuite::Records::Contact.search(
        basic: [{
          field: 'company',
          operator: 'anyOf',
          value: [
            NetSuite::Records::RecordRef.new(internal_id: 7497),
            NetSuite::Records::RecordRef.new(internal_id: 7270),
          ],
        }],
      )

      expect(search.results.size).to eq(1)
    end

    it "should handle a basic search matching on RecordRef using externalId" do
      response = File.read('spec/support/fixtures/search/basic_search_contact.xml')
      savon.expects(:search)
        .with(message: {
          "searchRecord" => {
            :content! => {
              "listRel:basic" => {
                "platformCommon:company" => {
                  "@operator" => "anyOf",
                  "@xsi:type" => "platformCore:SearchMultiSelectField",
                  "platformCore:searchValue" => [
                    {
                      :content! => {},
                      "@xsi:type" => "platformCore:RecordRef",
                      "@type" => "account",
                      "@externalId" => "external_abc",
                    },
                    {
                      :content! => {},
                      "@xsi:type" => "platformCore:RecordRef",
                      "@type" => "account",
                      "@externalId" => "external_xyz",
                    },
                  ],
                },
              },
            },
            "@xsi:type" => "listRel:ContactSearch",
          },
        }).returns(response)

      search = NetSuite::Records::Contact.search(
        basic: [{
          field: 'company',
          operator: 'anyOf',
          value: [
            NetSuite::Records::RecordRef.new(external_id: "external_abc"),
            NetSuite::Records::RecordRef.new(external_id: "external_xyz"),
          ],
        }],
      )

      expect(search.results.size).to eq(1)
    end

    it "should handle a basic search matching on RecordRef using mix of internalId and externalId" do
      response = File.read('spec/support/fixtures/search/basic_search_contact.xml')
      savon.expects(:search)
        .with(message: {
          "searchRecord" => {
            :content! => {
              "listRel:basic" => {
                "platformCommon:company" => {
                  "@operator" => "anyOf",
                  "@xsi:type" => "platformCore:SearchMultiSelectField",
                  "platformCore:searchValue" => [
                    {
                      :content! => {},
                      "@xsi:type" => "platformCore:RecordRef",
                      "@type" => "account",
                      "@internalId" => 7497,
                    },
                    {
                      :content! => {},
                      "@xsi:type" => "platformCore:RecordRef",
                      "@type" => "account",
                      "@externalId" => "external_xyz",
                    },
                  ],
                },
              },
            },
            "@xsi:type" => "listRel:ContactSearch",
          },
        }).returns(response)

      search = NetSuite::Records::Contact.search(
        basic: [{
          field: 'company',
          operator: 'anyOf',
          value: [
            NetSuite::Records::RecordRef.new(internal_id: 7497),
            NetSuite::Records::RecordRef.new(external_id: "external_xyz"),
          ],
        }],
      )

      expect(search.results.size).to eq(1)
    end

    it "should handle a basic search matching on RecordRef using both internalId and externalId" do
      response = File.read('spec/support/fixtures/search/basic_search_contact.xml')
      savon.expects(:search)
        .with(message: {
          "searchRecord" => {
            :content! => {
              "listRel:basic" => {
                "platformCommon:company" => {
                  "@operator" => "anyOf",
                  "@xsi:type" => "platformCore:SearchMultiSelectField",
                  "platformCore:searchValue" => [
                    {
                      :content! => {},
                      "@xsi:type" => "platformCore:RecordRef",
                      "@type" => "account",
                      "@internalId" => 7497,
                      "@externalId" => "external_abc",
                    },
                    {
                      :content! => {},
                      "@xsi:type" => "platformCore:RecordRef",
                      "@type" => "account",
                      "@externalId" => 7270,
                    },
                  ],
                },
              },
            },
            "@xsi:type" => "listRel:ContactSearch",
          },
        }).returns(response)

      search = NetSuite::Records::Contact.search(
        basic: [{
          field: 'company',
          operator: 'anyOf',
          value: [
            NetSuite::Records::RecordRef.new(internal_id: 7497, external_id: "external_abc"),
            NetSuite::Records::RecordRef.new(external_id: 7270),
          ],
        }],
      )

      expect(search.results.size).to eq(1)
    end

    skip "should handle searching basic fields"
    skip "should handle searching with joined fields"
  end
end
