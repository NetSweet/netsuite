require 'spec_helper'

describe NetSuite::Records::ItemFulfillmentPackageUspsList do
  let(:list) { NetSuite::Records::ItemFulfillmentPackageUspsList.new }

  it 'has a packages attribute' do
    expect(list.packages).to be_kind_of(Array)
  end

  describe '#to_record' do
    before do
      list.packages << NetSuite::Records::ItemFulfillmentPackageUsps.new(
        :package_tracking_number_usps => '1Z12354645757686786'
      )
    end

    it 'can represent itself as a SOAP record' do
      record = {
          'tranSales:packageUsps' => [
            'tranSales:packageTrackingNumberUsps' => '1Z12354645757686786'
          ]
        }
      
      expect(list.to_record).to eql(record)
    end
  end
end
