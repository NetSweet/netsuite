require 'spec_helper'

describe NetSuite::Records::RevRecTemplate do
  let(:template) { NetSuite::Records::RevRecTemplate.new }

  it 'has all the right fields' do
    [
      :name, :is_inactive
    ].each do |field|
      expect(template).to have_field(field)
    end
  end

  describe '.get' do
    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :name => 'A template' }) }

      it 'returns an RevRecTemplate instance populated with the data from the response object' do
        expect(NetSuite::Actions::Get).to receive(:call).with([NetSuite::Records::RevRecTemplate, :external_id => 10], {}).and_return(response)
        template = NetSuite::Records::RevRecTemplate.get(:external_id => 10)
        expect(template).to be_kind_of(NetSuite::Records::RevRecTemplate)
        expect(template.name).to eql('A template')
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'raises a RecordNotFound exception' do
        expect(NetSuite::Actions::Get).to receive(:call).with([NetSuite::Records::RevRecTemplate, :external_id => 10], {}).and_return(response)
        expect {
          NetSuite::Records::RevRecTemplate.get(:external_id => 10)
        }.to raise_error(NetSuite::RecordNotFound,
          /NetSuite::Records::RevRecTemplate with OPTIONS=(.*) could not be found/)
      end
    end
  end

end
