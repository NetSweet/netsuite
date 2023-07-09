require 'spec_helper'

describe NetSuite::Records::InvoiceItem do
  let(:item) { NetSuite::Records::InvoiceItem.new }

  it 'has the right fields' do
    [
      :amount, :amount_ordered, :bin_numbers, :cost_estimate, :cost_estimate_type, :current_percent, :defer_rev_rec,
      :description, :gift_cert_from, :gift_cert_message, :gift_cert_number, :gift_cert_recipient_email,
      :gift_cert_recipient_name, :gross_amt, :inventory_detail, :is_taxable, :item_is_fulfilled, :license_code, :line,
      :options, :order_line, :percent_complete, :quantity, :quantity_available, :quantity_fulfilled, :quantity_on_hand,
      :quantity_ordered, :quantity_remaining, :rate, :rev_rec_end_date, :rev_rec_start_date, :serial_numbers, :ship_group,
      :tax1_amt, :tax_rate1, :tax_rate2, :vsoe_allocation, :vsoe_amount, :vsoe_deferral, :vsoe_delivered, :vsoe_permit_discount,
      :vsoe_price, :create_wo
    ].each do |field|
      expect(item).to have_field(field)
    end
  end

  it 'has the right record_refs' do
    [
      :department, :item, :job, :location, :price, :rev_rec_schedule, :ship_address, :ship_method, :tax_code, :units,
      :klass
    ].each do |record_ref|
      expect(item).to have_record_ref(record_ref)
    end
  end

  it 'can initialize from a record' do
    record = NetSuite::Records::InvoiceItem.new(:amount => 123, :cost_estimate => 234)
    item   = NetSuite::Records::InvoiceItem.new(record)
    expect(item).to be_kind_of(NetSuite::Records::InvoiceItem)
    expect(item.amount).to eql(123)
    expect(item.cost_estimate).to eql(234)
  end

  describe '#custom_field_list' do
    it 'can be set from attributes' do
      attributes = {
        :custom_field => {
          :value => 10,
          :script_id => 'custfield_value'
        }
      }
      item.custom_field_list = attributes
      expect(item.custom_field_list).to be_kind_of(NetSuite::Records::CustomFieldList)
      expect(item.custom_field_list.custom_fields.length).to eql(1)
      expect(item.custom_field_list.custfield_value.attributes[:value]).to eq(10)
    end

    it 'can be set from a CustomFieldList object' do
      custom_field_list = NetSuite::Records::CustomFieldList.new
      item.custom_field_list = custom_field_list
      expect(item.custom_field_list).to eql(custom_field_list)
    end
  end

  describe '#to_record' do
    before do
      item.amount      = '7'
      item.description = 'Some thingy'
    end

    it 'can represent itself as a SOAP record' do
      record = {
        'tranSales:amount'      => '7',
        'tranSales:description' => 'Some thingy'
      }
      expect(item.to_record).to eql(record)
    end
  end

  describe '#record_type' do
    it 'returns a string of the SOAP record type' do
      expect(item.record_type).to eql('tranSales:InvoiceItem')
    end
  end

end
