require 'spec_helper'

describe NetSuite::Actions::UpdateList do
  before { savon.mock! }
  after { savon.unmock! }

  context 'Items' do
    context 'one item' do
      let(:item) do
        [
          NetSuite::Records::InventoryItem.new(internal_id: '624113', item_id: 'Target', upccode: 'Target')
        ]
      end

      before do
        savon.expects(:update_list).with(:message =>
          {
            'record' => [{
              'listAcct:itemId' => 'Target',
              '@xsi:type' => 'listAcct:InventoryItem',
              '@internalId' => '624113'
            }]
          }).returns(File.read('spec/support/fixtures/update_list/update_list_one_item.xml'))
      end

      it 'makes a valid request to the NetSuite API' do
        NetSuite::Actions::UpdateList.call(item)
      end

      it 'returns a valid Response object' do
        response = NetSuite::Actions::UpdateList.call(item)
        expect(response).to be_kind_of(NetSuite::Response)
        expect(response).to be_success
      end
    end

    context 'two items' do
      let(:items) do
        [
          NetSuite::Records::InventoryItem.new(internal_id: '624172', item_id: 'Shutter Fly', upccode: 'Shutter Fly, Inc.'),
          NetSuite::Records::InventoryItem.new(internal_id: '624113', item_id: 'Target', upccode: 'Target')
        ]
      end

      before do
        savon.expects(:update_list).with(:message =>
          {
            'record' => [{
                'listAcct:itemId' => 'Shutter Fly',
                '@xsi:type' => 'listAcct:InventoryItem',
                '@internalId' => '624172'
              },
              {
                'listAcct:itemId' => 'Target',
                '@xsi:type' => 'listAcct:InventoryItem',
                '@internalId' => '624113'
              }
            ]
          }).returns(File.read('spec/support/fixtures/update_list/update_list_items.xml'))
      end

      it 'makes a valid request to the NetSuite API' do
        NetSuite::Actions::UpdateList.call(items)
      end

      it 'returns a valid Response object' do
        response = NetSuite::Actions::UpdateList.call(items)
        expect(response).to be_kind_of(NetSuite::Response)
        expect(response).to be_success
      end
    end
  end

  context 'with errors' do
    let(:items) do
      [
        NetSuite::Records::InventoryItem.new(internal_id: '624172-bad', item_id: 'Shutter Fly', upccode: 'Shutter Fly, Inc.'),
        NetSuite::Records::InventoryItem.new(internal_id: '624113-bad', item_id: 'Target', upccode: 'Target')
      ]
    end

    before do
      savon.expects(:update_list).with(:message =>
        {
          'record' => [{
            'listAcct:itemId' => 'Shutter Fly',
            '@xsi:type' => 'listAcct:InventoryItem',
            '@internalId' => '624172-bad'
          },
          {
            'listAcct:itemId' => 'Target',
            '@xsi:type' => 'listAcct:InventoryItem',
            '@internalId' => '624113-bad'
          }
          ]
        }).returns(File.read('spec/support/fixtures/update_list/update_list_with_errors.xml'))
    end

    it 'constructs error objects' do
      response = NetSuite::Actions::UpdateList.call(items)
      expect(response.errors.keys).to match_array(['624172', '624113'])
      expect(response.errors['624172'].first.code).to eq('USER_ERROR')
      expect(response.errors['624172'].first.message).to eq('Please enter value(s) for: ItemId')
      expect(response.errors['624172'].first.type).to eq('ERROR')
    end
  end
end
