require 'spec_helper'

describe NetSuite::Response do
  let(:response) { NetSuite::Response.new }

  describe '#initialize' do
    it 'allows the body to be set through a :body option' do
      test_body = { :banana => 'sandwich' }
      response  = NetSuite::Response.new(:body => test_body)
      expect(response.body).to eql(test_body)
    end

    it 'allows the success status to be set through a :success option' do
      response = NetSuite::Response.new(:success => true)
      expect(response).to be_success
    end

    it 'throws PermissionError when response failed to INSUFFICIENT_PERMISSION' do
      expect {
        NetSuite::Response.new(
          :success => false,
          :body => {
            status: {
              status_detail: {
                :@type => 'ERROR',
                :code => 'INSUFFICIENT_PERMISSION',
                :message => 'Permission Violation: The subsidiary restrictions on your role prevent you from seeing this record.'
              }
            }
          }
        )
      }.to raise_error(NetSuite::PermissionError)
    end
  end

  describe '#body' do
    it 'returns the hash contents of the SOAP response body' do
      test_body     = { :test => false }
      response.body = test_body
      expect(response.body).to eql(test_body)
    end
  end

  describe '#success?' do
    it 'returns the success status of the response' do
      response.success!
      expect(response).to be_success
    end
  end

end
