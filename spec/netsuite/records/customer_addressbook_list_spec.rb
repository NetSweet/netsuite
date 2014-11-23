require 'spec_helper'

describe NetSuite::Records::CustomerAddressbookList do
  let(:list) { NetSuite::Records::CustomerAddressbookList.new }

  it 'has an addressbooks attribute' do
    expect(list.addressbooks).to be_kind_of(Array)
  end

  describe '#to_record' do
    it 'can represent itself as a SOAP record' do
      record = {
        'listRel:addressbook' => [],
        'listRel:replaceAll' => true
      }
      expect(list.to_record).to eql(record)
    end
  end

  describe "#replace_all" do
    it "returns true by default" do
      list.replace_all.should eql(true)
    end

    it "can be changed via accessor" do
      list.replace_all = false

      list.replace_all.should eql(false)
    end

    it "coerces to a boolean" do
      list.replace_all = "goober"
      list.replace_all.should eql(true)
    end
  end

end
