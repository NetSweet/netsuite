require 'spec_helper'

describe NetSuite::Records::InventoryAssignment do
  let(:item) { NetSuite::Records::InventoryAssignment.new }

  it 'has all the right fields' do
    [
      :expiration_date, :quantity, :quantity_available, :receipt_inventory_number
    ].each do |field|
      expect(item).to have_field(field)
    end
  end

  it 'has all the right record refs' do
    [
      :bin_number, :issue_inventory_number, :to_bin_number, :inventory_status
    ].each do |record_ref|
      expect(item).to have_record_ref(record_ref)
    end
  end
end
