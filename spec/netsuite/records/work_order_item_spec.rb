require 'spec_helper'

describe NetSuite::Records::WorkOrderItem do
  let(:work_order) { NetSuite::Records::WorkOrderItem.new }

  [
    :average_cost, :bom_quantity, :commit, :component_yield, :contribution,
    :create_po, :create_wo, :description, :inventory_detail,
    :last_purchase_price, :line, :order_priority, :percent_complete, :po_rate,
    :quantity, :quantity_available, :quantity_back_ordered,
    :quantity_committed, :quantity_on_hand, :serial_numbers
  ].each do |field|
    it "has the #{field} field" do
      work_order.should have_field(field)
    end
  end

  [
    :department, :item, :location, :po_vender, :units
  ].each do |record_ref|
    it 'has the #{record_ref} record ref' do
      expect(work_order).to have_record_ref(record_ref)
    end
  end

  describe '#custom_field_list' do
    it 'can be set from attributes' do
      attributes = {
        :custom_field => {
          :value => 10,
          :internal_id => 'custfield_something'
        }
      }
      work_order.custom_field_list = attributes
      work_order.custom_field_list.should be_kind_of(NetSuite::Records::CustomFieldList)
      work_order.custom_field_list.custom_fields.length.should eql(1)
    end

    it 'can be set from a CustomFieldList object' do
      custom_field_list = NetSuite::Records::CustomFieldList.new
      work_order.custom_field_list = custom_field_list
      work_order.custom_field_list.should eql(custom_field_list)
    end
  end
end
