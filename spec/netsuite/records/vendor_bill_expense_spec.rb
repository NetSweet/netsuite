require 'spec_helper'

describe NetSuite::Records::VendorBillExpense do
  let(:expense) { NetSuite::Records::VendorBillExpense.new }

  it 'has the right fields' do
    [
      :amount, :amortization_end_date, :amortiz_start_date, :amortization_residual, :gross_amt, :is_billable,
      :line, :memo, :order_doc, :order_line, :tax_1_amt, :tax_rate_1, :tax_rate_2
    ].each do |field|
      expect(expense).to have_field(field)
    end
  end

  it 'has the right record_refs' do
    [
      :account, :amortization_sched, :klass, :category, :customer, :department, :location, :tax_code
    ].each do |record_ref|
      expect(expense).to have_record_ref(record_ref)
    end
  end

  it 'can initialize from a record' do
    record = NetSuite::Records::VendorBillExpense.new(:amount => 123)
    expense = NetSuite::Records::VendorBillExpense.new(record)
    expect(expense).to be_kind_of(NetSuite::Records::VendorBillExpense)
    expect(expense.amount).to eql(123)
  end

  describe '#custom_field_list' do
    it 'can be set from attributes' do
      attributes = {
        :custom_field => {
          :value => 10,
          :script_id => 'custfield_value'
        }
      }
      expense.custom_field_list = attributes
      expect(expense.custom_field_list).to be_kind_of(NetSuite::Records::CustomFieldList)
      expect(expense.custom_field_list.custom_fields.length).to eql(1)
      expect(expense.custom_field_list.custfield_value.attributes[:value]).to eq(10)
    end

    it 'can be set from a CustomFieldList object' do
      custom_field_list = NetSuite::Records::CustomFieldList.new
      expense.custom_field_list = custom_field_list
      expect(expense.custom_field_list).to eql(custom_field_list)
    end
  end

  describe '#to_record' do
    before do
      expense.amount = '123'
      expense.memo = 'a memo'
    end

    it 'can represent itself as a SOAP record' do
      record = {
        'tranPurch:amount' => '123',
        'tranPurch:memo' => 'a memo'
      }
      expect(expense.to_record).to eql(record)
    end
  end

  describe '#record_type' do
    it 'returns a string of the SOAP record type' do
      expect(expense.record_type).to eql('tranPurch:VendorBillExpense')
    end
  end

end
