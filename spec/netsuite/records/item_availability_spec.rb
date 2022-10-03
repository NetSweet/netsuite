require 'spec_helper'

describe NetSuite::Records::ItemAvailability do
  before(:all) { savon.mock!  }
  after(:all) { savon.unmock! }

  let(:item_availability) { NetSuite::Records::ItemAvailability.new }

  it 'has all the right fields' do
    [
      :quantity_on_hand,
      :on_hand_value_mli,
      :reorder_point,
      :quantity_on_order,
      :quantity_committed,
      :quantity_available,
    ].each do |field|
      expect(item_availability).to have_field(field)
    end
  end

  it { expect(item_availability).to have_field(:item, NetSuite::Records::InventoryItem) }
  it { expect(item_availability).to have_field(:location_id, NetSuite::Records::Location) }

  describe 'get_item_availability' do
    let(:inventory_item_ref_list) { 
      NetSuite::Records::RecordRefList.new(
        record_ref: [
          NetSuite::Records::RecordRef.new(internal_id: 57)
        ]
      )
    }
    let(:result) { NetSuite::Records::ItemAvailability.get_item_availability(inventory_item_ref_list) }

    before do
      savon.expects(:get_item_availability).with(:message => {
        "platformMsgs:itemAvailabilityFilter" => {
          "platformCore:item"=>{"platformCore:recordRef"=>[{:@internalId=>57}]}
        }
      }).returns(File.read('spec/support/fixtures/get_item_availability/get_item_availability.xml'))
    end

    it 'returns ItemAvailability records' do
      expect(result).to be_kind_of(Array)
      expect(result).not_to be_empty
      expect(result[0]).to be_kind_of(NetSuite::Records::ItemAvailability)
      expect(result[0]).to have_attributes(
        item: be_kind_of(NetSuite::Records::InventoryItem),
        location_id: NetSuite::Records::Location,
        quantity_on_hand: '264.0',
        on_hand_value_mli: '129.36',
        reorder_point: '50.0',
        quantity_on_order: '0.0',
        quantity_committed: '0.0',
        quantity_available: '264.0',
      )
    end
  end
end
