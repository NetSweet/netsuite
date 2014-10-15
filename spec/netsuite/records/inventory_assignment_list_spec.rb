require 'spec_helper'

describe NetSuite::Records::InventoryAssignmentList do
  let(:list) { NetSuite::Records::InventoryAssignmentList.new }

  it 'has an assignments attribute' do
    list.inventory_assignment.should be_kind_of(Array)
  end

  describe '#to_record' do
    before do
      list.inventory_assignment << NetSuite::Records::InventoryAssignment.new(
        :quantity => 1
      )
    end

    it 'can represent itself as a SOAP record' do

      record = {
        'platformCommon:inventoryAssignment' => [{
          'platformCommon:quantity' => 1
        }]
      }
      list.to_record.should eql(record)
    end

    it 'can represent replacing all' do
      list.replace = true

      record = {
        'platformCommon:inventoryAssignment' => [{
          'platformCommon:quantity' => 1
        }],
        :@replaceAll => true,
      }

      list.to_record.should eql(record)
    end

  end
end
