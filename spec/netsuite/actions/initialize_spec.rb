require 'spec_helper'

describe NetSuite::Actions::Initialize do
  let(:customer) { NetSuite::Entities::Customer.new(:internal_id => 1) }

  before do
    savon.expects(:initialize).with({
      'platformMsgs:initializeRecord' => {
        'platformCore:type' => 'invoice',
        'platformCore:reference' => {
          'platformCore:name' => 'Ryan Moran'
        },
        :attributes! => {
          'platformCore:reference' => {
            'internalId' => '1',
            :type        => 'customer'
          }
        }
      }
    }).returns(:initialize_invoice_from_customer)
  end

  it 'makes a valid request to the NetSuite API' do
    NetSuite::Actions::Initialize.call(customer)
  end

  it 'returns a valid Response object' do
    response = NetSuite::Actions::Initialize.call(customer)
    response.should be_kind_of(NetSuite::Response)
    response.should be_success
  end

end
