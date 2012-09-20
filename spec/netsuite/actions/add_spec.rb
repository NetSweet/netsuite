require 'spec_helper'

describe NetSuite::Actions::Add do

  context 'Customer' do
    let(:customer) do
      NetSuite::Records::Customer.new(:entity_id => 'Shutter Fly', :company_name => 'Shutter Fly, Inc.')
    end

    before do
      savon.expects(:add).with({
        'platformMsgs:record' => {
          'listRel:entityId'    => 'Shutter Fly',
          'listRel:companyName' => 'Shutter Fly, Inc.'
        },
        :attributes! => {
          'platformMsgs:record' => {
            'xsi:type' => 'listRel:Customer'
          }
        }
      }).returns(:add_customer)
    end

    it 'makes a valid request to the NetSuite API' do
      NetSuite::Actions::Add.call(customer)
    end

    it 'returns a valid Response object' do
      response = NetSuite::Actions::Add.call(customer)
      response.should be_kind_of(NetSuite::Response)
      response.should be_success
    end
  end

  context 'Invoice' do
    let(:invoice) do
      NetSuite::Records::Invoice.new(:source => 'Google', :total => 100.0)
    end

    before do
      savon.expects(:add).with({
        'platformMsgs:record' => {
          'tranSales:source' => 'Google'
        },
        :attributes! => {
          'platformMsgs:record' => {
            'xsi:type' => 'tranSales:Invoice'
          }
        }
      }).returns(:add_invoice)
    end

    it 'makes a valid request to the NetSuite API' do
      NetSuite::Actions::Add.call(invoice)
    end

    it 'returns a valid Response object' do
      response = NetSuite::Actions::Add.call(invoice)
      response.should be_kind_of(NetSuite::Response)
      response.should be_success
    end
  end

end
