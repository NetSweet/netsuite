require 'spec_helper'

describe NetSuite::Actions::Search do
  before(:all) { savon.mock! }
  after(:all) { savon.unmock! }

  context "saved search" do
    it "should handle a ID only search" do
      savon.expects(:search).with(:message => {
        'searchRecord' => {
          '@xsi:type'           => 'listRel:CustomerSearchAdvanced',
          '@savedSearchId'      => 500,
          :content!             => { "listRel:criteria" => {} }
        },
      }).returns(File.read('spec/support/fixtures/search/saved_search_customer.xml'))

      result = NetSuite::Records::Customer.search(saved: 500)
      result.results.size.should == 1
      result.results.first.email.should == 'aemail@gmail.com'
    end

    it "should handle a ID search with basic params" do
      
    end

    it "should handle a search with joined params" do
      
    end

    it "should handle a search with joined params containing custom field search" do
      savon.expects(:search).with(:message => {
        'searchRecord' => {
          '@xsi:type'           => 'listRel:CustomerSearchAdvanced',
          '@savedSearchId'      => 500,
          :content!             => {
            "listRel:criteria" => {
              "listRel:basic" => {
                "platformCommon:entityId" => {
                  "platformCore:searchValue" => "New Keywords"
                },

                :attributes! => {
                  "platformCommon:entityId" => { "operator" => "hasKeywords" },
                  "platformCommon:stage" => { "operator" => "anyOf" }
                },

                "platformCommon:stage" => { "platformCore:searchValue" => ["_lead", "_customer"] },
                "platformCommon:customFieldList" => {
                  "platformCore:customField" => [
                    {
                      "platformCore:searchValue" => [{}, {}],
                      :attributes! => {
                        "platformCore:searchValue" => {
                          "internalId" => [4, 11]
                        }
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
                      "internalId" => ["custentity_customerandcontacttypelist", "custentity_relatedthing"],
                      "operator" => ["anyOf", "anyOf"],
                      "xsi:type" => ["platformCore:SearchMultiSelectCustomField", "platformCore:SearchMultiSelectCustomField"]
                    }
                  }
                }
              }
            }
          }
        },
      }).returns(File.read('spec/support/fixtures/search/saved_search_joined_custom_customer.xml'))

      search = NetSuite::Records::Customer.search({
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
      })

      search.results.size.should == 2
      search.results.first.alt_name.should == 'A Awesome Name'
      search.results.last.email.should == 'alessawesome@gmail.com'
    end
  end

  context "advanced search" do
    it "should handle search column definitions" do
      
    end
    
    it "should handle joined search results" do
      
    end
  end

  context "basic search" do
    it "should handle searching basic fields" do
      
    end

    it "should handle searching with joined fields" do
      
    end
  end
end
