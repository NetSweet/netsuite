require 'spec_helper'

describe NetSuite::Records::Department do
  let(:department) { NetSuite::Records::Department.new }

  it 'has all the right fields' do
    [
      :name, :is_inactive
    ].each do |field|
      expect(department).to have_field(field)
    end
  end

  it 'has all the right record refs' do
    [
      :parent
    ].each do |record_ref|
      expect(department).to have_record_ref(record_ref)
    end
  end

  describe '.get' do
    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :name => 'Department 1' }) }

      it 'returns a Department instance populated with the data from the response object' do
        expect(NetSuite::Actions::Get).to receive(:call).with([NetSuite::Records::Department, {:external_id => 1}], {}).and_return(response)
        department = NetSuite::Records::Department.get(:external_id => 1)
        expect(department).to be_kind_of(NetSuite::Records::Department)
        expect(department.name).to eql('Department 1')
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'raises a RecordNotFound exception' do
        expect(NetSuite::Actions::Get).to receive(:call).with([NetSuite::Records::Department, {:external_id => 1}], {}).and_return(response)
        expect {
          NetSuite::Records::Department.get(:external_id => 1)
        }.to raise_error(NetSuite::RecordNotFound,
          /NetSuite::Records::Department with OPTIONS=(.*) could not be found/)
      end
    end
  end

  describe '#add' do
    let(:test_data) { { :acct_name => 'Test Department', :description => 'An example Department' } }

    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :internal_id => '1' }) }

      it 'returns true' do
        department = NetSuite::Records::Department.new(test_data)
        expect(NetSuite::Actions::Add).to receive(:call).
            with([department], {}).
            and_return(response)
        expect(department.add).to be_truthy
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'returns false' do
        department = NetSuite::Records::Department.new(test_data)
        expect(NetSuite::Actions::Add).to receive(:call).
            with([department], {}).
            and_return(response)
        expect(department.add).to be_falsey
      end
    end
  end

  describe '#delete' do
    let(:test_data) { { :internal_id => '1' } }

    context 'when the response is successful' do
      let(:response)  { NetSuite::Response.new(:success => true, :body => { :internal_id => '1' }) }

      it 'returns true' do
        department = NetSuite::Records::Department.new(test_data)
        expect(NetSuite::Actions::Delete).to receive(:call).
            with([department], {}).
            and_return(response)
        expect(department.delete).to be_truthy
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'returns false' do
        department = NetSuite::Records::Department.new(test_data)
        expect(NetSuite::Actions::Delete).to receive(:call).
            with([department], {}).
            and_return(response)
        expect(department.delete).to be_falsey
      end
    end
  end

end
