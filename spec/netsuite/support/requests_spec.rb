require 'spec_helper'

describe NetSuite::Support::Requests do
  let(:instance) do
    obj = Object.new
    obj.extend(NetSuite::Support::Requests)
    obj
  end

  describe '#call' do
    before do
      allow(instance).to receive(:request)
      allow(instance).to receive(:success?)
      allow(instance).to receive(:response_body)
    end

    it 'calls #request' do
      expect(instance).to receive(:request)
      instance.call
    end

    it 'calls #build_response' do
      expect(instance).to receive(:build_response)
      instance.call
    end

    it 'returns a NetSuite::Response object' do
      response = instance.call
      expect(response).to be_kind_of(NetSuite::Response)
    end
  end

end
