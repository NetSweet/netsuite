require 'spec_helper'

describe NetSuite::Actions::AddList do
  before { savon.mock! }
  after { savon.unmock! }

  context 'Customers' do
    context 'one customer' do
      let(:customers) do
        [
          NetSuite::Records::Customer.new(external_id: 'ext2', entity_id: 'Target', company_name: 'Target')
        ]
      end

      before do
        savon.expects(:add_list).with(:message =>
          {
            'record' => [{
              'listRel:entityId'    => 'Target',
              'listRel:companyName' => 'Target',
              '@xsi:type' => 'listRel:Customer',
              '@externalId' => 'ext2'
            }]
          }).returns(File.read('spec/support/fixtures/add_list/add_list_one_customer.xml'))
      end

      it 'makes a valid request to the NetSuite API' do
        NetSuite::Actions::AddList.call(customers)
      end

      it 'returns a valid Response object' do
        response = NetSuite::Actions::AddList.call(customers)
        expect(response).to be_kind_of(NetSuite::Response)
        expect(response).to be_success
      end
    end

    context 'two customers' do
      let(:customers) do
        [
          NetSuite::Records::Customer.new(external_id: 'ext1', entity_id: 'Shutter Fly', company_name: 'Shutter Fly, Inc.'),
          NetSuite::Records::Customer.new(external_id: 'ext2', entity_id: 'Target', company_name: 'Target')
        ]
      end

      before do
        savon.expects(:add_list).with(:message =>
          {
            'record' => [{
                'listRel:entityId'    => 'Shutter Fly',
                'listRel:companyName' => 'Shutter Fly, Inc.',
                '@xsi:type' => 'listRel:Customer',
                '@externalId' => 'ext1'
              },
              {
                'listRel:entityId'    => 'Target',
                'listRel:companyName' => 'Target',
                '@xsi:type' => 'listRel:Customer',
                '@externalId' => 'ext2'
              }
            ]
          }).returns(File.read('spec/support/fixtures/add_list/add_list_customers.xml'))
      end

      it 'makes a valid request to the NetSuite API' do
        NetSuite::Actions::AddList.call(customers)
      end

      it 'returns a valid Response object' do
        response = NetSuite::Actions::AddList.call(customers)
        expect(response).to be_kind_of(NetSuite::Response)
        expect(response).to be_success
      end
    end
  end

  context 'with errors' do
    let(:customers) do
      [
        NetSuite::Records::Customer.new(external_id: 'ext1-bad', entity_id: 'Shutter Fly', company_name: 'Shutter Fly, Inc.'),
        NetSuite::Records::Customer.new(external_id: 'ext2-bad', entity_id: 'Target', company_name: 'Target')
      ]
    end

    before do
      savon.expects(:add_list).with(:message =>
        {
          'record' => [{
            'listRel:entityId'    => 'Shutter Fly',
            'listRel:companyName' => 'Shutter Fly, Inc.',
            '@xsi:type' => 'listRel:Customer',
            '@externalId' => 'ext1-bad'
          },
          {
            'listRel:entityId'    => 'Target',
            'listRel:companyName' => 'Target',
            '@xsi:type' => 'listRel:Customer',
            '@externalId' => 'ext2-bad'
          }
          ]
        }).returns(File.read('spec/support/fixtures/add_list/add_list_with_errors.xml'))
    end

    it 'constructs error objects' do
      response = NetSuite::Actions::AddList.call(customers)
      expect(response.errors.keys).to match_array(['ext1', 'ext2'])
      expect(response.errors['ext1'].first.code).to eq('USER_ERROR')
      expect(response.errors['ext1'].first.message).to eq('Please enter value(s) for: Item')
      expect(response.errors['ext1'].first.type).to eq('ERROR')
    end
  end
end
