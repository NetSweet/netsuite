require 'spec_helper'

describe NetSuite::Records::ItemFulfillment do
  let(:item_fulfillment) { NetSuite::Records::ItemFulfillment.new }

  it 'has all the right fields' do
    [
      :tran_date, :tran_id, :shipping_cost, :memo, :ship_company, :ship_attention, :ship_addr1,
      :ship_addr2, :ship_city, :ship_state, :ship_zip, :ship_phone, :ship_is_residential,
      :ship_status, :last_modified_date, :handling_cost
    ].each do |field|
      expect(item_fulfillment).to have_field(field)
    end
  end

  it 'has all the right record refs' do
    [
      :custom_form, :entity, :created_from, :ship_carrier, :ship_method, 
        :ship_address_list, :klass, :ship_country
    ].each do |record_ref|
      expect(item_fulfillment).to have_record_ref(record_ref)
    end
  end  
end