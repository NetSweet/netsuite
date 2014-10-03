require 'spec_helper'

describe NetSuite::Actions::Initialize do
  before(:all) { savon.mock! }
  after(:all) { savon.unmock! }

  let(:customer) { NetSuite::Records::Customer.new(:internal_id => 1) }

  before do
    savon.expects(:initialize).with(:message => {
      'platformMsgs:initializeRecord' => {
        'platformCore:type' => 'customer',
        'platformCore:reference' => {},
        :attributes! => {
          'platformCore:reference' => {
            'internalId' => 1,
            :type        => 'customer'
          }
        }
      }
    }).returns(File.read('spec/support/fixtures/initialize/initialize_invoice_from_customer.xml'))
  end

  it 'makes a valid request to the NetSuite API' do
    NetSuite::Actions::Initialize.call([NetSuite::Records::Customer, customer])
  end

  it 'returns a valid Response object' do
    response = NetSuite::Actions::Initialize.call([NetSuite::Records::Customer, customer])
    response.should be_kind_of(NetSuite::Response)
    response.should be_success
  end

end
