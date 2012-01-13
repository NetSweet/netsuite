require 'spec_helper'

describe NetSuite::Actions::Get do

  describe 'Customer' do
    before do
      savon.expects(:get).with({
        'platformMsgs:baseRef' => {},
        :attributes! => {
          'platformMsgs:baseRef' => {
            :externalId => 1,
            :type       => 'customer',
            'xsi:type'  => 'platformCore:RecordRef'
          }
        }
      }).returns(:get_customer)
    end

    it 'makes a valid request to the NetSuite API' do
      NetSuite::Actions::Get.call(NetSuite::Records::Customer, :external_id => 1)
    end

    it 'returns a valid Response object' do
      response = NetSuite::Actions::Get.call(NetSuite::Records::Customer, :external_id => 1)
      response.should be_kind_of(NetSuite::Response)
    end
  end

  describe 'Invoice' do
    before do
      savon.expects(:get).with({
        'platformMsgs:baseRef' => {},
        :attributes! => {
          'platformMsgs:baseRef' => {
            :externalId => 10,
            :type       => 'invoice',
            'xsi:type'  => 'platformCore:RecordRef'
          }
        }
      }).returns(:get_invoice)
    end

    it 'makes a valid request to the NetSuite API' do
      NetSuite::Actions::Get.call(NetSuite::Records::Invoice, :external_id => 1)
    end

    it 'returns a valid Response object' do
      response = NetSuite::Actions::Get.call(NetSuite::Records::Invoice, :external_id => 1)
      response.should be_kind_of(NetSuite::Response)
    end
  end

end
