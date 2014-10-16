require 'spec_helper'

describe NetSuite::Actions::Update do
  before(:all) { savon.mock! }
  after(:all) { savon.unmock! }

  context 'Customer' do
    let(:customer) { NetSuite::Records::Customer.new }
    let(:attributes) { { :entity_id => 'Shutter Fly', :company_name => 'Shutter Fly, Inc.' } }
    let(:message) do
      {
        'platformMsgs:record' => {
          :content! => {
            'listRel:entityId'    => 'Shutter Fly',
            'listRel:companyName' => 'Shutter Fly, Inc.',
          },
          '@xsi:type' => 'listRel:Customer'
        },
      }
    end


    context 'when successful' do

      before do
        savon.expects(:update).with(:message => message).returns(File.read('spec/support/fixtures/update/update_customer.xml'))
      end

      it 'makes a valid request to the NetSuite API' do
        NetSuite::Actions::Update.call([NetSuite::Records::Customer, attributes])
      end

      it 'returns a valid Response object' do
        response = NetSuite::Actions::Update.call([NetSuite::Records::Customer, attributes])
        response.should be_kind_of(NetSuite::Response)
        response.should be_success
      end

    end

    context 'when not successful' do

      before do
        savon.expects(:update).with(:message => message).returns(File.read('spec/support/fixtures/update/update_customer_error.xml'))
      end

      it 'provides an errors method on the object with details about the errors' do
        customer.update(attributes)
        error = customer.errors.first

        error.should be_kind_of(NetSuite::Error)
        error.type.should eq('ERROR')
        error.code.should eq('INSUFFICIENT_PERMISSION')
        error.message.should eq('You do not have permissions to set a value for element addrtext due to one of the following reasons: 1) The field is read-only; 2) An associated feature is disabled; 3) The field is available either when a record is created or updated, but not in both cases.')
      end

      it 'provides an errors method on the response' do
        response = NetSuite::Actions::Update.call([NetSuite::Records::Customer, attributes])
        response.errors.first.should be_kind_of(NetSuite::Error)
      end

    end

    context 'when not successful with multiple errors' do

      before do
        savon.expects(:update).with(:message => message).returns(File.read('spec/support/fixtures/update/update_customer_multiple_errors.xml'))
      end

      it 'provides an errors method on the object with details about the errors' do
        customer.update(attributes)
        customer.errors.length.should eq(2)

        first_error = customer.errors.first
        first_error.should be_kind_of(NetSuite::Error)
        first_error.type.should eq('ERROR')
        first_error.code.should eq('First error code')
        first_error.message.should eq('First error message')

        second_error = customer.errors.last
        second_error.should be_kind_of(NetSuite::Error)
        second_error.type.should eq('WARNING')
        second_error.code.should eq('Second error code')
        second_error.message.should eq('Second error message')

      end
    end

  end

end
