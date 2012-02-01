require 'spec_helper'

describe NetSuite::Records::RevRecTemplate do
  let(:template) { NetSuite::Records::RevRecTemplate.new }

  it 'has all the right fields' do
    [
      :name, :is_inactive
    ].each do |field|
      template.should have_field(field)
    end
  end

  describe '.get' do
    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :name => 'A template' }) }

      it 'returns an RevRecTemplate instance populated with the data from the response object' do
        NetSuite::Actions::Get.should_receive(:call).with(NetSuite::Records::RevRecTemplate, :external_id => 10).and_return(response)
        template = NetSuite::Records::RevRecTemplate.get(:external_id => 10)
        template.should be_kind_of(NetSuite::Records::RevRecTemplate)
        template.name.should eql('A template')
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'raises a RecordNotFound exception' do
        NetSuite::Actions::Get.should_receive(:call).with(NetSuite::Records::RevRecTemplate, :external_id => 10).and_return(response)
        lambda {
          NetSuite::Records::RevRecTemplate.get(:external_id => 10)
        }.should raise_error(NetSuite::RecordNotFound,
          /NetSuite::Records::RevRecTemplate with OPTIONS=(.*) could not be found/)
      end
    end
  end

end
