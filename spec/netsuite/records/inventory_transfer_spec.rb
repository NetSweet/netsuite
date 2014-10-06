require 'spec_helper'

describe NetSuite::Records::InventoryTransfer do
  let(:inventory_transfer) { NetSuite::Records::InventoryTransfer.new }

  it 'has all the right fields' do
    [
      :created_date, :last_modified_date, :tran_date, :tran_id, :memo
    ].each do |field|
      inventory_transfer.should have_field(field)
    end
  end

  it 'has all the right record refs' do
    [
      :posting_period, :location, :transfer_location, :department, :subsidiary
    ].each do |record_ref|
      inventory_transfer.should have_record_ref(record_ref)
    end
  end


  describe '#inventory_list' do
    it 'can be set from attributes' do
      attributes = {
        :inventory => [{
          :inventory_detail => {
            :custom_form => {
              internal_id: 1
            },
            :inventory_assignment_list => {
              :inventory_assignment => [{
                quantity: 3
              }]
            }
          }
        }]
      }
      inventory_transfer.inventory_list = attributes
      inventory_transfer.inventory_list.should be_kind_of(NetSuite::Records::InventoryTransferInventoryList)
      inventory_transfer.inventory_list.inventory.length.should eql(1)

      expect(
        inventory_transfer.inventory_list.inventory.first.inventory_detail.inventory_assignment_list.inventory_assignment.first.quantity
      ).to eq(3)

      expect(
        inventory_transfer.inventory_list.inventory.first.inventory_detail.custom_form.internal_id
      ).to eq(1)
    end

    it 'can be set from a InventoryTransferInventoryList object' do
      inventory_list = NetSuite::Records::InventoryTransferInventoryList.new
      inventory_transfer.inventory_list = inventory_list
      inventory_transfer.inventory_list.should eql(inventory_list)
    end
  end
end
