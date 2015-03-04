require 'spec_helper'

describe NetSuite::Records::VendorBillExpenseList do
  let(:expense_list) { NetSuite::Records::VendorBillExpenseList.new }
  let(:expense) { NetSuite::Records::VendorBillExpense.new }

  it 'can be initialized with a hash' do
    expense_list = NetSuite::Records::VendorBillExpenseList.new(expense: {})
    expect(expense_list.expenses).to be_kind_of(Array)
    expect(expense_list.expenses.length).to eql(1)
    expect(expense_list.expenses[0]).to be_kind_of(NetSuite::Records::VendorBillExpense)
  end

  it 'can be initialized with a hash list' do
    expense_list = NetSuite::Records::VendorBillExpenseList.new(expense: [{}])
    expect(expense_list.expenses).to be_kind_of(Array)
    expect(expense_list.expenses.length).to eql(1)
    expect(expense_list.expenses[0]).to be_kind_of(NetSuite::Records::VendorBillExpense)
  end

  it 'can have expenses be added to it' do
    expense_list.expenses << expense
    expect(expense_list.expenses).to be_kind_of(Array)
    expect(expense_list.expenses.length).to eql(1)
    expect(expense_list.expenses[0]).to be_kind_of(NetSuite::Records::VendorBillExpense)
  end

  describe '#to_record' do
    it 'can represent itself as a SOAP record' do
      record = {
        'tranPurch:expense' => []
      }
      expect(expense_list.to_record).to eql(record)
    end
  end
end
