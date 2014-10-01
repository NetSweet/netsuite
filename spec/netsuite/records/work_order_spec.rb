require 'spec_helper'

describe NetSuite::Records::WorkOrder do
  let(:work_order) { NetSuite::Records::WorkOrder.new }

  [
    :buildable, :built, :created_date, :end_date, :expanded_assembly, :firmed,
    :is_wip, :last_modified_date, :memo, :order_status, :partners_list,
    :quantity, :sales_team_list, :source_transaction_id,
    :source_transaction_line, :special_order, :start_date, :status, :tran_date,
    :tran_id
  ].each do |field|
    it "has the #{field} field" do
      work_order.should have_field(field)
    end
  end

  [
    :assembly_item, :created_from, :custom_form, :department,
    :entity, :job, :location, :manufacturing_routing, :revision, :subsidiary,
    :units
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

  describe '#item_list' do
    it 'can be set from attributes' do
      attributes = {
        item: {
          :averageCost => 10,
          :internal_id => 'itemAbc123'
        }
      }
      work_order.item_list = attributes
      work_order.item_list.should be_kind_of(NetSuite::Records::WorkOrderItemList)
      work_order.item_list.items.length.should eql(1)
    end

    it 'can be set from a WorkOrderItemList object' do
      order_item_list = NetSuite::Records::WorkOrderItemList.new
      work_order.item_list = order_item_list
      work_order.item_list.should eq(order_item_list)
    end
  end

  describe '.get' do
    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :buildable => 100 }) }

      it 'returns a WorkOrder instance populated with the data from the response object' do
        NetSuite::Actions::Get.should_receive(:call).with([NetSuite::Records::WorkOrder, :external_id => 1], {}).and_return(response)
        salesorder = NetSuite::Records::WorkOrder.get(:external_id => 1)
        salesorder.should be_kind_of(NetSuite::Records::WorkOrder)
        salesorder.buildable.should eql(100)
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'raises a RecordNotFound exception' do
        NetSuite::Actions::Get.should_receive(:call).with([NetSuite::Records::WorkOrder, :external_id => 1], {}).and_return(response)
        lambda {
          NetSuite::Records::WorkOrder.get(:external_id => 1)
        }.should raise_error(NetSuite::RecordNotFound,
          /NetSuite::Records::WorkOrder with OPTIONS=(.*) could not be found/)
      end
    end
  end
end
