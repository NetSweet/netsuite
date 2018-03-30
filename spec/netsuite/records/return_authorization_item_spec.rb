require 'spec_helper'

describe NetSuite::Records::ReturnAuthorizationItem do
  let(:item) { NetSuite::Records::ReturnAuthorizationItem.new }

  it 'has all the right fields' do
    [
      :alt_sales_amt, :amortization_period, :amortization_type, :amount, :bill_variance_status, :catch_up_period, :cost_estimate,
      :cost_estimate_rate, :cost_estimate_type, :days_before_expiration, :defer_rev_rec, :description, :gift_cert_from, :gift_cert_message,
      :gift_cert_recipient_email, :gift_cert_recipient_name, :id, :inventory_detail, :is_closed, :is_drop_shipment, :is_taxable,
      :is_vsoe_bundle, :item_subtype, :item_type, :line, :line_number, :matrix_type, :options, :order_line, :print_items,
      :quantity, :quantity_billed, :quantity_received, :quantity_rev_committed, :rate, :rate_schedule, :rev_rec_end_date,
      :rev_rec_start_date, :tax_rate1, :vsoe_allocation, :vsoe_amount, :vsoe_deferral, :vsoe_delivered, :vsoe_is_estimate,
      :vsoe_permit_discount, :vsoe_price, :vsoe_sop_group
    ].each do |field|
      expect(item).to have_field(field)
    end
  end

  it 'has all the right record refs' do
    [
      :department, :item, :job, :klass, :location, :price, :rev_rec_schedule, :tax_code, :units
    ].each do |record_ref|
      expect(item).to have_record_ref(record_ref)
    end
  end

  describe '#options' do
    it 'can be set from attributes'
    it 'can be set from a CustomFieldList object'
  end

  describe '#inventory_detail' do
    it 'can be set from attributes'
    it 'can be set from an InventoryDetail object'
  end

  describe '#custom_field_list' do
    it 'can be set from attributes'
    it 'can be set from a CustomFieldList object'
  end

end
