require 'spec_helper'

describe NetSuite::Records::InventoryAdjustment do
  let(:adjustment) { NetSuite::Records::InventoryAdjustment.new }

  describe '.get' do
    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :tran_id => 1 }) }

      it 'returns a InventoryAdjustment instance populated with the data from the response object' do
        NetSuite::Actions::Get.should_receive(:call).with(NetSuite::Records::InventoryAdjustment, :external_id => 1).and_return(response)
        adjustment = NetSuite::Records::InventoryAdjustment.get(:external_id => 1)
        adjustment.should be_kind_of(NetSuite::Records::InventoryAdjustment)
        adjustment.tran_id.should == 1
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'raises a RecordNotFound exception' do
        NetSuite::Actions::Get.should_receive(:call).with(NetSuite::Records::InventoryAdjustment, :external_id => 1).and_return(response)
        lambda {
          NetSuite::Records::InventoryAdjustment.get(:external_id => 1)
        }.should raise_error(NetSuite::RecordNotFound,
          /NetSuite::Records::InventoryAdjustment with OPTIONS=(.*) could not be found/)
      end
    end
  end

end
