require 'spec_helper'

describe NetSuite::Records::Classification do
  let(:classification) { NetSuite::Records::Classification.new }

  it 'has all the right fields' do
    [
      :name, :include_children, :is_inactive, :class_translation_list
    ].each do |field|
      expect(classification).to have_field(field)
    end

    expect(classification.subsidiary_list.class).to eq(NetSuite::Records::RecordRefList)
    expect(classification.custom_field_list.class).to eq(NetSuite::Records::CustomFieldList)
  end

  it 'has all the right record refs' do
    [
      :parent
    ].each do |record_ref|
      expect(classification).to have_record_ref(record_ref)
    end
  end

  describe '.get' do
    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :name => 'Retail' }) }

      it 'returns an Invoice instance populated with the data from the response object' do
        expect(NetSuite::Actions::Get).to receive(:call).with([NetSuite::Records::Classification, {:external_id => 10}], {}).and_return(response)
        invoice = NetSuite::Records::Classification.get(:external_id => 10)
        expect(invoice).to be_kind_of(NetSuite::Records::Classification)
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'raises a RecordNotFound exception' do
        expect(NetSuite::Actions::Get).to receive(:call).with([NetSuite::Records::Classification, {:external_id => 10}], {}).and_return(response)
        expect {
          NetSuite::Records::Classification.get(:external_id => 10)
        }.to raise_error(NetSuite::RecordNotFound,
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
        expect(NetSuite::Actions::Delete).to receive(:call).
            with([classification], {}).
            and_return(response)
        expect(classification.delete).to be_truthy
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'returns false' do
        classification = NetSuite::Records::Classification.new(test_data)
        expect(NetSuite::Actions::Delete).to receive(:call).
            with([classification], {}).
            and_return(response)
        expect(classification.delete).to be_falsey
      end
    end
  end

end
