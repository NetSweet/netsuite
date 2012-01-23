require 'spec_helper'

describe NetSuite::Records::Classification do
  let(:classification) { NetSuite::Records::Classification.new }

  it 'has all the right fields' do
    [
      :name, :include_children, :is_inactive, :class_translation_list, :subsidiary_list, :custom_field_list
    ].each do |field|
      classification.should have_field(field)
    end
  end

  describe '.get' do
    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :name => 'Retail' }) }

      it 'returns an Invoice instance populated with the data from the response object' do
        NetSuite::Actions::Get.should_receive(:call).with(NetSuite::Records::Classification, :external_id => 10).and_return(response)
        invoice = NetSuite::Records::Classification.get(:external_id => 10)
        invoice.should be_kind_of(NetSuite::Records::Classification)
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'raises a RecordNotFound exception' do
        NetSuite::Actions::Get.should_receive(:call).with(NetSuite::Records::Classification, :external_id => 10).and_return(response)
        lambda {
          NetSuite::Records::Classification.get(:external_id => 10)
        }.should raise_error(NetSuite::RecordNotFound,
          /NetSuite::Records::Classification with OPTIONS=(.*) could not be found/)
      end
    end
  end

  describe '#delete' do
    let(:test_data) { { :internal_id => '1' } }

    context 'when the response is successful' do
      let(:response)  { NetSuite::Response.new(:success => true, :body => { :internal_id => '1' }) }

      it 'returns true' do
        classification = NetSuite::Records::Classification.new(test_data)
        NetSuite::Actions::Delete.should_receive(:call).
            with(classification).
            and_return(response)
        classification.delete.should be_true
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'returns false' do
        classification = NetSuite::Records::Classification.new(test_data)
        NetSuite::Actions::Delete.should_receive(:call).
            with(classification).
            and_return(response)
        classification.delete.should be_false
      end
    end
  end

end
