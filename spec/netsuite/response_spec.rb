require 'spec_helper'

describe NetSuite::Response do
  let(:response) { NetSuite::Response.new }

  describe '#initialize' do
    it 'allows the body to be set through a :body option' do
      test_body = { :banana => 'sandwich' }
      response  = NetSuite::Response.new(:body => test_body)
      response.body.should eql(test_body)
    end

    it 'allows the success status to be set through a :success option' do
      response = NetSuite::Response.new(:success => true)
      response.should be_success
    end
  end

  describe '#body' do
    it 'returns the hash contents of the SOAP response body' do
      test_body     = { :test => false }
      response.body = test_body
      response.body.should eql(test_body)
    end
  end

  describe '#success?' do
    it 'returns the success status of the response' do
      response.success!
      response.should be_success
    end
  end

end
