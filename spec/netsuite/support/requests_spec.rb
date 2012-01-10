require 'spec_helper'

describe NetSuite::Support::Requests do
  let(:instance) do
    obj = Object.new
    obj.extend(NetSuite::Support::Requests)
    obj
  end

  describe '#call' do
    before do
      instance.stub(:request)
      instance.stub(:success?)
      instance.stub(:response_body)
    end

    it 'calls #request' do
      instance.should_receive(:request)
      instance.call
    end

    it 'calls #build_response' do
      instance.should_receive(:build_response)
      instance.call
    end

    it 'returns a NetSuite::Response object' do
      response = instance.call
      response.should be_kind_of(NetSuite::Response)
    end
  end

end
