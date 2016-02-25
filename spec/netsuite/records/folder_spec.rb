require 'spec_helper'

describe NetSuite::Records::Folder do
  let(:folder) { NetSuite::Records::Folder.new }

  it 'has all the right fields' do
    [:name].each do |field|
      expect(folder).to have_field(field)
    end
  end

  it 'has all the right record refs' do
    [:parent].each do |record_ref|
      expect(folder).to have_record_ref(record_ref)
    end
  end

  describe '#add' do
    let(:test_data) { { :name => 'foo' } }

    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :internal_id => '1' }) }

      it 'returns true' do
        folder = NetSuite::Records::Folder.new(test_data)
        expect(NetSuite::Actions::Add).to receive(:call).
          with([folder], {}).
          and_return(response)
        expect(folder.add).to be_truthy
      end
    end
  end
end
