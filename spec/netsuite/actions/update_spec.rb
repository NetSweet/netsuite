require 'spec_helper'

describe NetSuite::Actions::Update do

  context 'Customer' do
    let(:customer) do
      NetSuite::Records::Customer.new(:entity_id => 'Shutter Fly', :company_name => 'Shutter Fly, Inc.')
    end

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
      NetSuite::Actions::Update.call(customer)
    end

    it 'returns a valid Response object' do
      response = NetSuite::Actions::Update.call(customer)
      response.should be_kind_of(NetSuite::Response)
      response.should be_success
    end
  end

  context 'Invoice' do
    let(:invoice) do
      NetSuite::Records::Invoice.new(:source => 'Google', :total => 100.0)
    end

    before do
      pending
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
      NetSuite::Actions::Update.call(invoice)
    end

    it 'returns a valid Response object' do
      response = NetSuite::Actions::Update.call(invoice)
      response.should be_kind_of(NetSuite::Response)
      response.should be_success
    end
  end

end
