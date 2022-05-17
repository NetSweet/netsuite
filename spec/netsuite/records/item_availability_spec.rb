require 'spec_helper'

module NetSuite
  module Records
    describe ItemAvailability do
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

      it { expect(item_availability).to have_field(:item, InventoryItem) }
      it { expect(item_availability).to have_field(:location_id, Location) }
    end
  end
end
