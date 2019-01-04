require 'spec_helper'

describe NetSuite::Actions::GetAll do
  before(:all) { savon.mock!  }
  after(:all) { savon.unmock! }

  describe 'Currency' do
    context 'retrieving all' do
      let(:message) { { record: [ { record_type: "currency" } ] } }

      context 'when successful' do
        before do
          savon.expects(:get_all).with(message: message).returns(
            File.read('spec/support/fixtures/get_all/get_all_currencies.xml')
          )
        end

        it 'makes a valid request to the NetSuite API' do
          NetSuite::Actions::GetAll.call([NetSuite::Records::Currency])
        end

        it 'returns a valid Response object' do
          response = NetSuite::Actions::GetAll.call([NetSuite::Records::Currency])
          expect(response).to be_kind_of(NetSuite::Response)
        end
      end

      context 'when insufficient permissions' do
        let(:currency) { NetSuite::Records::Currency }
        let(:response) { currency.get_all({}) }

        before do
          savon.expects(:get_all).with(message: message).returns(
            File.read('spec/support/fixtures/get_all/get_all_insufficient_permissions.xml')
          )
        end

        it 'provides an error method on the object with details about the error' do
          response
          error = currency.errors.first

          expect(error).to be_kind_of(NetSuite::Error)
          expect(error.type).to eq('ERROR')
          expect(error.code).to eq('INSUFFICIENT_PERMISSION')
          expect(error.message).to eq(
            "Permission Violation: You need  the 'Lists -> Currency' permission to access this page. Please contact your account administrator."
          )
        end

        it 'provides an error method on the response' do
          response

          expect(currency.errors.first).to be_kind_of(NetSuite::Error)
          expect(response).to eq(false)
        end
      end
    end
  end
end
