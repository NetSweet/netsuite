require 'spec_helper'

describe NetSuite::Actions::Get do

  describe 'Customer' do
    before do
      savon.expects(:get).with({
        'platformMsgs:baseRef' => {},
        :attributes! => {
          'platformMsgs:baseRef' => {
            :internalId => 1,
            :type       => 'customer',
            'xsi:type'  => 'platformCore:RecordRef'
          }
        }
      }).returns(:get_customer)
    end

    it 'makes a valid request to the NetSuite API' do
      NetSuite::Actions::Get.call(1, NetSuite::Records::Customer)
    end

    it 'returns a valid Response object' do
      response = NetSuite::Actions::Get.call(1, NetSuite::Records::Customer)
      response.should be_kind_of(NetSuite::Response)
    end
  end

  describe 'Invoice' do
    before do
      savon.expects(:get).with({
        'platformMsgs:baseRef' => {},
        :attributes! => {
          'platformMsgs:baseRef' => {
            :internalId => 10,
            :type       => 'invoice',
            'xsi:type'  => 'platformCore:RecordRef'
          }
        }
      }).returns(:get_invoice)
    end

    it 'makes a valid request to the NetSuite API' do
      NetSuite::Actions::Get.call(1, NetSuite::Records::Invoice)
    end

    it 'returns a valid Response object' do
      response = NetSuite::Actions::Get.call(1, NetSuite::Records::Invoice)
      response.should be_kind_of(NetSuite::Response)
    end
  end

end
