require 'spec_helper'

describe NetSuite::Records::CustomerAddressbookList do
  let(:list) { NetSuite::Records::CustomerAddressbookList.new }

  it 'has an addressbooks attribute' do
    expect(list.addressbooks).to be_kind_of(Array)
  end

  describe '#to_record' do
    it 'can represent itself as a SOAP record' do
      record = {
        'listRel:addressbook' => []
      }
      expect(list.to_record).to eql(record)
    end
  end

end
