require 'spec_helper'

describe NetSuite::Actions::DeleteList do
  before(:all) { savon.mock! }
  after(:all) { savon.unmock! }

  context 'Customer' do
    let(:klass) { NetSuite::Records::Customer }
    let(:customer) do
      NetSuite::Records::Customer.new(:internal_id => '1', :entity_id => 'Customer', :company_name => 'Customer')
    end

    context 'without errors' do
      let(:other_customer) do
        NetSuite::Records::Customer.new(:internal_id => '2', :entity_id => 'Other_Customer', :company_name => 'Other Customer')
      end
      let(:customer_list) { [customer.internal_id, other_customer.internal_id] }

      before do
        savon.expects(:delete_list).with(:message =>
          {
            :baseRef =>
              [
                {
                  '@internalId' => customer.internal_id,
                  '@type'       => 'customer',
                  '@xsi:type'   => 'platformCore:RecordRef'
                },
                {
                  '@internalId' => other_customer.internal_id,
                  '@type'       => 'customer',
                  '@xsi:type'   => 'platformCore:RecordRef'
                }
              ]
          }
        ).returns(File.read('spec/support/fixtures/delete_list/delete_list_customers.xml'))
      end

      it 'makes a valid request to the NetSuite API' do
        NetSuite::Actions::DeleteList.call([klass, :list => customer_list])
      end

      it 'returns a valid Response object' do
        response = NetSuite::Actions::DeleteList.call([klass, :list => customer_list])

        expect(response).to be_kind_of(NetSuite::Response)
        expect(response).to be_success
      end
    end

    context 'with errors' do
      let(:customer_with_error) do
        NetSuite::Records::Customer.new(:internal_id => 'bad_id', :entity_id => 'Erroneous_Customer', :company_name => 'Erroneous Customer')
      end
      let(:customer_list_with_error) { [customer.internal_id, customer_with_error.internal_id] }

      before do
        savon.expects(:delete_list).with(:message =>
          {
            :baseRef =>
              [
                {
                  '@internalId' => customer.internal_id,
                  '@type'       => 'customer',
                  '@xsi:type'   => 'platformCore:RecordRef'
                },
                {
                  '@internalId' => customer_with_error.internal_id,
                  '@type'       => 'customer',
                  '@xsi:type'   => 'platformCore:RecordRef'
                }
              ]
          }
        ).returns(File.read('spec/support/fixtures/delete_list/delete_list_customers_with_errors.xml'))
      end

      it 'constructs error objects' do
        response = NetSuite::Actions::DeleteList.call([klass, :list => customer_list_with_error])
        expect(response.errors.keys).to match_array(customer_with_error.internal_id)
        expect(response.errors[customer_with_error.internal_id].first.code).to eq('USER_EXCEPTION')
        expect(response.errors[customer_with_error.internal_id].first.message).to eq('Invalid record: type=event,id=100015,scompid=TSTDRV96')
        expect(response.errors[customer_with_error.internal_id].first.type).to eq('ERROR')
      end
    end
  end
end
