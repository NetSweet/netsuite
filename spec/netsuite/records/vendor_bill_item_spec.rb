require 'spec_helper'

describe NetSuite::Records::VendorBillItem do
  let(:item) { NetSuite::Records::VendorBillItem.new }

  it 'has the right fields' do
    [
      :amortization_end_date, :amortization_residual, :amortiz_start_date, :bin_numbers,  :bill_variance_status,
      :description, :expiration_date, :gross_amt, :inventory_detail, :is_billable, :landed_cost, :line,
      :order_doc, :order_line, :quantity, :serial_numbers, :tax_rate_1, :tax_rate_2, :tax_1_amt, :vendor_name, :rate
    ].each do |field|
      expect(item).to have_field(field)
    end
  end

  it 'has the right record_refs' do
    [
      :amortization_sched, :klass, :customer, :department, :item, :landed_cost_category, :location, :tax_code, :units
    ].each do |record_ref|
      expect(item).to have_record_ref(record_ref)
    end
  end

  it 'has all the right read_only_fields' do
    [
      :amount
    ].each do |field|
      expect(NetSuite::Records::VendorBillItem).to have_read_only_field(field)
    end
  end

  it 'can initialize from a record' do
    record = NetSuite::Records::VendorBillItem.new(:gross_amt => 123, :description => 'some item')
    item   = NetSuite::Records::VendorBillItem.new(record)
    expect(item).to be_kind_of(NetSuite::Records::VendorBillItem)
    expect(item.gross_amt).to eql(123)
    expect(item.description).to eql('some item')
  end

  describe '#custom_field_list' do
    it 'can be set from attributes' do
      attributes = {
        :custom_field => {
          :value => 10,
          :internal_id => 'custfield_value'
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

  describe '#options' do
    it 'can be set from attributes' do
      attributes = {
        :custom_field => {
          :value => 10,
          :internal_id => 'custfield_value'
        }
      }
      item.options = attributes
      expect(item.options).to be_kind_of(NetSuite::Records::CustomFieldList)
      expect(item.options.custom_fields.length).to eql(1)
      expect(item.options.custfield_value.attributes[:value]).to eq(10)
    end

    it 'can be set from a CustomFieldList object' do
      custom_field_list = NetSuite::Records::CustomFieldList.new
      item.custom_field_list = custom_field_list
      expect(item.custom_field_list).to eql(custom_field_list)
    end
  end

  describe '#bill_receipts_list' do
    it 'can be set from attributes' do
      attributes = {
        :record_ref => {
          :internal_id => 'some id',
          :value => 'some value'
        }
      }
      item.bill_receipts_list = attributes
      expect(item.bill_receipts_list).to be_kind_of(NetSuite::Records::RecordRefList)
      expect(item.bill_receipts_list.record_ref.length).to eql(1)
      expect(item.bill_receipts_list.record_ref[0].value).to eq('some value')
    end
  end

  describe '#to_record' do
    before do
      item.gross_amt = '123'
      item.description = 'some item'
    end

    it 'can represent itself as a SOAP record' do
      record = {
        'tranPurch:grossAmt'   => '123',
        'tranPurch:description' => 'some item'
      }
      expect(item.to_record).to eql(record)
    end
  end

  describe '#record_type' do
    it 'returns a string of the SOAP record type' do
      expect(item.record_type).to eql('tranPurch:VendorBillItem')
    end
  end

end
