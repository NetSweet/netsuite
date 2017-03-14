require 'spec_helper'

describe NetSuite::Actions::GetDeleted do
  before(:all) { savon.mock!  }
  after(:all) { savon.unmock! }

  describe 'Invoice' do
    before do
      savon.expects(:get_deleted).with(:message => {
        'platformMsgs:pageIndex' => 1,
        'platformMsgs:getDeletedFilter' => {
          "platformCore:type" => {
            "@operator" =>"anyOf",
            "platformCore:searchValue" => ["invoice"],
          },
          "platformCore:deletedDate" => {
            "@operator" =>"within",
            "platformCore:searchValue" => "2016-12-01T00:00:00",
            "platformCore:searchValue2" => "2016-12-02T00:00:00",
          }
        }
      }).returns(File.read('spec/support/fixtures/get_deleted/get_deleted_invoices.xml'))
    end

    it 'makes a valid request to the NetSuite API' do
      NetSuite::Actions::GetDeleted.call([NetSuite::Records::Invoice, { page: 1, criteria: [
        {
          field: 'type',
          operator: 'anyOf',
          type: 'SearchEnumMultiSelectField',
          value: ["invoice"]
        },
        {
          field: 'deletedDate',
          operator: "within",
          type: 'SearchDateField',
          value: ["2016-12-01T00:00:00","2016-12-02T00:00:00"]
        }
      ]}])
    end

    it 'returns a valid Response object' do
      response = NetSuite::Actions::GetDeleted.call([NetSuite::Records::Invoice, { page: 1, criteria: [
        {
          field: 'type',
          operator: 'anyOf',
          type: 'SearchEnumMultiSelectField',
          value: ["invoice"]
        },
        {
          field: 'deletedDate',
          operator: "within",
          type: 'SearchDateField',
          value: ["2016-12-01T00:00:00","2016-12-02T00:00:00"]
        }
      ]}])
      expect(response).to be_kind_of(NetSuite::Response)
    end
  end
end
