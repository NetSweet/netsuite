require 'spec_helper'

describe NetSuite::Actions::Delete do
  before(:all) { savon.mock! }
  after(:all) { savon.unmock! }

  context 'Customer' do
    let(:customer) do
      NetSuite::Records::Customer.new(:internal_id => '980', :entity_id => 'Shutter Fly', :company_name => 'Shutter Fly, Inc.')
    end

    context 'when successful' do
      before do
        savon.expects(:delete).with(:message => {
          'platformMsgs:baseRef' => {
            '@internalId' => '980',
            '@type'       => 'customer',
            '@xsi:type'   => 'platformCore:RecordRef'
          },
        }).returns(File.read('spec/support/fixtures/delete/delete_customer.xml'))
      end

      it 'makes a valid request to the NetSuite API' do
        NetSuite::Actions::Delete.call([customer])
      end

      it 'returns a valid Response object' do
        response = NetSuite::Actions::Delete.call([customer])
        expect(response).to be_kind_of(NetSuite::Response)
        expect(response).to be_success
      end
    end

    context 'when not successful' do
      before do
        savon.expects(:delete).with(:message => {
          'platformMsgs:baseRef' => {
            '@xsi:type' => 'platformCore:RecordRef',
            '@internalId' => '980',
            '@type' => 'customer',
          },
        }).returns(File.read('spec/support/fixtures/delete/delete_customer_error.xml'))
      end

      it 'provides an error method on the object with details about the error' do
        customer.delete
        error = customer.errors.first

        expect(error).to be_kind_of(NetSuite::Error)
        expect(error.type).to eq('ERROR')
        expect(error.code).to eq('INSUFFICIENT_PERMISSION')
        expect(error.message).to eq("Permission Violation: You need a higher level of the 'Lists -> Documents and Files' permission to access this page. Please contact your account administrator.")
      end

      it 'provides an error method on the response' do
        response = NetSuite::Actions::Delete.call([customer])
        expect(response.errors.first).to be_kind_of(NetSuite::Error)
      end
    end

    context 'when not successful with multiple errors' do
      before do
        savon.expects(:delete).with(:message => {
          'platformMsgs:baseRef' => {
            '@xsi:type' => 'platformCore:RecordRef',
            '@internalId' => '980',
            '@type' => 'customer',
          },
        }).returns(File.read('spec/support/fixtures/delete/delete_customer_multiple_errors.xml'))
      end

      it 'provides an error method on the object with details about the error' do
        customer.delete
        expect(customer.errors.length).to eq(2)

        error = customer.errors.first

        expect(error).to be_kind_of(NetSuite::Error)
        expect(error.type).to eq('ERROR')
        expect(error.code).to eq('INSUFFICIENT_PERMISSION')
        expect(error.message).to eq("Permission Violation: You need a higher level of the 'Lists -> Documents and Files' permission to access this page. Please contact your account administrator.")

        error = customer.errors[1]

        expect(error).to be_kind_of(NetSuite::Error)
        expect(error.type).to eq('ERROR')
        expect(error.code).to eq('SOMETHING_ELSE')
        expect(error.message).to eq('Another error.')
      end
    end
  end

end
