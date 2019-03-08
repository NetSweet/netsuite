require 'spec_helper'

describe NetSuite::Actions::Update do
  before(:all) { savon.mock! }
  after(:all) { savon.unmock! }

  context 'Customer' do
    let(:customer) { NetSuite::Records::Customer.new }
    let(:attributes) { { :entity_id => 'Shutter Fly', :company_name => 'Shutter Fly, Inc.' } }
    let(:message) do
      {
        'platformMsgs:record' => {
          :content! => {
            'listRel:entityId'    => 'Shutter Fly',
            'listRel:companyName' => 'Shutter Fly, Inc.',
          },
          '@xsi:type' => 'listRel:Customer'
        },
      }
    end

    describe 'updating the external ID' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :internal_id => '1' }) }

      # https://github.com/NetSweet/netsuite/pull/416
      #   if the external ID is set, and the external ID field is ommitted on an update, the external ID field does not change
      #   if the external_id field is set to nil, it should not be passed to netsuite
      #   passing an empty string to the external ID field does not remove it

      it 'does not pass the external ID to an update call if not modified or included in update options' do
        expect(NetSuite::Actions::Update).to receive(:call).
            with([customer.class, {}], {}).
            and_return(response)

        expect(customer.update).to be_truthy
      end

      it 'should update the external ID when the attribute on the record is set' do
        expect(NetSuite::Actions::Update).to receive(:call).
            with([customer.class, {external_id: 'foo'}], {}).
            and_return(response)

        customer.external_id = 'foo'
        expect(customer.update).to be_truthy
      end

      it 'should update the external ID to nil when the attribute on the record is set' do
        expect(NetSuite::Actions::Update).to receive(:call).
            with([customer.class, {external_id: nil}], {}).
            and_return(response)

        expect(customer.update(external_id: nil)).to be_truthy
      end

      it 'should update the external ID to the options value not the attribute value' do
        expect(NetSuite::Actions::Update).to receive(:call).
            with([customer.class, {external_id: 'bar'}], {}).
            and_return(response)

        customer.external_id = 'foo'
        expect(customer.update(external_id: 'bar')).to be_truthy
      end
    end

    context 'when successful' do

      before do
        savon.expects(:update).with(:message => message).returns(File.read('spec/support/fixtures/update/update_customer.xml'))
      end

      it 'makes a valid request to the NetSuite API' do
        NetSuite::Actions::Update.call([NetSuite::Records::Customer, attributes])
      end

      it 'returns a valid Response object' do
        response = NetSuite::Actions::Update.call([NetSuite::Records::Customer, attributes])
        expect(response).to be_kind_of(NetSuite::Response)
        expect(response).to be_success
      end

    end

    context 'when not successful' do

      before do
        savon.expects(:update).with(:message => message).returns(File.read('spec/support/fixtures/update/update_customer_error.xml'))
      end

      it 'provides an errors method on the object with details about the errors' do
        customer.update(attributes)
        error = customer.errors.first

        expect(error).to be_kind_of(NetSuite::Error)
        expect(error.type).to eq('ERROR')
        expect(error.code).to eq('INSUFFICIENT_PERMISSION')
        expect(error.message).to eq('You do not have permissions to set a value for element addrtext due to one of the following reasons: 1) The field is read-only; 2) An associated feature is disabled; 3) The field is available either when a record is created or updated, but not in both cases.')
      end

      it 'provides an errors method on the response' do
        response = NetSuite::Actions::Update.call([NetSuite::Records::Customer, attributes])
        expect(response.errors.first).to be_kind_of(NetSuite::Error)
      end

    end

    context 'when not successful with multiple errors' do

      before do
        savon.expects(:update).with(:message => message).returns(File.read('spec/support/fixtures/update/update_customer_multiple_errors.xml'))
      end

      it 'provides an errors method on the object with details about the errors' do
        customer.update(attributes)
        expect(customer.errors.length).to eq(2)

        first_error = customer.errors.first
        expect(first_error).to be_kind_of(NetSuite::Error)
        expect(first_error.type).to eq('ERROR')
        expect(first_error.code).to eq('First error code')
        expect(first_error.message).to eq('First error message')

        second_error = customer.errors.last
        expect(second_error).to be_kind_of(NetSuite::Error)
        expect(second_error.type).to eq('WARNING')
        expect(second_error.code).to eq('Second error code')
        expect(second_error.message).to eq('Second error message')

      end
    end

  end

end
