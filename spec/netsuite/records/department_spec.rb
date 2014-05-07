require 'spec_helper'

describe NetSuite::Records::Department do
  let(:department) { NetSuite::Records::Department.new }

  it 'has all the right fields' do
    [
      :name, :is_inactive
    ].each do |field|
      department.should have_field(field)
    end
  end

  it 'has all the right record refs' do
    [
      :parent
    ].each do |record_ref|
      department.should have_record_ref(record_ref)
    end
  end

  describe '.get' do
    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :name => 'Department 1' }) }

      it 'returns a Department instance populated with the data from the response object' do
        NetSuite::Actions::Get.should_receive(:call).with([NetSuite::Records::Department, {:external_id => 1}], {}).and_return(response)
        department = NetSuite::Records::Department.get(:external_id => 1)
        department.should be_kind_of(NetSuite::Records::Department)
        department.name.should eql('Department 1')
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'raises a RecordNotFound exception' do
        NetSuite::Actions::Get.should_receive(:call).with([NetSuite::Records::Department, {:external_id => 1}], {}).and_return(response)
        lambda {
          NetSuite::Records::Department.get(:external_id => 1)
        }.should raise_error(NetSuite::RecordNotFound,
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
        NetSuite::Actions::Add.should_receive(:call).
            with([department], {}).
            and_return(response)
        department.add.should be_true
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'returns false' do
        department = NetSuite::Records::Department.new(test_data)
        NetSuite::Actions::Add.should_receive(:call).
            with([department], {}).
            and_return(response)
        department.add.should be_false
      end
    end
  end

  describe '#delete' do
    let(:test_data) { { :internal_id => '1' } }

    context 'when the response is successful' do
      let(:response)  { NetSuite::Response.new(:success => true, :body => { :internal_id => '1' }) }

      it 'returns true' do
        department = NetSuite::Records::Department.new(test_data)
        NetSuite::Actions::Delete.should_receive(:call).
            with([department], {}).
            and_return(response)
        department.delete.should be_true
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'returns false' do
        department = NetSuite::Records::Department.new(test_data)
        NetSuite::Actions::Delete.should_receive(:call).
            with([department], {}).
            and_return(response)
        department.delete.should be_false
      end
    end
  end

end
