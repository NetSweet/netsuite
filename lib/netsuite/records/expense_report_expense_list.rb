module NetSuite
  module Records
    class ExpenseReportExpenseList
      include Support::Fields
      include Namespaces::TranEmp

      field :expense,     ExpenseReportExpense

    end
  end
end
