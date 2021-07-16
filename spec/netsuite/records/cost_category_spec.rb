require 'spec_helper'

describe NetSuite::Records::CostCategory do
  let(:cost_category) { described_class.new }

  it 'has all the right fields' do
    [
      :is_inactive,
      :item_cost_type,
      :name,
    ].each do |field|
      expect(cost_category).to have_field(field)
    end
  end

  it 'has all the right record refs' do
    [
      :account,
    ].each do |record_ref|
      expect(cost_category).to have_record_ref(record_ref)
    end
  end

  describe '.get' do
    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :name => 'CostCategory 1' }) }

      it 'returns a CostCategory instance populated with the data from the response object' do
        expect(NetSuite::Actions::Get).to receive(:call).with([described_class, {:external_id => 1}], {}).and_return(response)
        cost_category = described_class.get(:external_id => 1)
        expect(cost_category).to be_kind_of(described_class)
        expect(cost_category.name).to eql('CostCategory 1')
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'raises a RecordNotFound exception' do
        expect(NetSuite::Actions::Get).to receive(:call).with([described_class, {:external_id => 1}], {}).and_return(response)
        expect {
          described_class.get(:external_id => 1)
        }.to raise_error(NetSuite::RecordNotFound,
          /NetSuite::Records::CostCategory with OPTIONS=(.*) could not be found/)
      end
    end
  end

  describe '#add' do
    let(:test_data) { { :name => 'Test CostCategory' } }

    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :internal_id => '1' }) }

      it 'returns true' do
        cost_category = described_class.new(test_data)
        expect(NetSuite::Actions::Add).to receive(:call).
            with([cost_category], {}).
            and_return(response)
        expect(cost_category.add).to be_truthy
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'returns false' do
        cost_category = described_class.new(test_data)
        expect(NetSuite::Actions::Add).to receive(:call).
            with([cost_category], {}).
            and_return(response)
        expect(cost_category.add).to be_falsey
      end
    end
  end

  describe '#delete' do
    let(:test_data) { { :internal_id => '1' } }

    context 'when the response is successful' do
      let(:response)  { NetSuite::Response.new(:success => true, :body => { :internal_id => '1' }) }

      it 'returns true' do
        cost_category = described_class.new(test_data)
        expect(NetSuite::Actions::Delete).to receive(:call).
            with([cost_category], {}).
            and_return(response)
        expect(cost_category.delete).to be_truthy
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'returns false' do
        cost_category = described_class.new(test_data)
        expect(NetSuite::Actions::Delete).to receive(:call).
            with([cost_category], {}).
            and_return(response)
        expect(cost_category.delete).to be_falsey
      end
    end
  end

end
