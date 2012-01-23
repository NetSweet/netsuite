require 'spec_helper'

describe NetSuite::Records::CreditMemoItem do
  let(:item) { NetSuite::Records::CreditMemoItem.new }

# <element name="options" type="platformCore:CustomFieldList" minOccurs="0"/>
# <element name="inventoryDetail" type="platformCommon:InventoryDetail" minOccurs="0"/>
# <element name="customFieldList" type="platformCore:CustomFieldList" minOccurs="0"/>

  it 'has all the right fields' do
    [
      :amount, :bin_numbers, :cost_estimate, :cost_estimate_type, :defer_rev_rec, :description, :gift_cert_from,
      :gift_cert_message, :gift_cert_number, :gift_cert_recipient_email, :gift_cert_recipient_name, :gross_amt, :is_taxable,
      :line, :order_line, :quantity, :rate, :rev_rec_end_date, :rev_rec_start_date, :rev_rec_term_in_months, :serial_numbers,
      :tax1_amt, :tax_rate1, :tax_rate2, :vsoe_allocation, :vsoe_amount, :vsoe_deferral, :vsoe_delivered, :vsoe_permit_discount,
      :vsoe_price
    ].each do |field|
      item.should have_field(field)
    end
  end

  it 'has all the right record refs' do
    [
      :department, :item, :job, :klass, :location, :price, :rev_rec_schedule, :tax_code, :units
    ].each do |record_ref|
      item.should have_record_ref(record_ref)
    end
  end

end
