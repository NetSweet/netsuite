require 'spec_helper'

describe NetSuite::Records::CustomerAddressbookList do
  let(:list) { NetSuite::Records::CustomerAddressbookList.new }

  it 'has an addressbooks attribute' do
    list.addressbooks.should be_kind_of(Array)
  end

  describe '#to_record' do
    it 'can represent itself as a SOAP record' do
      record = {
        'listRel:addressbook' => []
      }
      list.to_record.should eql(record)
    end
  end

end
