require 'spec_helper'

describe NetSuite::Response do
  let(:response) { NetSuite::Response.new(:body => test_body) }
  let(:test_body) { { :banana => 'sandwich' } }

  describe '#initialize' do
    it 'allows the body to be set through a :body option' do
      response  = NetSuite::Response.new(:body => test_body)
      expect(response.body).to eql(test_body)
    end

    it 'allows the success status to be set through a :success option' do
      response = NetSuite::Response.new(:success => true, :body => test_body)
      expect(response).to be_success
    end

    context 'when a non-SOAP compliant responce is returned' do
      it 'raises an error' do
        expect { NetSuite::Response.new(:body => "<div> I'm just a little website. </div>") }
            .to raise_error(NetSuite::InvalidResponseError)
      end
    end
  end

  describe '#body' do
    it 'returns the hash contents of the SOAP response body' do
      test_body_2   = { :test => false }
      response.body = test_body_2
      expect(response.body).to eql(test_body_2)
    end
  end

  describe '#success?' do
    it 'returns the success status of the response' do
      response.success!
      expect(response).to be_success
    end
  end

end
