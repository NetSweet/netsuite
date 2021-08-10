require 'spec_helper'

describe NetSuite::Records::ExpenseReportExpense do
  let(:expense) { NetSuite::Records::ExpenseReportExpense.new }

  it 'has all the right fields' do
    [
        :amount, :exchange_rate, :expense_date, :foreign_amount, :gross_amt, :is_billable, :is_non_reimburable,
        :line, :memo, :quantity, :rate, :receipt, :ref_number, :tax1_amt, :tax_rate1, :tax_rate2
    ].each do |field|
      expect(expense).to have_field(field)
    end
  end

  it 'has all the right record refs' do
    [
        :category, :klass, :currency, :customer, :department, :location, :tax_code, :exp_media_item
    ].each do |record_ref|
      expect(expense).to have_record_ref(record_ref)
    end
  end

  describe '#custom_field_list' do
    it 'can be set from attributes' do
      attributes = {
        :custom_field => {
          :amount => 10,
          :internal_id => 'custfield_amount'
        }
      }
      expense.custom_field_list = attributes
      expect(expense.custom_field_list).to be_kind_of(NetSuite::Records::CustomFieldList)
      expect(expense.custom_field_list.custom_fields.length).to eql(1)
    end

    it 'can be set from a CustomFieldList object' do
      custom_field_list = NetSuite::Records::CustomFieldList.new
      expense.custom_field_list = custom_field_list
      expect(expense.custom_field_list).to eql(custom_field_list)
    end
  end

  describe '#to_record' do
    let(:expense) { NetSuite::Records::ExpenseReportExpense.new(:memo => 'This is a memo', :is_billable => true) }

    it 'returns a hash of attributes that can be used in a SOAP request' do
      expect(expense.to_record).to eql({
        'tranEmp:memo'      => 'This is a memo',
        'tranEmp:isBillable' => true
      })
    end
  end

  describe '#record_type' do
    it 'returns a string type for the record to be used in a SOAP request' do
      expect(expense.record_type).to eql('tranEmp:ExpenseReportExpense')
    end
  end

end
