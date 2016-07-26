require 'spec_helper'

describe NetSuite::Records::ItemVendorList do
  let(:list) { NetSuite::Records::ItemVendorList.new }

  it 'has a item_vendors attribute' do
    expect(list.item_vendors).to be_kind_of(Array)
  end

  describe '#to_record' do
    before do
      list.item_vendors << NetSuite::Records::ItemVendor.new(
        :vendor => {:name => 'Spring Water'}
      )
    end

    it 'can represent itself as a SOAP record' do
      record =  {
        'listAcct:itemVendorList' => [{
          'listAcct:itemVendor' => {
            'listAcct:vendor' => {'platformCore:name' => 'Spring Water'}
          }
        }]
      }
      expect(list.to_record).to eql(record)
    end
  end
end
