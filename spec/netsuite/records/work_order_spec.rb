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
      expect(work_order).to have_field(field)
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

  it 'includes TransactionSearchRowBasic for search_only_fields' do
    expect(work_order.is_a?(NetSuite::Searches::TransactionSearchRowBasic)).to be_truthy
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
      expect(work_order.custom_field_list).to be_kind_of(NetSuite::Records::CustomFieldList)
      expect(work_order.custom_field_list.custom_fields.length).to eql(1)
    end

    it 'can be set from a CustomFieldList object' do
      custom_field_list = NetSuite::Records::CustomFieldList.new
      work_order.custom_field_list = custom_field_list
      expect(work_order.custom_field_list).to eql(custom_field_list)
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
      expect(work_order.item_list).to be_kind_of(NetSuite::Records::WorkOrderItemList)
      expect(work_order.item_list.items.length).to eql(1)
    end

    it 'can be set from a WorkOrderItemList object' do
      order_item_list = NetSuite::Records::WorkOrderItemList.new
      work_order.item_list = order_item_list
      expect(work_order.item_list).to eq(order_item_list)
    end
  end

  describe '.get' do
    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :buildable => 100 }) }

      it 'returns a WorkOrder instance populated with the data from the response object' do
        expect(NetSuite::Actions::Get).to receive(:call).with([NetSuite::Records::WorkOrder, :external_id => 1], {}).and_return(response)
        salesorder = NetSuite::Records::WorkOrder.get(:external_id => 1)
        expect(salesorder).to be_kind_of(NetSuite::Records::WorkOrder)
        expect(salesorder.buildable).to eql(100)
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'raises a RecordNotFound exception' do
        expect(NetSuite::Actions::Get).to receive(:call).with([NetSuite::Records::WorkOrder, :external_id => 1], {}).and_return(response)
        expect {
          NetSuite::Records::WorkOrder.get(:external_id => 1)
        }.to raise_error(NetSuite::RecordNotFound,
          /NetSuite::Records::WorkOrder with OPTIONS=(.*) could not be found/)
      end
    end
  end
end
