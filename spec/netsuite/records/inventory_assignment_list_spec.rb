require 'spec_helper'

describe NetSuite::Records::InventoryAssignmentList do
  let(:list) { NetSuite::Records::InventoryAssignmentList.new }

  it 'has an assignments attribute' do
    expect(list.inventory_assignment).to be_kind_of(Array)
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
      expect(list.to_record).to eql(record)
    end

    it 'can represent replacing all' do
      list.replace_all = true

      record = {
        'platformCommon:inventoryAssignment' => [{
          'platformCommon:quantity' => 1
        }],
        :@replaceAll => true,
      }

      expect(list.to_record).to eql(record)
    end

    it 'accepts a false replacing all' do
      list = NetSuite::Records::InventoryAssignmentList.new(
        :inventory_assignment => {
          :quantity => 1
        },
        :replace_all => true,
      )
      list.replace_all = false

      record = {
        'platformCommon:inventoryAssignment' => [{
          'platformCommon:quantity' => 1
        }],
        :@replaceAll => false,
      }

      expect(list.to_record).to eql(record)
    end
  end
end
