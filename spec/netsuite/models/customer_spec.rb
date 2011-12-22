require 'spec_helper'

describe NetSuite::Customer do
  let(:customer) { NetSuite::Customer.new }

  describe '.get' do
    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :is_person => true }) }

      it 'returns a Customer instance populated with the data from the response object' do
        NetSuite::Actions::Customer::Get.should_receive(:call).with(1).and_return(response)
        customer = NetSuite::Customer.get(1)
        customer.should be_kind_of(NetSuite::Customer)
        customer.is_person.should be_true
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'returns a Customer instance populated with the data from the response object' do
        NetSuite::Actions::Customer::Get.should_receive(:call).with(1).and_return(response)
        lambda {
          NetSuite::Customer.get(1)
        }.should raise_error(NetSuite::RecordNotFound, 'NetSuite::Customer with ID=1 could not be found')
      end
    end
  end

  describe '#is_person' do
    context 'when the customer is a person' do
      it 'returns true' do
        customer = NetSuite::Customer.new(:is_person => true)
        customer.is_person.should be_true
      end
    end
  end

end
