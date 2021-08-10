require 'spec_helper'

describe NetSuite::Records::ExpenseReportExpenseList do
  let(:list) { NetSuite::Records::ExpenseReportExpenseList.new }

  it 'has a custom_fields attribute' do
    expect(list.expense).to be_kind_of(Array)
  end

  describe '#to_record' do
    before do
      list.expense << NetSuite::Records::ExpenseReportExpense.new(:memo => 'This is a memo')
    end

    it 'can represent itself as a SOAP record' do
      record = 
        {
          'tranEmp:expense' => [{
            'tranEmp:memo' => 'This is a memo'
          }]
        }
      expect(list.to_record).to eql(record)
    end
  end

end
