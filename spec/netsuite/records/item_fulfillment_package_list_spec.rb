require 'spec_helper'

describe NetSuite::Records::ItemFulfillmentPackageList do
  let(:list) { NetSuite::Records::ItemFulfillmentPackageList.new }

  it 'has a packages attribute' do
    list.packages.should be_kind_of(Array)
  end

  describe '#to_record' do
    before do
      list.packages << NetSuite::Records::ItemFulfillmentPackage.new(
        :package_tracking_number => '1Z12354645757686786'
      )
    end

    it 'can represent itself as a SOAP record' do
      record = {
          'tranSales:package' => [
            'tranSales:packageTrackingNumber' => '1Z12354645757686786'
          ]
        }
      
      list.to_record.should eql(record)
    end
  end
end
