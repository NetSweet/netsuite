require 'spec_helper'

describe NetSuite::Actions::Update do

  context 'Customer' do
    let(:customer) { NetSuite::Records::Customer.new }
    let(:attributes) { { :entity_id => 'Shutter Fly', :company_name => 'Shutter Fly, Inc.' } }

    before do
      savon.expects(:update).with({
        'platformMsgs:record' => {
          'listRel:entityId'    => 'Shutter Fly',
          'listRel:companyName' => 'Shutter Fly, Inc.'
        },
        :attributes! => {
          'platformMsgs:baseRef' => {
            'xsi:type' => 'listRel:Customer'
          }
        }
      }).returns(:update_customer)
    end

    it 'makes a valid request to the NetSuite API' do
      NetSuite::Actions::Update.call(NetSuite::Records::Customer, attributes)
    end

    it 'returns a valid Response object' do
      response = NetSuite::Actions::Update.call(NetSuite::Records::Customer, attributes)
      response.should be_kind_of(NetSuite::Response)
      response.should be_success
    end
  end

  context 'Invoice' do
    let(:invoice) { NetSuite::Records::Invoice.new }
    let(:attributes) { { :source => 'Google', :total => 100.0 } }

    before do
      savon.expects(:update).with({
        'platformMsgs:record' => {
          'listRel:source' => 'Google',
          'listRel:total'  => 100.0
        },
        :attributes! => {
          'platformMsgs:baseRef' => {
            'xsi:type' => 'listRel:Invoice'
          }
        }
      }).returns(:update_invoice)
    end

    it 'makes a valid request to the NetSuite API' do
      NetSuite::Actions::Update.call(NetSuite::Records::Invoice, attributes)
    end

    it 'returns a valid Response object' do
      response = NetSuite::Actions::Update.call(NetSuite::Records::Invoice, attributes)
      response.should be_kind_of(NetSuite::Response)
      response.should be_success
    end
  end

end
