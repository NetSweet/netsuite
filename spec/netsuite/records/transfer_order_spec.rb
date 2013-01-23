require 'spec_helper'

describe NetSuite::Records::TransferOrder do
  let(:order) { NetSuite::Records::TransferOrder.new }

  describe '.get' do
    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :tran_id => 1 }) }

      it 'returns a InventoryAdjustment instance populated with the data from the response object' do
        NetSuite::Actions::Get.should_receive(:call).with(NetSuite::Records::TransferOrder, :external_id => 1).and_return(response)
        adjustment = NetSuite::Records::TransferOrder.get(:external_id => 1)
        adjustment.should be_kind_of(NetSuite::Records::TransferOrder)
        adjustment.tran_id.should == 1
      end


    end
  end
end
