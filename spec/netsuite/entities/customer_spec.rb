require 'spec_helper'

describe NetSuite::Customer do
  let(:customer) { NetSuite::Customer.new }

  describe '.get' do
    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :is_person => true }) }

      it 'returns a Customer instance populated with the data from the response object' do
        NetSuite::Actions::Get.should_receive(:call).with(1).and_return(response)
        customer = NetSuite::Customer.get(1)
        customer.should be_kind_of(NetSuite::Customer)
        customer.is_person.should be_true
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'returns a Customer instance populated with the data from the response object' do
        NetSuite::Actions::Get.should_receive(:call).with(1).and_return(response)
        lambda {
          NetSuite::Customer.get(1)
        }.should raise_error(NetSuite::RecordNotFound, 'NetSuite::Customer with ID=1 could not be found')
      end
    end
  end

  describe '#add' do
    let(:test_data) { { :entity_name => 'TEST CUSTOMER', :is_person => true } }

    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :internal_id => '1' }) }

      it 'returns true' do
        NetSuite::Actions::Add.should_receive(:call).
            with(test_data).
            and_return(response)
        customer = NetSuite::Customer.new(test_data)
        customer.add.should be_true
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }
      it 'returns false' do
        NetSuite::Actions::Add.should_receive(:call).
            with(test_data).
            and_return(response)
        customer = NetSuite::Customer.new(test_data)
        customer.add.should be_false
      end
    end
  end

  describe '#method_missing' do
    context 'when calling a method that exists as an attribute' do
      it 'returns the right value from the attributes hash' do
        customer = NetSuite::Customer.new(:name => 'Mr. Banana')
        customer.name.should eql('Mr. Banana')
      end
    end

    context 'when calling a method that does not exist in the attributes hash' do
      it 'raises a NoMethodError' do
        lambda {
          customer.banana
        }.should raise_error(NoMethodError)
      end
    end
  end

end
